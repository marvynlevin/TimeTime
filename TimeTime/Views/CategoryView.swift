import SwiftUI
import Charts

struct CategoryView: View {
    @StateObject private var viewModel = CategoryViewModel()
    let graphTypes = ["Barre", "Camembert"]

    var body: some View {
        NavigationView {
            VStack {
                Image("logoTimeTime")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 70)
                    .padding(.vertical, 20)

                Picker("Type de graphique", selection: $viewModel.selectedGraphType) {
                    ForEach(graphTypes, id: \.self) { graph in
                        Text(graph)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if viewModel.selectedGraphType == "Barre" {
                    stackedBarChart()
                } else if viewModel.selectedGraphType == "Camembert" {
                    pieChart()
                }

                Spacer()

                alertSection()
            }
        }
    }

    @ViewBuilder
    private func stackedBarChart() -> some View {
        Chart {
            ForEach(viewModel.groupedTimeData, id: \.day) { data in
                BarMark(
                    x: .value("Jour", data.day),
                    y: .value("Durée", min(data.totalHours, 24))
                )
                .foregroundStyle(data.category.color) // Utilisation des couleurs définies pour chaque catégorie
            }
        }
        .frame(height: 300)
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
    }

    @ViewBuilder
    private func pieChart() -> some View {
        Chart {
            ForEach(viewModel.totalByCategory, id: \.category) { data in
                SectorMark(
                    angle: .value("Temps", data.totalHours),
                    innerRadius: .ratio(0.5),
                    outerRadius: .ratio(1.0)
                )
                .foregroundStyle(data.category.color)
            }
        }
        .frame(height: 300)
        .padding()
    }

    @ViewBuilder
    private func alertSection() -> some View {
        let totalUsage = viewModel.timeData.reduce(0) { $0 + $1.timeInHours }

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
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
    }

    private func alertImageName(for totalUsage: Float) -> String {
        switch totalUsage {
        case 0..<90: return "garcon"
        case 90..<180: return "garcon"
        default: return "garcon"
        }
    }

    @ViewBuilder
    private func alertMessage(for totalUsage: Float) -> some View {
        switch totalUsage {
        case 0..<90:
            Text("Cette semaine vous avez ")
            + Text("respecté votre limite de temps")
                .foregroundColor(Color(hex: "#28A745"))
            + Text(" hebdomadaire ! Je suis fier de vous ^_^")

        case 90..<180:
            Text("Aujourd'hui, vous avez été ")
            + Text("un peu trop")
                .foregroundColor(Color(hex: "#F4A261"))
            + Text(" sur votre téléphone ! Essayez de faire une pause.")

        default:
            Text("Aujourd'hui, vous avez été ")
            + Text("beaucoup trop")
                .foregroundColor(Color(hex: "#E63946"))
            + Text(" sur votre téléphone ! Pensez à réduire cela.")
        }
    }
}
