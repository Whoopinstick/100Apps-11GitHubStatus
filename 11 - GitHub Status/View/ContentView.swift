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
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Last Updated: \(githubSummary.page.formattedDateUpdated)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                Spacer()
                
                ForEach(githubSummary.components.filter {$0.name != "Visit www.githubstatus.com for more information"}) { component in
                    
                    Text(component.name)
                        .font(.headline)
                    Text(component.status.capitalized)
                        .font(.subheadline)
                        .foregroundColor(self.changeStatusFont(for: component.status.capitalized))
                    Spacer(minLength: 5.0)
                    
                }

                Spacer()
                Spacer()
                
            }
            .onAppear(perform: loadData)
            .navigationBarTitle("GitHub Status")
            .navigationBarItems(trailing: Button(action: {
                self.loadData()
            }) {
                Image(systemName: "arrow.clockwise")
            })
            
        }
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
    
    func changeStatusFont(for status: String) -> Color {
        let lowercaseStatus = status.lowercased()
        //operational, degraded_performance, partial_outage, or major_outage
        switch lowercaseStatus {
        case "operational":
            return Color.green
        case "degraded_performance":
            return Color.yellow
        case "partial_outage":
            return Color.yellow
            case "major_outage":
            return Color.red
        default:
            return Color.primary
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
