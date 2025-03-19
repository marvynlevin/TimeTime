//
//  TimeModel.swift
//  TimeTime
//
//  Created by levin marvyn on 19/03/2025.
//

import Foundation

struct Time: Identifiable {
    var id = UUID()
    var appName: String
    var date: String
    var timeInHours: Float

    static var testData: [Time] = [
        Time(appName: "TikTok", date: "2025-01-01", timeInHours: 5.0),
        Time(appName: "Instagram", date: "2025-01-01", timeInHours: 3.2),
        Time(appName: "YouTube", date: "2025-01-02", timeInHours: 6.5),
        Time(appName: "Snapchat", date: "2025-01-02", timeInHours: 2.1),
        Time(appName: "Facebook", date: "2025-01-03", timeInHours: 1.5),
        
        Time(appName: "TikTok", date: "2025-02-01", timeInHours: 5.0),
        Time(appName: "Instagram", date: "2025-02-01", timeInHours: 3.2),
        Time(appName: "YouTube", date: "2025-02-02", timeInHours: 6.5),
        Time(appName: "Snapchat", date: "2025-02-02", timeInHours: 2.1),
        Time(appName: "Facebook", date: "2025-02-03", timeInHours: 1.5),
        Time(appName: "WhatsApp", date: "2025-02-03", timeInHours: 2.7),
        Time(appName: "Netflix", date: "2025-02-04", timeInHours: 4.0),
        Time(appName: "Spotify", date: "2025-02-04", timeInHours: 1.2),
        Time(appName: "Discord", date: "2025-02-05", timeInHours: 3.5),
        
        
        // Début de semaine (moins d'utilisation)
        Time(appName: "TikTok", date: "2025-03-01", timeInHours: 5.0),
        Time(appName: "Instagram", date: "2025-03-01", timeInHours: 3.2),
        Time(appName: "YouTube", date: "2025-03-02", timeInHours: 6.5),
        Time(appName: "Snapchat", date: "2025-03-02", timeInHours: 2.1),
        Time(appName: "Facebook", date: "2025-03-03", timeInHours: 1.5),
        Time(appName: "WhatsApp", date: "2025-03-03", timeInHours: 2.7),
        Time(appName: "Netflix", date: "2025-03-04", timeInHours: 4.0),
        Time(appName: "Spotify", date: "2025-03-04", timeInHours: 1.2),
        Time(appName: "Discord", date: "2025-03-05", timeInHours: 3.5),
        
        // Jeudi/Vendredi (début de l'augmentation)
        Time(appName: "TikTok", date: "2025-03-06", timeInHours: 2.8),
        Time(appName: "Instagram", date: "2025-03-06", timeInHours: 1.6),
        Time(appName: "YouTube", date: "2025-03-07", timeInHours: 5.2),
        Time(appName: "Twitter", date: "2025-03-07", timeInHours: 0.5),
        
        // Samedi/Dimanche (usage plus élevé)
        Time(appName: "Snapchat", date: "2025-03-08", timeInHours: 7.3),
        Time(appName: "Facebook", date: "2025-03-08", timeInHours: 2.0),
        Time(appName: "WhatsApp", date: "2025-03-09", timeInHours: 3.9),
        Time(appName: "Netflix", date: "2025-03-09", timeInHours: 8.2),
        Time(appName: "Spotify", date: "2025-03-10", timeInHours: 2.3),
        
        // Début de semaine (plus faible)
        Time(appName: "Discord", date: "2025-03-11", timeInHours: 1.1),
        Time(appName: "TikTok", date: "2025-03-11", timeInHours: 4.3),
        Time(appName: "Instagram", date: "2025-03-12", timeInHours: 0.9),
        Time(appName: "YouTube", date: "2025-03-12", timeInHours: 1.5),
        Time(appName: "Twitter", date: "2025-03-13", timeInHours: 0.2),
        
        // Progression vers le week-end
        Time(appName: "Snapchat", date: "2025-03-14", timeInHours: 5.0),
        Time(appName: "Facebook", date: "2025-03-14", timeInHours: 2.3),
        Time(appName: "WhatsApp", date: "2025-03-15", timeInHours: 4.2),
        Time(appName: "Netflix", date: "2025-03-15", timeInHours: 6.7),
        
        // Week-end (temps plus élevé)
        Time(appName: "Spotify", date: "2025-03-16", timeInHours: 7.5),
        Time(appName: "Discord", date: "2025-03-16", timeInHours: 3.0),
        Time(appName: "TikTok", date: "2025-03-17", timeInHours: 8.5),
        Time(appName: "Instagram", date: "2025-03-17", timeInHours: 2.1),
        Time(appName: "YouTube", date: "2025-03-18", timeInHours: 9.2),
        
        // Fin du mois (baisse progressive)
        Time(appName: "Twitter", date: "2025-03-19", timeInHours: 3.8),
        Time(appName: "Snapchat", date: "2025-03-19", timeInHours: 1.7),
        Time(appName: "Facebook", date: "2025-03-20", timeInHours: 0.4),
        Time(appName: "WhatsApp", date: "2025-03-20", timeInHours: 2.5),
        Time(appName: "Netflix", date: "2025-03-21", timeInHours: 6.1)
    ]

}
