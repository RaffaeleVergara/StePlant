//
//  GraphStat.swift
//  Piantina
//
//  Created by Gennaro Savarese on 08/04/25.
//

import Foundation



struct DailyStat: Identifiable {
    var id: UUID = UUID()
    var day: String
    var moneySaved: Double
    var co2Saved: Double
    var fuelSaved: Double
    var healthBenefits: Double
    
    
}
