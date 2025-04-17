//
//  ScrollToMainView.swift
//  Piantina
//
//  Created by Gennaro Savarese on 09/04/25.
//

import SwiftUI

struct ScrollToMainView: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    //var isOnboarding: Bool = true
    
    var body: some View {
        if isOnboarding == false {
                     ContainerView()
                   } else {
                       GiocoView()
                   }
    }
}

#Preview {
    ScrollToMainView()
}
