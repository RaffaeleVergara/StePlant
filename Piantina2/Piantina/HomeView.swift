//
//  HomeView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 10/04/25.
//

import SwiftUI
import HealthKit
import SwiftData

struct HomeView: View {
    @StateObject var hkManager = HealthKitManager()
    var data = myData

    var body: some View {
  
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(1.1), Color.green.opacity(0.7)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    Spacer().frame(height: 40)
                    
                    HStack {
                        Text("Cactus")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top,30)
                    }
                    
                    Spacer()
                    
                    // Bottone per test (puoi rimuoverlo se non serve più)
                    
                    ZStack {
                        VStack {
                            Image(getCactusImage(for: hkManager.steps))
                                .resizable()
                                .frame(width: 400, height: 400)
                                .padding(.top, 150)
                                .padding(.bottom, 40)
                            
                            Spacer()
                        }
                        
                        VStack {
                            Spacer()
                            Image("vaso")
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .frame(height: 330)
                                .padding(.bottom, -200)
                        }
                        
                        VStack {
                            Spacer()
                            Text("\(hkManager.steps)")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("steps")
                                .font(.system(size: 20))
                                .foregroundColor(.black.opacity(0.7))
                        }
                        .padding(.bottom, -60)
                    }
                    .padding(.bottom, 100)
                    
                    Spacer()
                    Spacer()
                    
                    
                            
                        }
                    }
                }
            }


    // MARK: - StatBlock View (modulare)
    @ViewBuilder
    func StatBlock(icon: String, title: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .font(.title)
                .padding()

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.leading, 40)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Material.ultraThinMaterial)
                .preferredColorScheme(.dark)
        )
        .cornerRadius(15)
    }

    func getCactusImage(for currentStep : Int) -> String {
        let cycleSteps = currentStep % 90000
        
        switch cycleSteps {
        case 0..<5000: return "cactus0"
        case 5000..<10000: return "cactus1"
        case 10000..<15000: return "cactus2"
        case 15000..<20000: return "cactus3"
        case 20000..<25000: return "cactus4"
        case 25000..<30000: return "cactus5"
        case 30000..<35000: return "bonsai0"
        case 35000..<40000: return "bonsai1"
        case 40000..<45000: return "bonsai2"
        case 45000..<50000: return "bonsai3"
        case 50000..<55000: return "bonsai4"
        case 55000..<60000: return "bonsai5"
        case 60000..<65000: return "girasole0"
        case 65000..<70000: return "girasole1"
        case 70000..<75000: return "girasole2"
        case 75000..<80000: return "girasole3"
        case 80000..<85000: return "girasole4"
        case 85000..<90000: return "girasole5"
        default: return "girasole5"
        }
    }



#Preview {
    HomeView()
}
