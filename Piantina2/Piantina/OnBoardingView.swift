//
//  OnBoardingView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 09/04/25.
//

import SwiftUI

struct OnBoardingView: View {
    // MARK: - PROPERTIES
        
        var page : OnBoarding
        @State private var isAnimating: Bool = false
        
        // MARK: - BODY
        
        var body: some View {
          ZStack {
              Color.black.ignoresSafeArea()
              
        
              
              VStack(spacing: 20) {
                  
                  
                      
                      Image(page.image)
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .padding(.bottom, 80)
                          
                  
                  VStack(alignment: .leading, spacing: 8){
                      // FRUIT: TITLE
                      Text(page.title)
                          .foregroundColor(Color.white)
                          .font(.system(size: 40, weight: .bold, design: .default))
                          .foregroundColor(.white)
                      
                      
                      
                      Text(page.headline)
                          .font(.system(size: 20, weight: .regular, design: .default))
                          .foregroundColor(.white.opacity(0.6))
                          .padding(.bottom, 100)
                      
                  }// end VStack
                  .padding(.horizontal, 50)
                  
                  
                  
                
                  Spacer()
              
                  
                  
                  
                
                  
                  
                  
                
              
            } // VSTACK
          } // ZSTACK
          .overlay {
              VStack{
                  Spacer()
                  HStack{
                      Spacer()
                      StartButtonView(nome: page.nome)
                          .padding()
                      
                  }// end HStack
              }// end VStack
          }
          .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
              isAnimating = true
            }
          }
            
          
        }// end Body
        
    }


#Preview {
    OnBoardingView(page : myData.onBoarding[0])
}
