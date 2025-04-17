//
//  GraphView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 08/04/25.
//

import SwiftUI
import Charts

struct GraphView: View {
    @StateObject private var healthManager = HealthKitManager()
    var stat = myData
    @State private var startAnimation: Bool = true
    
    var body: some View {
        ZStack{
            
            
           
            
            
            VStack() {
                
                Chart {
                    
                    BarMark(
                        x: .value("Day", "Co2"),
                        y: .value("CO2", healthManager.getCO2Saved())
                    )
                    .foregroundStyle(Color.green.opacity(0.5))
                    .cornerRadius(10)
                    
                    BarMark(
                        x: .value("Day", "MoneySaved"),
                        y: .value("CO2", healthManager.getMoneySaved())
                    )
                    .foregroundStyle(Color.green.opacity(0.5))
                    .cornerRadius(10)
                    
                    BarMark(
                        x: .value("Day", "FuelSaved"),
                        y: .value("CO2", healthManager.getFuelSaved())
                    )
                    .foregroundStyle(Color.green.opacity(0.5))
                    .cornerRadius(10)
                    
                    BarMark(
                        x: .value("Day", "Health"),
                        y: .value("CO2", healthManager.calories)
                    )
                    .foregroundStyle(Color.green.opacity(0.5))
                    .cornerRadius(10)
                    
                    
                    /*LineMark(
                     x: .value("Day", stat.day),
                     y: .value("BPM", stat.dailyAverage)
                     )
                     .interpolationMethod(.catmullRom)
                     .lineStyle(StrokeStyle(lineWidth: 3))
                     .foregroundStyle(.green)
                     
                     PointMark(
                     x: .value("Day", stat.day),
                     y: .value("BPM", stat.dailyAverage)
                     )
                     .symbol {
                     Circle()
                     .fill(.green)
                     .frame(width: 10, height: 10)
                     .shadow(radius: 4)
                     }
                     }
                     }
                     .chartXAxis {
                     AxisMarks(preset: .aligned, position: .bottom){
                     AxisValueLabel()
                     .foregroundStyle(Color.black.opacity(0.6))
                     .font(.subheadline)
                     
                     }
                     }
                     .chartYAxis {
                     AxisMarks(position: .leading) {
                     AxisValueLabel()
                     .foregroundStyle(Color.black.opacity(0.6))
                     .font(.subheadline)
                     
                     }
                     }
                     .padding()
                     .frame(width: 360, height: 200, alignment: .center)
                     .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGray).opacity(0.7), Color.white.opacity(0.6)]),  startPoint: startAnimation ? .leading : .trailing,
                     endPoint: startAnimation ? .bottom : .top))
                     .cornerRadius(15)
                     */
                }
                .chartXAxis {
                AxisMarks(preset: .aligned, position: .bottom){
                AxisValueLabel()
                        .foregroundStyle(Color.white)
                
                }
                }
                .chartYAxis {
                AxisMarks(position: .leading) {
                AxisValueLabel()
                        .foregroundStyle(Color.white)
                .font(.subheadline)
                
                }
                }
                .padding()
                .frame(width: 350, height: 250)
                
                
            }
        }
        .background(content: {
            RoundedRectangle(cornerRadius: 16)
                .fill(Material.ultraThinMaterial)
                .preferredColorScheme(.dark)
        })
    }
    
}


#Preview {
    GraphView()
}
