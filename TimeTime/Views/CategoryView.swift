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
                    categoryLegend()
                } else if viewModel.selectedGraphType == "Camembert" {
                    pieChart()
                    categoryLegend()
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
                .foregroundStyle(data.category.color)
            }
        }
        .frame(height: 210)
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
    private func categoryLegend() -> some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(AppCategory.allCases, id: \.self) { category in
                HStack {
                    Circle()
                        .fill(category.color)
                        .frame(width: 10, height: 10)

                    Text(category.rawValue)
                        .font(.footnote)
                        .foregroundColor(.primary)

                    Spacer()
                }
            }
        }
        .padding()
    }

    @ViewBuilder
    private func pieChart() -> some View {
        Chart {
            ForEach(viewModel.totalByCategoryByLastDay, id: \.category) { data in
                let angleValue = data.totalHours
                let categoryColor = data.category.color
                let categoryName = data.category.rawValue

                SectorMark(
                    angle: .value("Temps", angleValue),
                    innerRadius: .ratio(0.5),
                    outerRadius: .ratio(1.0)
                )
                .foregroundStyle(categoryColor)
                .cornerRadius(0) // Ajout d'un léger arrondi

                // Annotation directement sur la partie colorée
                .annotation(position: .overlay) {
                    Text("\(Int(angleValue))h")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                }
            }
        }
        .frame(height: 210)
        .padding()
    }


    @ViewBuilder
    private func alertSection() -> some View {
        HStack {
            Image("garcon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 135)
            VStack {
                Spacer()

                Text("Vous pouvez accèder aux données par app de votre journée ci-dessous !")
                    .italic()
                    .font(.system(size: 16))
                    .lineSpacing(2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 5)
                    .multilineTextAlignment(.center)

                NavigationLink(destination: DetailsAppCategoryView()) {
                    Text("Découvrir")
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(hex: "#B64D6E"))
                        .cornerRadius(30)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 10)
    }
}
