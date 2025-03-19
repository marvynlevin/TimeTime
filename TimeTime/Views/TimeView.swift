//
//  TimeView.swift
//  TimeTime
//
//  Created by levin marvyn on 11/03/2025.
//

import SwiftUI
import Charts

struct TimeView: View {
    @StateObject private var viewModel = TimeViewModel()
    let timeUnits = ["Jours", "Mois"]
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logoTimeTime")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 70)
                    .padding(.vertical, 20)
                
                // Picker pour sélectionner l'unité de temps
                Picker("Unité de temps", selection: $viewModel.selectedTimeUnit) {
                    ForEach(timeUnits, id: \.self) { unit in
                        Text(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // 📊 Graphique des données
                Chart(viewModel.timeData) { data in
                    BarMark(
                        x: .value("Temps", data.timeUnit),
                        y: .value("Durée", min(data.duration, 24)) // Limite à 24h max
                    )
                    .foregroundStyle(getBarColor(for: data.duration))
                }
                .frame(height: 300)
                .chartYAxis {
                    if viewModel.selectedTimeUnit == "Jours" {
                        AxisMarks(position: .leading, values: Array(stride(from: 0.0, through: 24.0, by: 2.0))) { value in
                            AxisValueLabel {
                                if let hourValue = value.as(Double.self) {
                                    Text("\(Int(hourValue))h") // Affichage en heures
                                }
                            }
                        }
                    } else { // Mode "Mois"
                        AxisMarks(position: .leading, values: Array(stride(from: 0.0, through: 30.0, by: 2.0))) { value in
                            AxisValueLabel {
                                if let dayValue = value.as(Double.self) {
                                    Text("\(Int(dayValue))j") // Affichage en jours
                                }
                            }
                        }
                    }
                }

                .padding()
                
                // Message d'alerte
                alertMessage()
                    .padding()
                
                Spacer()
            }
        }
    }
    
    // 🔹 Détermine la couleur des barres en fonction du temps d'utilisation
    func getBarColor(for duration: Float) -> Color {
        switch viewModel.selectedTimeUnit {
        case "Jours":
            return duration > 4 ? .pink : .gray
        case "Mois":
            return duration > 100 ? .pink : .gray
        default:
            return .gray
        }
    }
    
    // 🔹 Affiche un message d'alerte en fonction du temps total d'utilisation
    @ViewBuilder
    func alertMessage() -> some View {
        let totalUsage = viewModel.timeData.reduce(0) { $0 + $1.duration }
        
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.pink)
            
            if totalUsage > 180 {
                Text("📱 Aujourd'hui, vous avez été **beaucoup trop** sur votre téléphone ! Essayez de réduire cela.")
                    .font(.body)
                    .foregroundColor(.black)
            } else if totalUsage > 90 {
                Text("📱 Aujourd'hui, vous avez été **un peu trop** sur votre téléphone ! Essayez de faire une pause.")
                    .font(.body)
                    .foregroundColor(.black)
            } else {
                Text("🎉 Bravo ! Votre utilisation du téléphone est bien équilibrée.")
                    .font(.body)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    TimeView()
}
