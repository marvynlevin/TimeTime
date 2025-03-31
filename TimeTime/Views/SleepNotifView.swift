import SwiftUI

struct SleepNotifView: View {
        @StateObject private var categoryVM = CategoryViewModel()
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            VStack {
                Text("Notification heure coucher")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Notification du coucher")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    DatePicker("Choisir l'heure de coucher", selection: $categoryVM.sleepTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding()
                    
                    HStack {
                        Toggle(isOn: $categoryVM.isSleepNotificationEnabled) {
                            Text("")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color(hex: categoryVM.isSleepNotificationEnabled ? "#B64D6E" : "#838383")))
                        .onChange(of: categoryVM.isSleepNotificationEnabled) { value in
                            categoryVM.toggleSleepNotification()
                        }
                        .padding(.vertical, 10)
                        .padding(.trailing, 145)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)

                    Text("Activer ou désactiver la notification")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 5)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
                
                Spacer()

                Button(action: {
                    // pas d'action sur ce bouton :/
                }) {
                    Text("Pas besoin car automatique")
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
            .onDisappear {
                categoryVM.saveSettings()
            }
        }
    }

#Preview {
    SleepNotifView()
}
