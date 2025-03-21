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
                    Chart(viewModel.timeData) { data in
                        BarMark(
                            x: .value("Temps", data.timeUnit),
                            y: .value("Durée", min(data.duration, 24))
                        )
                        .foregroundStyle(getBarColor(for: data.duration))
                    }
                    .frame(height: 300)
                    .padding()
                    .chartYAxis {
                        AxisMarks(position: .leading) { value in
                            AxisValueLabel {
                                if let duration = value.as(Float.self), duration.truncatingRemainder(dividingBy: 2) == 0 {
                                    Text("\(Int(duration))h")
                                }
                            }
                        }
                    }
                }
                
                if viewModel.selectedGraphType == "Courbe" {
                    Chart(viewModel.timeData) { data in
                        LineMark(
                            x: .value("Temps", data.timeUnit),
                            y: .value("Durée", min(data.duration, 24))
                        )
                        .foregroundStyle(getCurveColor(for: data.duration))
                    }
                    .frame(height: 300)
                    .padding()
                    .chartYAxis {
                        AxisMarks(position: .leading) { value in
                            AxisValueLabel {
                                if let duration = value.as(Float.self), duration.truncatingRemainder(dividingBy: 2) == 0 {
                                    Text("\(Int(duration))h")
                                }
                            }
                        }
                    }
                }

                alertSection()
                    .padding()
                
                Spacer()
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
        .padding(.vertical, 20)
    }

    private func alertImageName(for totalUsage: Float) -> String {
        return "garcon"
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

#Preview {
    TimeView()
}
