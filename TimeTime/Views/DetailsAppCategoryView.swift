import SwiftUI

struct DetailsAppCategoryView: View {
    @StateObject private var categoryVM = CategoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Applications utilisées")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)

            List(categoryVM.latestDayApps) { time in
                RowView(app: time)
            }
        }
        .padding(.bottom, 18)
        .navigationBarBackButtonHidden(true) // Cache le bouton de retour par défaut
            .navigationBarItems(leading: Button(action: {
                // Action quand tu appuies sur le bouton de retour personnalisé
                // Par exemple, revenir en arrière
                // Cela fonctionne car NavigationView gère l'état de la pile de navigation
                // avec la logique de NavigationLink
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left") // Icône de retour
                        .foregroundColor(Color(hex: "#B64D6E"))
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text("Temps par catégorie") // Ton texte personnalisé
                        .foregroundColor(Color(hex: "#B64D6E"))
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                }
            })
    }
}

#Preview {
    DetailsAppCategoryView()
}
