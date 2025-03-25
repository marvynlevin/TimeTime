import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Navigation basse
            TabView {
                HomeView()
                    .tabItem {
                        Label("Accueil", systemImage: "house")
                            .foregroundColor(.pink)
                    }
                
                TimeView()
                    .tabItem {
                        Label("Temps", systemImage: "hourglass")
                            .foregroundColor(.pink)
                    }
                
                CategoryView()
                    .tabItem {
                        Label("Catégories", systemImage: "chart.bar.fill")
                            .foregroundColor(.pink)
                    }
                
                SettingView()
                    .tabItem {
                        Label("Paramètres", systemImage: "gearshape")
                            .foregroundColor(.pink)
                    }
            }
            .accentColor(Color(hex: "#B64D6E"))
            .background(Color.white)
            .zIndex(1)
            
            // Style de la navigation basse
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.white.opacity(0))
                    .stroke(Color.black, lineWidth: 0.2)
                    .frame(height: 100)
                    .overlay(
                    Rectangle()
                        .stroke(Color.black.opacity(0.7), lineWidth: 1)
                        .blur(radius: 30)
                    )
                    .shadow(color: .black.opacity(0.8), radius:8, x:0, y:3)
            }
            .zIndex(80)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.pink.opacity(0.1))
    }
}



#Preview {
    ContentView()
}
