import SwiftUI

struct TimeLimitView: View {
    @StateObject private var categoryVM = CategoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Limite de temps d'écran")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 10) {
                Text("Limite par jour")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    Text("\(Int(categoryVM.dailyLimit))h \(Int((categoryVM.dailyLimit - Float(Int(categoryVM.dailyLimit))) * 60))min")
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(width: 120)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            categoryVM.decreaseLimit()
                        }) {
                            Image(systemName: "minus")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30)
                        }
                        
                        Text("|")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            categoryVM.increaseLimit()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.vertical, 3)
                    .padding(.horizontal, 12)
                    .background(Color(hex: "#F1F1F1"))
                    .cornerRadius(8)
                    .padding(.trailing, 20)

                }
                .padding(.horizontal, 30)
            }
            .padding()
            
            Spacer()

            Button(action: {
                categoryVM.checkLimitExceeded()
            }) {
                Text("Vérifier la limite")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#B64D6E"))
                    .cornerRadius(15)
            }
            .padding()

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
                Text("Paramètres généraux")
                    .foregroundColor(Color(hex: "#B64D6E"))
                    .font(.system(size: 20))
                    .fontWeight(.medium)
            }
        })
    }
}

#Preview {
    TimeLimitView()
}
