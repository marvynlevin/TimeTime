import Foundation

class TimeViewModel: ObservableObject {
    @Published var timeData: [TimeData] = []
    @Published var selectedGraphType: String = "Barre"
    
    private var timeUsageData: [Time] = []
    
    @Published var todayUsage: Float = 0
    @Published var yesterdayUsage: Float = 0
    @Published var topAppsToday: [(String, Float)] = []

    init() {
        loadTimeData()
    }
    
    func loadTimeData() {
        timeUsageData = Time.testData
        calculateData()
    }

    func calculateData() {
        generateWeeklyData()
        calculateDailyUsage()
    }

    private func generateWeeklyData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
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
    
    private func calculateDailyUsage() {
        let sortedDates = timeUsageData.map { $0.date }.sorted(by: >)
        guard let latestDate = sortedDates.first else { return }
        
        let todayData = timeUsageData.filter { $0.date == latestDate }
        todayUsage = todayData.reduce(0) { $0 + $1.timeInHours }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let latestDateObject = dateFormatter.date(from: latestDate) {
            if let yesterdayObject = Calendar.current.date(byAdding: .day, value: -1, to: latestDateObject) {
                let yesterdayFormatted = dateFormatter.string(from: yesterdayObject)

                let yesterday = timeUsageData.filter { $0.date == yesterdayFormatted }
                yesterdayUsage = yesterday.reduce(0) { $0 + $1.timeInHours }
            } else {
                yesterdayUsage = 0
            }
        }
        
        topAppsToday = todayData
            .sorted { $0.timeInHours > $1.timeInHours }
            .map { ($0.appName, $0.timeInHours) }
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
