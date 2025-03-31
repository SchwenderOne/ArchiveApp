import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                // Benutzerprofil
                Section(header: Text("Profil")) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading) {
                            Text("Angemeldet als")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text("Benutzer")
                                .font(.headline)
                        }
                        .padding(.leading, 8)
                    }
                    .padding(.vertical, 8)
                }
                
                // App-Einstellungen
                Section(header: Text("App-Einstellungen")) {
                    NavigationLink(destination: Text("Einstellungen folgen...")) {
                        Label("Benachrichtigungen", systemImage: "bell")
                    }
                    
                    NavigationLink(destination: Text("Einstellungen folgen...")) {
                        Label("Erscheinungsbild", systemImage: "paintbrush")
                    }
                }
                
                // Datensicherheit
                Section(header: Text("Datensicherheit")) {
                    NavigationLink(destination: Text("Backup-Funktion folgt...")) {
                        Label("Backup erstellen", systemImage: "arrow.clockwise.icloud")
                    }
                    
                    NavigationLink(destination: Text("Verschlüsselung folgt...")) {
                        Label("Dokumente verschlüsseln", systemImage: "lock.shield")
                    }
                }
                
                // Über
                Section(header: Text("Über")) {
                    HStack {
                        Label("Version", systemImage: "info.circle")
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink(destination: Text("Datenschutzrichtlinien folgen...")) {
                        Label("Datenschutz", systemImage: "hand.raised")
                    }
                    
                    NavigationLink(destination: Text("Hilfe folgt...")) {
                        Label("Hilfe & Support", systemImage: "questionmark.circle")
                    }
                }
                
                // Abmelden (Platzhalter)
                Section {
                    Button(action: {
                        // Später: Hier werden wir die Abmelde-Funktionalität implementieren
                    }) {
                        HStack {
                            Spacer()
                            Text("Abmelden")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profil")
        }
    }
}

#Preview {
    ProfileView()
} 