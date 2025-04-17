//
//  ContentView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 04/04/25.
//

import SwiftUI
import Charts
import SwiftData

struct ContentView: View {
    @StateObject private var healthManager = HealthKitManager()
    
    var graph = myData
    
    
    var body: some View {
      
           
            
            ZStack{
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(1.1), Color.green.opacity(0.7)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                
                VStack (alignment: .center) {
                    Spacer()
                    
                    
                    
                    Text("Statistics")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top,30)
                    
                    
                    
                    HStack{
                        Image(systemName: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")
                            .foregroundColor(.green)
                            .font(.title)
                            .padding()
                            
                        
                        
                        
                        VStack(alignment: .leading){
                            Text("Money saved")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("\(healthManager.getMoneySaved(), specifier: "%.2f") €")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }// end VStack
                        .padding(.leading, 40)
                        Spacer()
                    }// end HStack
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(content: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Material.ultraThinMaterial)
                            .preferredColorScheme(.dark)
                    })
                    .cornerRadius(15)
                    
                    
                    
                    HStack{
                        Image(systemName: "carbon.dioxide.cloud.fill")
                            .foregroundColor(.green)
                            .font(.title)
                            .padding()
                            
                        
                        
                        
                        VStack(alignment: .leading){
                            Text("CO2")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("\(healthManager.getCO2Saved(), specifier: "%.2f") g")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }// end VStack
                        .padding(.leading, 40)
                        Spacer()
                    }// end HStack
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(content: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Material.ultraThinMaterial)
                            .preferredColorScheme(.dark)
                    })
                    .cornerRadius(15)
                    
                    
                    HStack{
                        Image(systemName: "fuelpump.circle")
                            .foregroundColor(.green)
                            .font(.title)
                            .padding()
                            
                        
                        
                        
                        VStack(alignment: .leading){
                            Text("Saved Fuel")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("\(healthManager.getFuelSaved(), specifier: "%.2f") L")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }//end VStack
                        .padding(.leading, 40)
                        Spacer()
                    }// end HStack
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(content: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Material.ultraThinMaterial)
                            .preferredColorScheme(.dark)
                    })
                    .cornerRadius(15)
                    
                    
                    HStack{
                        Image(systemName: "dumbbell.fill")
                            .foregroundColor(.green)
                            .font(.title)
                            .padding()
                           
                        
                        
                        VStack(alignment: .leading){
                            Text("Health Benefits")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("\(healthManager.calories) KCal")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        } // end VStack
                        .padding(.leading, 40)
                        Spacer()
                    }// end HStack
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(content: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Material.ultraThinMaterial)
                            .preferredColorScheme(.dark)
                    })
                    .cornerRadius(15)
                    
                    
                    
                    
                    
                    Text("Report")
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .bold()
                        .padding(.top)
                    
                        GraphView()
                            .cornerRadius(15)
                            .padding(.horizontal)
                    
                        
                        
                    
                    
                    
                    
                    

                    
                    
                    
                    
                }// end VStack
                .padding()
            }// end ZStack
           
            
        
    }
}

/*
struct Graph: View {
    
    var stats = GraphStat()
    @State private var startAnimation: Bool = true
    
    var body: some View {
        VStack() {
            
            Chart {
                
                    BarMark(
                        x: .value("Day", stats.day),
                        y: .value("BPM", stats.dailyAverage)
                    )
                    .foregroundStyle(Color.white.opacity(0.7))
                    
                    
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
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(.systemGray).opacity(0.7), Color.white.opacity(0.6)]),  startPoint: startAnimation ? .leading : .trailing,
            endPoint: startAnimation ? .bottom : .top))
        }
    }




*/



#Preview {
    ContentView()
}





