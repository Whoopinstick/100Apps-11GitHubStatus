//
//  GitHubSummary.swift
//  11 - GitHub Status
//
//  Created by Kevin Paul on 8/18/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import Foundation

struct GitHubSummary: Codable {
    var page: Page
    var components: [Component]
    
    struct Page: Codable {
        var name: String = ""
        var url: String = ""
    }
    
    struct Component: Identifiable, Codable {
        var id: String = ""
        var name: String = ""
        var status: String = ""
    }
}
