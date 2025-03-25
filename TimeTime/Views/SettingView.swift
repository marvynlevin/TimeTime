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
                // ici on a 4 grands boutons gris qui prennent presque toute la largeur de l'ecran, arrondis a moitié, avec un logo a gauche du bouton et un texte a coté
                Spacer()

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
}

#Preview {
    SettingView()
}
