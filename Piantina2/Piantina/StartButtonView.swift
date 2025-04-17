//
//  StartButtonView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 09/04/25.
//

import SwiftUI

struct StartButtonView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    //@State var isOnboarding: Bool?
    
    var nome : String
    
    
    
    // MARK: - BODY
    
    var body: some View {
      Button(action: {
          isOnboarding = true
      }) {
        HStack(spacing: 8) {
            Text(nome)
          
          Image(systemName: "arrow.right.circle")
            .imageScale(.large)
        }// end HStack
        .font(.system(size: 20, weight: .bold))
//        .foregroundColor(.black)
        .frame(width: 100, height: 50)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
      } //end BUTTON
      .accentColor(Color.white)
      .background(Color.green.clipShape(Capsule()).opacity(0.6))
      
    }// end Body
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView(nome: "nome")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}


#Preview {
    ContainerView()
}
