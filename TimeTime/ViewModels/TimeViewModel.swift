import Foundation

class TimeViewModel: ObservableObject {
    @Published var timeData: [TimeData] = []
    @Published var selectedGraphType: String = "Barre"
    
    private var timeUsageData: [Time] = []

    init() {
        loadTimeData()
        calculateData()
    }
    
    func loadTimeData() {
        timeUsageData = Time.testData
        calculateData()
    }

    func calculateData() {
        generateWeeklyData()
    }

    private func generateWeeklyData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let daysOfWeek = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"]
        
        let groupedByDay = Dictionary(grouping: timeUsageData, by: { timeEntry -> String? in
            if let date = dateFormatter.date(from: timeEntry.date) {
                let dayIndex = Calendar.current.component(.weekday, from: date) - 2
                return dayIndex >= 0 ? daysOfWeek[dayIndex] : daysOfWeek[6]
            }
            return nil
        })
        
        timeData = daysOfWeek.compactMap { day in
            let totalHours = groupedByDay[day]?.reduce(0) { $0 + $1.timeInHours } ?? 0
            return TimeData(timeUnit: day, duration: totalHours)
        }
    }
}

struct TimeData: Identifiable {
    var id = UUID()
    var timeUnit: String
    var duration: Float
    
    var formattedDuration: String {
        return "\(Int(duration))h"
    }
}
