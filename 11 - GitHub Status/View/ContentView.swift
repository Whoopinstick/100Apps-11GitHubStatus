//
//  ContentView.swift
//  11 - GitHub Status
//
//  Created by Kevin Paul on 8/18/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var githubSummary = GitHubSummary()
    
    var body: some View {
        VStack {
            Text("\(githubSummary.page.name)")
            Text("\(githubSummary.page.url)")
            
            List {
                ForEach(githubSummary.components.filter {$0.name != "Visit www.githubstatus.com for more information"}) { component in
                    Text(component.name)
                }
            }
        
        }
        .onAppear(perform: loadData)
    }
    
    //methods
    func loadData() {
        guard let url = URL(string: API.url) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let decodedResponse = try? decoder.decode(GitHubSummary.self, from: data) {
                    //we have good data - go back to the main thread
                    DispatchQueue.main.async {
                        //update the UI
                        self.githubSummary = decodedResponse
                    }
                    //everything is good so exit
                    return
                }
                print("Fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
