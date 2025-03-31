import SwiftUI

struct CategoryLimitView: View {
    @StateObject private var categoryVM = CategoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCategory: AppCategory? = AppCategory.allCases.first
    
    var body: some View {
        VStack {
            Text("Limite temps par catégorie")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Sélectionnez une catégorie")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(AppCategory.allCases, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category.rawValue)
                                    .padding()
                                    .background(selectedCategory == category ? category.color : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding()
            
            if let category = selectedCategory {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Applications dans \(category.rawValue)")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(categoryVM.appsInCategory(category).sorted { $0.appName < $1.appName }, id: \.appName) { app in
                        HStack {
                            Text(app.appName)
                                .font(.body)
                                .frame(minWidth: 120)
                                .padding(.trailing, 10)
                            
                            
                            Stepper(value: Binding(
                                get: { categoryVM.appLimits[app.appName, default: 0] },
                                set: { newValue in
                                    categoryVM.updateAppLimit(for: app.appName, newLimit: newValue)
                                }
                            ), in: 0...12, step: 0.5) {
                                Text("\(Int(categoryVM.appLimits[app.appName, default: 0]))h\(String(format: "%02d", Int((categoryVM.appLimits[app.appName, default: 0] - Float(Int(categoryVM.appLimits[app.appName, default: 0]))) * 60)))min")
                                    .font(.body)
                                    .padding(.trailing, 10)
                                    .frame(minWidth: 90)
                            }
                            .frame(width: 120)
                            
                            Spacer()
                            
                            Toggle("", isOn: Binding(
                                get: { categoryVM.appLimits[app.appName, default: 0] > 0 },
                                set: { newValue in
                                    if newValue {
                                        categoryVM.appLimits[app.appName] = 1.0
                                    } else {
                                        categoryVM.appLimits.removeValue(forKey: app.appName)
                                    }
                                }
                            ))
                            .toggleStyle(SwitchToggleStyle(tint: categoryVM.appLimits[app.appName, default: 0] > 0 ? Color(hex: "#B64D6E") : Color(hex: "#838383")))
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            
            Button(action: {
                categoryVM.checkAppLimitExceeded()
            }) {
                Text("Vérifier les limites")
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
    CategoryLimitView()
}
