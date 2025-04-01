import Foundation
import UIKit
import UserNotifications


class CategoryViewModel: ObservableObject {


    //
    //  VARIABLES
    //

    @Published var selectedGraphType: String = "Barre"
    @Published var timeData: [Time] = Time.testData
    @Published var dailyLimit: Float = 4.0
    @Published var sleepTime: Date = Date()
    @Published var isSleepNotificationEnabled: Bool = false
    @Published var appLimits: [String: Float] = [:]

    private let appLimitsKey = "appLimits"
    let daysOfWeek = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"]
    
    init() {
        loadDailyLimit()
        loadSettings()
        loadAppLimits()
        requestNotificationPermission()
    }



    //
    //  INITIALISATION
    //
    
    // Charge la limite quotidienne au démarrage
    func loadDailyLimit() {
        if let savedLimit = UserDefaults.standard.value(forKey: "dailyLimit") as? Float {
            dailyLimit = savedLimit
        }
    }

    // Charge l'heure de coucher au démarrage
    func loadSettings() {
        if let savedSleepTime = UserDefaults.standard.object(forKey: "sleepTime") as? Date {
            sleepTime = savedSleepTime
        }

        isSleepNotificationEnabled = UserDefaults.standard.bool(forKey: "isSleepNotificationEnabled")
    }

    // Charge les limites des apps au démarrage
    func loadAppLimits() {
        if let savedData = UserDefaults.standard.data(forKey: appLimitsKey),
            // on load depuis le json car on a plusieurs lignes :
            // {
            //      "Facebook": 1.5,
            //      "Instagram": 2.0,
            //      "Twitter": 0.5
            // }

            let decodedLimits = try? JSONDecoder().decode([String: Float].self, from: savedData) {
            appLimits = decodedLimits
        }
    }

    // Permet de vérifier si les notifications sont activés sur l'app (et de demander de les activer)
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
    


    //
    //   VARIABLES SUR DONNEES SPECIFIQUES TIMEMODEL
    //

    // Trouver les information à partir de la dernière date enregistré
    var latestDayApps: [Time] {
            guard let latestDate = timeData.map({ $0.date }).max() else { return [] }
            return timeData.filter { $0.date == latestDate }
        }

    // Trouver le temps total d'écran pour le dernier jour enregistré
    var totalTimeForLatestDay: Float {
        return latestDayApps.reduce(0) { $0 + $1.timeInHours }
    }

    // Trouver le temps par jour, par catégorie pour le stack chart
    var groupedTimeData: [(day: String, category: AppCategory, totalHours: Float)] {
        // regrouper les données par date
        let groupedByDate = Dictionary(grouping: timeData, by: { $0.date })

        // tableau de tuples (jour, catégorie, totalHours)
        var result: [(day: String, category: AppCategory, totalHours: Float)] = []

        for (date, times) in groupedByDate {
            // récupérer le jour de la semaine (lun, mar, mer..) à partir de la date (xx-xx-xxxx)
            let day = getDayOfWeek(from: date)
            // regrouper les temps par catégorie pour ce jour
            let groupedByCategory = Dictionary(grouping: times, by: { $0.category })
            for (category, categoryTimes) in groupedByCategory {
                let totalHours = categoryTimes.reduce(0) { $0 + $1.timeInHours }
                result.append((day: day, category: category, totalHours: totalHours))
            }
        }

        // Trie les résultats selon l'ordre des jours de la semaine
        return result.sorted { (first, second) in
            guard let firstIndex = daysOfWeek.firstIndex(of: first.day),
                  let secondIndex = daysOfWeek.firstIndex(of: second.day) else { return false }
            return firstIndex < secondIndex
        }
    }

    // Trouver le temps pour le dernier jour, par catégorie pour le pie chart
    var totalByCategoryByLastDay: [(category: AppCategory, totalHours: Float)] {
        guard let latestDate = timeData.map({ $0.date }).max() else { return [] }

        return Dictionary(grouping: timeData.filter { $0.date == latestDate }) { $0.category }
            .map { (category, values) in
                (category: category, totalHours: values.reduce(0) { $0 + $1.timeInHours })
            }
    }



    //
    //  METHODES
    //

    // Trouver les apps par catégorie sans doublons
    func appsInCategory(_ category: AppCategory) -> [Time] {
        let filteredData = timeData.filter { $0.category == category }

        let uniqueApps = Array(Set(filteredData.map { $0.appName })).compactMap { appName in
            return filteredData.first { $0.appName == appName }
        }

        return uniqueApps
    }

    // Trouver les jours dans la semaines
    private func getDayOfWeek(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            // Calendar est basée de base sur dimanche, premier jour donc on change ca !
            let dayIndex = calendar.component(.weekday, from: date) - 2
            return daysOfWeek[dayIndex >= 0 ? dayIndex : 6]
        }
        return "Inconnu" // N'arrive jamais :)
    }
    
    // Sauvegarde la limite quotidienne
    func saveDailyLimit() {
        UserDefaults.standard.set(dailyLimit, forKey: "dailyLimit")
    }



    //
    //  NOTIFICATIONS
    //


    //  HEURE DE COUCHER

    // Enregistre si on a activé l'option heure de coucher ou non
    func saveSettings() {
        UserDefaults.standard.set(sleepTime, forKey: "sleepTime")
        UserDefaults.standard.set(isSleepNotificationEnabled, forKey: "isSleepNotificationEnabled")
    }

    // Si on modifie l'heure de coucher alors on met a jour l'heure de l'envoi de notification
    func toggleSleepNotification() {
        if isSleepNotificationEnabled {
            // si activé alors on active la notif
            scheduleSleepNotification()
        } else {
            // sinon on la supprime des requests notifs
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["sleepTimeNotification"])
            print("Notification de coucher désactivée")
        }

        // + mise à jour de l'activation ou non de l'heure de coucher
        saveSettings()
    }


    //
    //
    //  LIMITE GLOBALE
    //
    //

    // FONCTION TEMPORAIRE CAR ON NE GERE PAS LE TEMPS REEL
    func checkLimitExceeded() {
        if totalTimeForLatestDay >= dailyLimit {
            sendLimitExceededNotification()
        }
    }

    // Incrémenter la limite globale
    func increaseLimit() {
        if dailyLimit < 12 {
            dailyLimit += 0.5
            saveDailyLimit()
        }
    }

    // Décrémenter la limite globale
    func decreaseLimit() {
        if dailyLimit > 2 {
            dailyLimit -= 0.5
            saveDailyLimit()
        }
    }
    

    //
    //
    //  LIMITE PAR APP
    //
    //

    // FONCTION TEMPORAIRE CAR ON NE GERE PAS LE TEMPS REEL
    func checkAppLimitExceeded() {
        // en fonction du dernier jour
        let latestDayApps = self.latestDayApps

        // check par app si elle dépasse
        for app in latestDayApps {
            if let limit = appLimits[app.appName] {
                if app.timeInHours >= limit {
                    // si elle dépasse alors on notifie
                    sendAppLimitExceededNotification(appName: app.appName)
                }
            }
        }
    }

    // Sauvegarder les limites de temps par app
    func saveAppLimits() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(appLimits) {
            UserDefaults.standard.set(encoded, forKey: appLimitsKey)
        }
    }

    // Mettre à jour les limites de temps en fonction de la vue
    func updateAppLimit(for appName: String, newLimit: Float) {
        appLimits[appName] = newLimit
        // + sauvegarder
        saveAppLimits()
    }


    //
    //
    //  ENVOIE DES NOTIFICATIONS
    //
    //

    // Notification pour l'heure de coucher
    func scheduleSleepNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Temps pour dormir!"
        content.body = "C'est l'heure de te coucher!"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: sleepTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: "sleepTimeNotification", content: content, trigger: trigger)

        // ajout notif dans les notifs existantes
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error : \(error.localizedDescription)")
            } else {
                print("Notification ok")
            }
        }
    }

    // Notification pour limite de temps par app
    func sendAppLimitExceededNotification(appName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Temps écoulé pour \(appName)!"
        content.body = "Tu as atteint la limite définie pour \(appName)!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
        let request = UNNotificationRequest(identifier: "appLimitExceeded_\(appName)", content: content, trigger: trigger)

        // ajout notif dans les notifs existantes
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error : \(error.localizedDescription)")
            } else {
                print("Notification ok")
            }
        }
    }

    // Notification pour limite gobale de temps
    func sendLimitExceededNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Salut ! Je te fais un rappel !"
        content.body = "Tu as atteint ta limite d'écran O_o"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
        let request = UNNotificationRequest(identifier: "limitExceeded", content: content, trigger: trigger)

        // si app en premier plan
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    let rootViewController = window.rootViewController
                    let alert = UIAlertController(title: content.title, message: content.body, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    rootViewController?.present(alert, animated: true)
                }
            }

        // ajout notif dans les notifs existantes
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error : \(error.localizedDescription)")
            } else {
                print("Notification ok")
            }
        }
    }
}
