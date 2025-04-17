import Foundation
import UserNotifications
import HealthKit

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    /// Richiede i permessi per le notifiche
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Errore nella richiesta di permessi per le notifiche: \(error.localizedDescription)")
            } else {
                print("Permessi notifiche: \(granted ? "Concessi" : "Negati")")
            }
        }
    }

    /// Controlla i passi e pianifica una notifica se non si raggiunge la soglia
    func checkStepsAndNotify(threshold: Int = 5000, healthStore: HKHealthStore) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            print("Tipo passi non disponibile")
            return
        }

        let startOfDay = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            
            if let error = error {
                print("Errore nel calcolo dei passi: \(error.localizedDescription)")
                return
            }
            
            let steps = Int(result?.sumQuantity()?.doubleValue(for: .count()) ?? 0)
            print("Passi totali oggi: \(steps)")
            
            if steps < threshold {
                self.scheduleReminderNotification()
            }
        }

        healthStore.execute(query)
    }

    /// Pianifica la notifica
    private func scheduleReminderNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Stay active!"
        content.body = "You took a few steps today. Go for a walk! 🚶‍♂️"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 14
        dateComponents.minute = 52

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Errore nella programmazione della notifica: \(error.localizedDescription)")
            }
        }
    }
}
