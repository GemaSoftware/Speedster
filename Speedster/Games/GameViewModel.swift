//
//  GameViewModel.swift
//  Speedster
//
//  Created by Agron Gemajli on 7/9/20.
//  Copyright © 2020 Agron Gemajli. All rights reserved.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {

    @Published var gameData: Game
    
    @Published var runData = [Game]()
    
    @Published var gameCategories = [GameCategory]()
    
    init(gd: Game){
        gameData = gd
        getCategories()
    }
    
    func getCategories() {
        guard let url = URL(string: "https://www.speedrun.com/api/v1/games/\(gameData.id)/categories?miscellaneous=no") else {
            fatalError("URL Error")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error calling API")
                return
            }
            
            let gameCatResponse = try? JSONDecoder().decode(GameAPICategory.self, from: data)
            if let gameCatResponse = gameCatResponse {
                DispatchQueue.main.async {
                    self.gameCategories = gameCatResponse.data
                }
            }
        }.resume()
        
        
        
        
    }
    
    
}
