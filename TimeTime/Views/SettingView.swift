import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("logoTimeTime")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 70)
                        .padding(.vertical, 20)
                    
                    Text("\"Maitrisez votre temps, optimisez votre vie.\"")
                    
                }

                VStack(spacing: 15) {
                    navigationButton(title: "Limite de temps d'écran", icon: "gear", destination: TimeLimitView())
                    navigationButton(title: "Limite de temps par catégorie", icon: "square.grid.2x2", destination: CategoryLimitView())
                    navigationButton(title: "Notification heure coucher", icon: "bell.badge", destination: SleepNotifView())
                    navigationButton(title: "Manuel d'utilisation", icon: "questionmark.circle", destination: ManualView())
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 44)
                
                HStack {
                    Image("garcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 135)
                    
                    VStack {
                        Spacer()
                        
                        Text("Pour toutes informations complémentaires, vous pouvez accéder au manuel !")
                            .italic()
                            .font(.system(size: 16))
                            .lineSpacing(2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 5)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            // code pour le bouton
                        } label: {
                            Text("Manuel")
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 2)
                                .background(Color(hex: "#B64D6E"))
                                .cornerRadius(30)
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
    
    private func navigationButton<Destination: View>(title: String, icon: String, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text(title)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#F1F1F1"))
            .cornerRadius(20)
        }
    }
}

#Preview {
    SettingView()
}
