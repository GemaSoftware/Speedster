//
//  GameViewModel.swift
//  Speedster
//
//  Created by Agron Gemajli on 7/8/20.
//  Copyright © 2020 Agron Gemajli. All rights reserved.
//

import Foundation
import SwiftUI


class GameListViewModel: ObservableObject{
    
    @Published var listGames = [Game]()
    
    @Published var currentSearch = ""
    
    init() {
        fetchGames(page: 1)
    }
    
    func fetchGames(page: Int) {
        print("here setting up url")
        guard let url = URL(string: "https://www.speedrun.com/api/v1/games?max=20&name=battle%20for%20bikini%20bottom")
            else {
                fatalError("Internal URL Error")
        }
        
        print("here starting data task")
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error calling API")
                return
            }
            
            let gameResponse = try? JSONDecoder().decode(GameAPIResponse.self, from: data)
            if let gameResponse = gameResponse {
                DispatchQueue.main.async {
                    self.listGames = gameResponse.data
                    
                }
            }
        }.resume()
    }
    
    func searchGames() {
        
        let escapedString = currentSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print("here setting up url")
        guard let url = URL(string: "https://www.speedrun.com/api/v1/games?max=20&name=\(escapedString ?? "")")
            else {
                fatalError("Internal URL Error")
        }
        
        print("here starting data task")
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error calling API")
                return
            }
            
            let gameResponse = try? JSONDecoder().decode(GameAPIResponse.self, from: data)
            if let gameResponse = gameResponse {
                DispatchQueue.main.async {
                    self.listGames = gameResponse.data
                    
                }
            }
        }.resume()
    }
    
    
    
    
    
    
    
}
