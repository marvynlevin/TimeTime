import SwiftUI

struct RowView: View {
    @StateObject private var categoryVM = CategoryViewModel()
    var app: Time
    @State private var showDetails = false

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(app.appName)
                        .font(.headline)
                    Text("\(Int(app.timeInHours))h \(Int((app.timeInHours - Float(Int(app.timeInHours))) * 60))min")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                ProgressView(value: app.timeInHours / categoryVM.totalTimeForLatestDay) // Suppose un max de 5h par jour
                    .progressViewStyle(LinearProgressViewStyle(tint: app.category.color))
                    .frame(width: 100)
            }
            .padding(.vertical, 5)
            .onTapGesture {
                withAnimation {
                    showDetails.toggle()
                }
            }

            if showDetails {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Détails d'utilisation")
                        .font(.headline)
                    Text("Nom de l'application : \(app.appName)")
                    Text("Catégorie : \(app.category.rawValue)")
                    Text("Temps total : \(Int(app.timeInHours))h \(Int((app.timeInHours - Float(Int(app.timeInHours))) * 60))min")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .transition(.slide)
            }
        }
        .padding(.horizontal)
    }
}



#Preview {
    VStack {
        RowView(app: Time(appName: "TikTok", date: "2025-02-24", timeInHours: 2.0, category: .socialMedia))
        RowView(app: Time(appName: "YouTube", date: "2025-02-25", timeInHours: 3.5, category: .video))
    }
}
