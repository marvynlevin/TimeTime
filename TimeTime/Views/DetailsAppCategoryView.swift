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
                    .listRowBackground(Color(hex: "#F1F1F1"))
            }
            .scrollContentBackground(.hidden)
        }
        .padding(.bottom, 18)
        .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "#B64D6E"))
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text("Temps par catégorie")
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
