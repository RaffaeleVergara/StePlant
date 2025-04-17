//
//  Data.swift
//  Piantina
//
//  Created by Gennaro Savarese on 08/04/25.
//

import Foundation
import Observation


@Observable
class Data {
    
    
    
    
    var onBoarding : [OnBoarding] = [
        OnBoarding(nome: "Skip", title: "Let’s Walk", headline: "StePlant transforms your steps into energy to grow your virtual plant.", image: "0"),
        OnBoarding(nome: "Skip", title: "Grow Your Plant", headline: "Take care of your plant by completing daily challenges and earn awesome rewards.", image: "4"),
        OnBoarding(nome: "Start", title: "View Stats", headline: "StePlant shows your walking stats and benefits, like fuel saved and CO₂ emissions avoided.", image: "grafico")
    ]
    
    
     
}

var myData = Data()
