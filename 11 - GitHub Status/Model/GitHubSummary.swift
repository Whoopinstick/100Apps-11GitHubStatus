//
//  GitHubSummary.swift
//  11 - GitHub Status
//
//  Created by Kevin Paul on 8/18/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import Foundation

struct GitHubSummary: Codable {
    var page = Page()
    var components: [Component] = []
    
    struct Page: Codable {
        var name: String = ""
        var url: String = ""
        var updated_at: String = ""
        
        var formattedDateUpdated: String {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            
            let shortDate = DateFormatter()
            shortDate.dateFormat = "MM/dd/yyyy"
            return shortDate.string(from: formatter.date(from: updated_at) ?? Date())
            
        }
    }
    
    struct Component: Identifiable, Codable {
        var id: String = ""
        var name: String = ""
        var status: String = ""
        
        var created_at: String = ""
        
        var formattedDateCreated: String {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            
            let shortDate = DateFormatter()
            shortDate.dateFormat = "MM/dd/yyyy"
            return shortDate.string(from: formatter.date(from: created_at) ?? Date())
        }
    }
}
