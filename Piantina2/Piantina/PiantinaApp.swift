//
//  PiantinaApp.swift
//  Piantina
//
//  Created by Gennaro Savarese on 04/04/25.
//

import SwiftUI

@main
struct PiantinaApp: App {
    @StateObject private var healthKitManager = HealthKitManager()
  
   
    
    var body: some Scene {
        WindowGroup {
            //HomeView()
            ScrollToMainView()
                .onAppear {
                                    NotificationManager.shared.requestPermission()
                                    NotificationManager.shared.checkStepsAndNotify(healthStore: healthKitManager.healthStore)
                                }
        }
    }
}
