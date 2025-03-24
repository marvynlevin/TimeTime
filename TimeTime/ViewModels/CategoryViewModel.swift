import Foundation

struct TimeGroupKey: Hashable {
    let date: String
    let category: AppCategory
}

class CategoryViewModel: ObservableObject {
    @Published var selectedGraphType: String = "Barre"
    @Published var timeData: [Time] = Time.testData

    let daysOfWeek = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"]

    var groupedTimeData: [(day: String, category: AppCategory, totalHours: Float)] {
        let groupedDictionary = Dictionary(grouping: timeData) { TimeGroupKey(date: $0.date, category: $0.category) }

        var result: [(day: String, category: AppCategory, totalHours: Float)] = []

        for (key, values) in groupedDictionary {
            let totalHours = values.reduce(0) { $0 + $1.timeInHours }
            let day = getDayOfWeek(from: key.date)
            result.append((day: day, category: key.category, totalHours: totalHours))
        }

        return result.sorted { (first, second) in
            guard let firstIndex = daysOfWeek.firstIndex(of: first.day),
                  let secondIndex = daysOfWeek.firstIndex(of: second.day) else { return false }
            return firstIndex < secondIndex
        }
    }


    var totalByCategory: [(category: AppCategory, totalHours: Float)] {
        Dictionary(grouping: timeData) { $0.category }
            .map { (category, values) in
                (category: category, totalHours: values.reduce(0) { $0 + $1.timeInHours })
            }
    }

    private func getDayOfWeek(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let dayIndex = calendar.component(.weekday, from: date) - 2
            return daysOfWeek[dayIndex >= 0 ? dayIndex : 6]
        }
        return "Inconnu"
    }
}
