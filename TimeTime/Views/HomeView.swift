import SwiftUI

struct HomeView: View {
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
                    
                    Spacer()
                }
                
                VStack {
                    Text("Votre temps aujourd'hui")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    HStack(spacing: 0) {
                        Text("5h")
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: "#B64D6E"))
                        Text(" 14min 24sec")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                    }
                    Text("C'est 1h 34min 12sec de ")
                        .foregroundColor(.black)
                    + Text("moins")
                        .foregroundColor(.green)
                    + Text(" que hier")
                        .foregroundColor(.black)

                }
                
                VStack {
                    Spacer()
                    Text("Vos catégories")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    HStack {
                        Text("5h 14min 24sec")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: "#B64D6E"))
                        Text("Spotify")
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                            .foregroundColor(Color(hex: "#B64D6E"))
                    }
                    HStack {
                        Text("52min")
                            .font(.system(size: 22))
                        Text("Waze")
                            .font(.system(size: 22))
                    }
                    HStack {
                        Text("48min")
                            .font(.system(size: 22))
                        Text("Instagram")
                            .font(.system(size: 22))
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 63)
                
                
                Spacer()// ici je voudrais pouvoir pousser le tout vers le bas comment faire ?
                
                HStack {
                    Image("garcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 135)
                    VStack {
                        Spacer()
                        
                        Text("Pour toutes informations complémentaires, vous pouvez accèder au manuel !")
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
}

#Preview {
    HomeView()
}
