import SwiftUI
import Charts

struct TimeView: View {
    @StateObject private var viewModel = TimeViewModel()
    let graphTypes = ["Barre", "Courbe"]

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
                    barChartView()
                } else if viewModel.selectedGraphType == "Courbe" {
                    lineChartView()
                }

                alertSection()
                    .padding()
                
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func barChartView() -> some View {
        Chart(viewModel.timeData) { data in
            BarMark(
                x: .value("Temps", data.timeUnit),
                y: .value("Durée", min(data.duration, 24))
            )
            .foregroundStyle(getBarColor(for: data.duration))
        }
        .frame(height: 318)
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
    private func lineChartView() -> some View {
        Chart(viewModel.timeData) { data in
            LineMark(
                x: .value("Temps", data.timeUnit),
                y: .value("Durée", min(data.duration, 24))
            )
            .foregroundStyle(getCurveColor(for: data.duration))
        }
        .frame(height: 318)
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

    func getBarColor(for duration: Float) -> Color {
        return duration > 4 ? Color(hex: "#B64D6E") : .gray
    }
    
    func getCurveColor(for duration: Float) -> Color {
        return duration > 4 ? Color(hex: "#B64D6E") : .gray
    }
    
    @ViewBuilder
    private func alertSection() -> some View {
        let totalUsage = viewModel.timeData.reduce(0) { $0 + $1.duration }
        
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
    }

    private func alertImageName(for totalUsage: Float) -> String {
        return "garcon"
    }

    @ViewBuilder
    private func alertMessage(for totalUsage: Float) -> some View {
        switch totalUsage {
        case 0..<90:
            Text("Aujourd'hui vous avez ")
            + Text("respecté votre limite de temps")
                .foregroundColor(Color(hex: "#28A745"))
            + Text(" !")

        case 90..<180:
            Text("Aujourd'hui, vous avez été ")
            + Text("un peu trop")
                .foregroundColor(Color(hex: "#F4A261"))
            + Text(" sur votre téléphone !")

        default:
            Text("Aujourd'hui, vous avez été ")
            + Text("beaucoup trop")
                .foregroundColor(Color(hex: "#E63946"))
            + Text(" sur votre téléphone !")
        }
    }
}

#Preview {
    TimeView()
}
