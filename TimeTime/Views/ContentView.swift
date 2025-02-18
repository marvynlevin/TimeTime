//
//  ContentView.swift
//  TimeTime
//
//  Created by levin marvyn on 18/02/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .tabItem {
                Label("Accueil", systemImage: "list.dash")
            }
        
        HomeView()
            .tabItem {
                Label("Accueil", systemImage: "list.dash")
            }
        
        HomeView()
            .tabItem {
                Label("Accueil", systemImage: "list.dash")
            }
        
        HomeView()
            .tabItem {
                Label("Accueil", systemImage: "list.dash")
            }
    }
}



#Preview {
    ContentView()
}
