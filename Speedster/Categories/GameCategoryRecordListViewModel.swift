//
//  GameCategoryRecordListViewModel.swift
//  Speedster
//
//  Created by Agron Gemajli on 7/10/20.
//  Copyright © 2020 Agron Gemajli. All rights reserved.
//

import Foundation


class GameCategoryRecordViewModel: ObservableObject {
    @Published var listRecord = [GameCategoryRecord]()
    
    @Published var categoryData: GameCategory
    
    init(gC: GameCategory) {
        self.categoryData = gC
        getCategoryRecords()
    }
    
    func getCategoryRecords() {
        print("made it to catrecords")
        guard let url = URL(string: "https://www.speedrun.com/api/v1/categories/\(categoryData.id)/records?top=10") else {
            fatalError("URL Error")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error calling API")
                return
            }
            
            let gameCatResponse = try? JSONDecoder().decode(GameAPICategoryRecord.self, from: data)
            if let gameCatResponse = gameCatResponse {
                DispatchQueue.main.async {
                    print("found records")
                    self.listRecord = gameCatResponse.data.first!.runs
                }
            }
        }.resume()
    }
    
    //Helper
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
      return "\(seconds / 3600)h:\((seconds % 3600) / 60)m:\((seconds % 3600) % 60)s"
    }
}


