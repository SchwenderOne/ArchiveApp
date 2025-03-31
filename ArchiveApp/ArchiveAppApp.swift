//
//  ArchiveAppApp.swift
//  ArchiveApp
//
//  Created by Lucas Schwender Jain on 31.03.25.
//

import SwiftUI

@main
struct ArchiveAppApp: App {
    init() {
        setupAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setupAppearance() {
        // Konfiguriere die Navigationsleiste
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.customPrimary
        ]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.customPrimary
        ]
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        
        // Konfiguriere weitere globale Erscheinungsbilder
        UITableView.appearance().backgroundColor = .systemBackground
        UITableView.appearance().separatorColor = .separator
    }
}
