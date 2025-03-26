import Foundation
import UIKit
import UserNotifications

struct TimeGroupKey: Hashable {
    let date: String
    let category: AppCategory
}

class CategoryViewModel: ObservableObject {
    @Published var selectedGraphType: String = "Barre"
    @Published var timeData: [Time] = Time.testData
    @Published var dailyLimit: Float = 4.0
    @Published var sleepTime: Date = Date()
    @Published var isSleepNotificationEnabled: Bool = false

    init() {
        loadSettings()
        requestNotificationPermission()
    }
    
    let daysOfWeek = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"]
   
    
    var latestDayApps: [Time] {
            guard let latestDate = timeData.map({ $0.date }).max() else { return [] }
            return timeData.filter { $0.date == latestDate }
        }
    
    var totalTimeForLatestDay: Float {
        return latestDayApps.reduce(0) { $0 + $1.timeInHours }
    }

    
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
    
    
    var totalByCategoryByLastDay: [(category: AppCategory, totalHours: Float)] {
        guard let latestDate = timeData.map({ $0.date }).max() else { return [] }
        
        return Dictionary(grouping: timeData.filter { $0.date == latestDate }) { $0.category }
            .map { (category, values) in
                (category: category, totalHours: values.reduce(0) { $0 + $1.timeInHours })
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
    
    
    // GERER LES NOTIFICATIONS ICI
    func requestNotificationPermission() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("Permission error : \(error.localizedDescription)")
                } else if granted {
                    print("Permission oui")
                } else {
                    print("Permission non")
                }
            }
        }
    
    // limite globale
    
    func increaseLimit() {
        if dailyLimit < 12 {
            dailyLimit += 0.5
        }
    }

    func decreaseLimit() {
        if dailyLimit > 2 {
            dailyLimit -= 0.5
        }
    }
    func sendLimitExceededNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Salut ! Je te fais un rappel !"
        content.body = "Tu as atteint ta limite d'écran O_o"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
        let request = UNNotificationRequest(identifier: "limitExceeded", content: content, trigger: trigger)
        
        if UIApplication.shared.applicationState == .active {
            let alert = UIAlertController(title: "Salut ! Je te fais un rappel !", message: "Tu as atteint ta limite d'écran O_o", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true)
            }
        }
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error : \(error.localizedDescription)")
            } else {
                print("Notification ok")
            }
        }
    }
    
    func checkLimitExceeded() {
        if totalTimeForLatestDay >= dailyLimit {
            sendLimitExceededNotification()
        }
    }
    
    
    // heure de coucher
    func scheduleSleepNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Temps pour dormir!"
        content.body = "C'est l'heure de te coucher!"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: sleepTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "sleepTimeNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erreur lors de l'ajout de la notification: \(error.localizedDescription)")
            } else {
                print("Notification de coucher programmée avec succès")
            }
        }
    }

    func saveSettings() {
        UserDefaults.standard.set(sleepTime, forKey: "sleepTime")
        UserDefaults.standard.set(isSleepNotificationEnabled, forKey: "isSleepNotificationEnabled")
    }

    func loadSettings() {
        if let savedSleepTime = UserDefaults.standard.object(forKey: "sleepTime") as? Date {
            sleepTime = savedSleepTime
        }
        
        isSleepNotificationEnabled = UserDefaults.standard.bool(forKey: "isSleepNotificationEnabled")
    }

    func toggleSleepNotification() {
        if isSleepNotificationEnabled {
            scheduleSleepNotification()
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["sleepTimeNotification"])
            print("Notification de coucher désactivée")
        }
        
        saveSettings()
    }
}
