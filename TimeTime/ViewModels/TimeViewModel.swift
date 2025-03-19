//
//  TimeViewModel.swift
//  TimeTime
//
//  Created by levin marvyn on 19/03/2025.
//

import Foundation

class TimeViewModel: ObservableObject {
    @Published var timeData: [TimeData] = []
    @Published var selectedTimeUnit: String = "Jours" {
        didSet {
            calculateData()
        }
    }
    
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
        switch selectedTimeUnit {
        case "Jours":
            generateDailyData()
        case "Mois":
            generateMonthlyData()
        default:
            timeData = []
        }
    }
    
    private func generateDailyData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let daysOfWeek = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"]
        
        let groupedByDay = Dictionary(grouping: timeUsageData, by: { timeEntry -> String? in
            if let date = dateFormatter.date(from: timeEntry.date) {
                let dayIndex = Calendar.current.component(.weekday, from: date) - 2
                return dayIndex >= 0 ? daysOfWeek[dayIndex] : daysOfWeek[6] // Dimanche = index -1, donc ajustement
            }
            return nil
        })
        
        timeData = daysOfWeek.compactMap { day in
            let totalHours = groupedByDay[day]?.reduce(0) { $0 + $1.timeInHours } ?? 0
            return TimeData(timeUnit: day, duration: totalHours)
        }
    }
    
    private func generateMonthlyData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let months = ["Jan", "Fév", "Mar", "Avr", "Mai", "Juin", "Juil", "Août", "Sep", "Oct", "Nov", "Déc"]
        
        // Regrouper les heures par mois et compter les jours distincts
        var monthlyUsage: [Int: (totalHours: Float, uniqueDays: Set<Int>)] = [:]
        
        for entry in timeUsageData {
            if let date = dateFormatter.date(from: entry.date) {
                let month = Calendar.current.component(.month, from: date)  // Numéro du mois (1 = Janvier)
                let day = Calendar.current.component(.day, from: date)  // Jour du mois
                
                if monthlyUsage[month] == nil {
                    monthlyUsage[month] = (entry.timeInHours, [day])
                } else {
                    var (currentTotal, daysSet) = monthlyUsage[month]!
                    currentTotal += entry.timeInHours
                    daysSet.insert(day) // Ajoute uniquement les jours uniques
                    
                    monthlyUsage[month] = (currentTotal, daysSet)
                }
            }
        }
        
        // Construire les données finales
        timeData = (1...12).compactMap { month in
            if let (totalHours, uniqueDays) = monthlyUsage[month], !uniqueDays.isEmpty {
                let averageDailyUsage = totalHours / Float(uniqueDays.count) // Moyenne par jour réel
                return TimeData(timeUnit: months[month - 1], duration: averageDailyUsage)
            }
            return nil
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
