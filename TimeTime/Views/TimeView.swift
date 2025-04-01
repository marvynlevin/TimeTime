import SwiftUI
import Charts

struct TimeView: View {
    @StateObject private var timeVM = TimeViewModel()
    @StateObject private var categoryVM = CategoryViewModel()
    let graphTypes = ["Barre", "Courbe"]

    var body: some View {
        NavigationView {
            VStack {
                Image("logoTimeTime")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 70)
                    .padding(.vertical, 20)
                
                Picker("Type de graphique", selection: $timeVM.selectedGraphType) {
                    ForEach(graphTypes, id: \.self) { graph in
                        Text(graph)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // On affiche un ViewBuilder en fonction du type de graphe
                if timeVM.selectedGraphType == "Barre" {
                    barChartView()
                } else if timeVM.selectedGraphType == "Courbe" {
                    lineChartView()
                }

                alertSection()
            }
        }
    }

    @ViewBuilder
    private func barChartView() -> some View {
        Chart(timeVM.sortedDays, id: \.self) { day in
            BarMark(
                x: .value("Jour", day),
                y: .value("Durée", min(timeVM.timeForDay(day), 24))
            )
            .foregroundStyle(getBarColor(for: timeVM.timeForDay(day)))
        }
        .frame(height: 280)
        .padding()
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24]) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    if let duration = value.as(Int.self) {
                        Text("\(duration)h")
                    }
                }
            }
        }
        .padding(.vertical, 17)
    }

    @ViewBuilder
    private func lineChartView() -> some View {
        Chart {
            ForEach(timeVM.sortedDays, id: \.self) { day in
                if let duration = timeVM.timeData[day] {
                    LineMark(
                        x: .value("Jour", day),
                        y: .value("Durée", min(duration, 24))
                    )
                    .foregroundStyle(getCurveColor(for: duration))
                }
            }

            RuleMark(
                y: .value("Limite", categoryVM.dailyLimit)
            )
            .foregroundStyle(.black)
            .opacity(0.8)
            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 5]))
        }
        .frame(height: 280)
        .padding()
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24]) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    if let duration = value.as(Int.self) {
                        Text("\(duration)h")
                    }
                }
            }
        }
        .padding(.vertical, 17)
    }

    // TODO: lorsqu'on change la limite globale, les graphs ne se mettent pas à jour
    func getBarColor(for duration: Float) -> Color {
        let isUnderLimit = duration < categoryVM.dailyLimit
        print("Durée: \(duration), Limite: \(categoryVM.dailyLimit)")
        return isUnderLimit ? .gray : Color(hex: "#B64D6E")
    }
    
    func getCurveColor(for duration: Float) -> Color {
        let isUnderLimit = duration < categoryVM.dailyLimit
        return isUnderLimit ? .gray : Color(hex: "#B64D6E")
    }
    
    @ViewBuilder
    private func alertSection() -> some View {
        let totalUsage = timeVM.timeData.reduce(0) { $0 + $1.value }
        
        HStack {
            Image(alertImageName(for: totalUsage))
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 135)

            VStack {
                alertMessage(for: totalUsage)
                    .italic()
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .lineSpacing(2)
                    .padding(.horizontal, 5)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 7)
    }

    private func alertImageName(for totalUsage: Float) -> String {
        return "garcon"
    }

    @ViewBuilder
    private func alertMessage(for totalUsage: Float) -> some View {
        switch totalUsage {
        case 0..<categoryVM.dailyLimit:
            Text("Aujourd'hui vous avez ")
            + Text("respecté")
                .foregroundColor(Color(hex: "#0F9E05"))
            + Text(" votre limite de temps !")

        case 3..<categoryVM.dailyLimit+2:
            Text("Aujourd'hui, vous avez été ")
            + Text("un peu trop")
                .foregroundColor(Color(hex: "#DB0101"))
            + Text(" sur votre téléphone !")

        default:
            Text("Aujourd'hui, vous avez été ")
            + Text("beaucoup trop")
                .foregroundColor(Color(hex: "#DB0101"))
            + Text(" sur votre téléphone !")
        }
    }
}

#Preview {
    TimeView()
}
