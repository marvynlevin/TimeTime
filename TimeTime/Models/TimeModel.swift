import Foundation
import SwiftUI

enum AppCategory: String {
    case video = "Vidéo"
    case socialMedia = "Réseaux sociaux"
    case music = "Musique"
    
    var color: Color {
        switch self {
        case .video:
            return Color(hex: "#A7D8D8")
        case .socialMedia:
            return Color(hex: "#F7A8B8")
        case .music:
            return Color(hex: "#FFB3B3")
        }
    }
}

struct Time: Identifiable {
    var id = UUID()
    var appName: String
    var date: String
    var timeInHours: Float
    var category: AppCategory

    static var testData: [Time] = [
        Time(appName: "TikTok", date: "2025-02-24", timeInHours: 2.0, category: .socialMedia),
        Time(appName: "Instagram", date: "2025-02-24", timeInHours: 3.2, category: .socialMedia),
        Time(appName: "YouTube", date: "2025-02-25", timeInHours: 2.5, category: .video),
        Time(appName: "Snapchat", date: "2025-02-25", timeInHours: 2.1, category: .socialMedia),
        Time(appName: "Facebook", date: "2025-02-26", timeInHours: 3.5, category: .socialMedia),
        Time(appName: "WhatsApp", date: "2025-02-26", timeInHours: 2.7, category: .socialMedia),
        
        Time(appName: "Netflix", date: "2025-02-27", timeInHours: 2.0, category: .video),
        Time(appName: "Spotify", date: "2025-02-27", timeInHours: 1.2, category: .music),
        Time(appName: "Discord", date: "2025-02-27", timeInHours: 3.5, category: .socialMedia),
        Time(appName: "YouTube", date: "2025-02-28", timeInHours: 1.0, category: .video),
        Time(appName: "Instagram", date: "2025-02-28", timeInHours: 2.3, category: .socialMedia),
        
        Time(appName: "Snapchat", date: "2025-03-01", timeInHours: 1.1, category: .socialMedia),
        
        Time(appName: "Snapchat", date: "2025-03-02", timeInHours: 3.1, category: .socialMedia),
        Time(appName: "YouTube", date: "2025-03-02", timeInHours: 5.1, category: .socialMedia),
    ]
}
