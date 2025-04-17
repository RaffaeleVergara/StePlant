//
//  GiocoView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 10/04/25.
//

import SwiftUI

struct GiocoView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ChallengesView()
                .tag(0)
            HomeView()
                .tag(1)
            ContentView()
                .tag(3)
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}



#Preview {
    GiocoView()
}
