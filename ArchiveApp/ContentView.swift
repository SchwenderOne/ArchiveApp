//
//  ContentView.swift
//  ArchiveApp
//
//  Created by Lucas Schwender Jain on 31.03.25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Übersicht", systemImage: "folder")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Label("Suche", systemImage: "magnifyingglass")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person")
                }
                .tag(2)
        }
        .accentColor(.customPrimary) // Verwende unsere neue Primärfarbe
        .onAppear {
            // Passe das Erscheinungsbild der Tab-Leiste an
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

#Preview {
    ContentView()
}
