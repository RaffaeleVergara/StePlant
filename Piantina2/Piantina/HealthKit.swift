import SwiftData
import SwiftUI
import HealthKit

// MARK: - Data Models
@Model
class HealthStats: Identifiable {
    
    var id: UUID
    var steps: Int
    var calories: Int
    var plantLevel: Int
    var date: Date
    var co2Saved: Double
    var fuelSaved: Double
    var moneySaved: Double
    
    init(steps: Int, calories: Int, plantLevel: Int, co2Saved: Double, fuelSaved: Double, moneySaved: Double, date: Date = Date()) {
        self.id = UUID()
        self.steps = steps
        self.calories = calories
        self.plantLevel = plantLevel
        self.co2Saved = co2Saved
        self.fuelSaved = fuelSaved
        self.moneySaved = moneySaved
        self.date = date
    }
}

@Model
class Badge: Identifiable {
    var id: UUID
    var name: String
    var targetSteps: Int
    
    init(name: String, targetSteps: Int) {
        self.id = UUID()
        self.name = name
        self.targetSteps = targetSteps
    }
}

// MARK: - HealthKit Manager
class HealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    @Published var isHealthKitAuthorized = false
    @Published var steps: Int = 0
    @Published var calories: Int = 0
    @Published var plantLevel: Int = 1
    
    // Use a proper ModelContainer and ModelContext
    private let modelContainer: ModelContainer
    private var modelContext: ModelContext
    
    init() {
    
        do {
            self.modelContainer = try ModelContainer(for: HealthStats.self, Badge.self)
            self.modelContext = ModelContext(self.modelContainer)
            requestHealthKitAuthorization()
        } catch {
            fatalError("Failed to create ModelContainer: \(error.localizedDescription)")
        }
    }
    
    // MARK: - HealthKit Authorization
    func requestHealthKitAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit not available on this device")
            return
        }
        
        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.isHealthKitAuthorized = true
                    self?.fetchHealthData()
                } else if let error = error {
                    print("HealthKit authorization error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Data Fetching
    func fetchHealthData() {
        fetchStepData()
        fetchCaloriesData()
    }
    
    private func fetchStepData() {
        guard isHealthKitAuthorized,
              let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        
        fetchTotalStepCount(for: stepCountType)
        setupStepCountObserver(for: stepCountType)
    }
    
    private func fetchCaloriesData() {
        guard isHealthKitAuthorized,
              let caloriesType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)
        else{
            return
        }
        
        fetchTotalCalories(for: caloriesType)
        setupCaloriesObserver(for: caloriesType)
    }
    
    // MARK: - Step Count
    private func fetchTotalStepCount(for stepCountType: HKQuantityType) {
        // Create date range for today
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { [weak self] _, result, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching step count: \(error.localizedDescription)")
                return
            }
            
            guard let sum = result?.sumQuantity() else {
                print("No step data found.")
                return
            }
            
            DispatchQueue.main.async {
                let totalSteps = Int(sum.doubleValue(for: HKUnit.count()))
                self.steps = totalSteps
                self.saveHealthStats()
            }
        }
        
        healthStore.execute(query)
    }
    
    private func setupStepCountObserver(for stepCountType: HKQuantityType) {
        let query = HKObserverQuery(sampleType: stepCountType, predicate: nil) { [weak self] _, completionHandler, error in
            if let error = error {
                print("Observer query error: \(error.localizedDescription)")
                completionHandler()
                return
            }
            
            self?.fetchTotalStepCount(for: stepCountType)
            completionHandler()
        }
        
        healthStore.execute(query)
        healthStore.enableBackgroundDelivery(for: stepCountType, frequency: .hourly) { success, error in
            if let error = error {
                print("Background delivery setup error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Calories
    private func fetchTotalCalories(for caloriesType: HKQuantityType) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: caloriesType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { [weak self] _, result, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching total calories: \(error.localizedDescription)")
                return
            }
            
            guard let sum = result?.sumQuantity() else {
                print("No calorie data found.")
                return
            }
            
            DispatchQueue.main.async {
                let totalCalories = Int(sum.doubleValue(for: HKUnit.kilocalorie()))
                self.calories = totalCalories
                self.saveHealthStats()
            }
        }
        
        healthStore.execute(query)
    }
    
    private func setupCaloriesObserver(for caloriesType: HKQuantityType) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: nil,
            options: .strictStartDate
        )
        
        let query = HKObserverQuery(sampleType: caloriesType, predicate: predicate) { [weak self] _, completionHandler, error in
            if let error = error {
                print("Observer query error: \(error.localizedDescription)")
                completionHandler()
                return
            }
            
            self?.fetchTotalCalories(for: caloriesType)
            completionHandler()
        }
        
        healthStore.execute(query)
        healthStore.enableBackgroundDelivery(for: caloriesType, frequency: .hourly) { success, error in
            if let error = error {
                print("Background delivery setup error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - SwiftData Operations
    func saveHealthStats() {
        print("Saving health data")
        
        // Calculate derived values
        let co2Saved = getCO2Saved()
        let fuelSaved = getFuelSaved()
        let moneySaved = getMoneySaved()
        
        // Save the health stats along with derived values
        let stats = HealthStats(
            steps: steps,
            calories: calories,
            plantLevel: plantLevel,
            co2Saved: co2Saved,
            fuelSaved: fuelSaved,
            moneySaved: moneySaved
        )
        
        modelContext.insert(stats)
        
        do {
            try modelContext.save()
            print("Data Saved!")
        } catch {
            print("Failed to save health stats: \(error.localizedDescription)")
        }
    }
    
    func saveBadge(name: String, targetSteps: Int) {
        print("Saving a new badge")
        
        let badge = Badge(name: name, targetSteps: targetSteps)
        modelContext.insert(badge)
        
        do {
            try modelContext.save()
            print("Badge Saved!")
        } catch {
            print("Failed to save badge: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Statistics Calculations
    func getCO2Saved() -> Double {
        return Double(steps) * 0.063
    }
    
    func getFuelSaved() -> Double {
        return Double(steps) * 0.0000595
    }
    
    func getMoneySaved() -> Double {
        return getFuelSaved() * 1.756
    }
}

// Estensione per Notification.Name
extension Notification.Name {
    static let healthDataUpdated = Notification.Name("HealthDataUpdatedNotification")
}

