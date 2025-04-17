//
//  ContainerView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 09/04/25.
//

import SwiftUI

struct ContainerView: View {
    
    var pages: [OnBoarding] = myData.onBoarding
    
    var body: some View {
        TabView {
            ForEach(pages[0...2]) { item in
                
                OnBoardingView(page: item)
            } // LOOP
        } // TAB
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}


#Preview {
    ContainerView()
}
