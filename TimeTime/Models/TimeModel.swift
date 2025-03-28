import Foundation
import SwiftUI

enum AppCategory: String, CaseIterable {
    case video = "Vidéo"
    case socialMedia = "Réseaux sociaux"
    case music = "Musique"
    
    var color: Color {
        switch self {
        case .video:
            return Color(hex: "#C95479")
        case .socialMedia:
            return Color(hex: "#61A9A9")
        case .music:
            return Color(hex: "#954FC4")
        }
    }
}

struct Time: Identifiable {
    var id = UUID()
    var appName: String
    var date: String
    var timeInHours: Float
    var category: AppCategory
    var timeLimit: Float?


    static var testData: [Time] = [
        Time(appName: "TikTok", date: "2025-02-24", timeInHours: 2.0, category: .socialMedia, timeLimit: 3.0),
        Time(appName: "Instagram", date: "2025-02-24", timeInHours: 3.2, category: .socialMedia, timeLimit: 2.5),
        Time(appName: "YouTube", date: "2025-02-25", timeInHours: 2.5, category: .video, timeLimit: nil),
        Time(appName: "Snapchat", date: "2025-02-25", timeInHours: 2.1, category: .socialMedia, timeLimit: 2.0),
        Time(appName: "Facebook", date: "2025-02-26", timeInHours: 3.5, category: .socialMedia, timeLimit: 4.0),
        Time(appName: "WhatsApp", date: "2025-02-26", timeInHours: 2.7, category: .socialMedia, timeLimit: nil),
        
        Time(appName: "Netflix", date: "2025-02-27", timeInHours: 2.0, category: .video, timeLimit: 2.0),
        Time(appName: "Spotify", date: "2025-02-27", timeInHours: 1.2, category: .music, timeLimit: nil),
        Time(appName: "Discord", date: "2025-02-27", timeInHours: 3.5, category: .socialMedia, timeLimit: 3.0),
        Time(appName: "YouTube", date: "2025-02-28", timeInHours: 1.0, category: .video, timeLimit: 2.0),
        Time(appName: "Instagram", date: "2025-02-28", timeInHours: 2.3, category: .socialMedia, timeLimit: nil),
        
        Time(appName: "Snapchat", date: "2025-03-01", timeInHours: 1.1, category: .socialMedia, timeLimit: 1.5),
        
        Time(appName: "Snapchat", date: "2025-03-02", timeInHours: 2.1, category: .socialMedia, timeLimit: 2.0),
        Time(appName: "YouTube", date: "2025-03-02", timeInHours: 1.1, category: .video, timeLimit: nil),
        Time(appName: "Netflix", date: "2025-03-02", timeInHours: 2.0, category: .video, timeLimit: 3.0),
        Time(appName: "Spotify", date: "2025-03-02", timeInHours: 3.2, category: .music, timeLimit: nil),
    ]

}
