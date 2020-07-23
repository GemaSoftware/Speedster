//
//  GameView.swift
//  Speedster
//
//  Created by Agron Gemajli on 7/9/20.
//  Copyright © 2020 Agron Gemajli. All rights reserved.
//

import Foundation
import SwiftUI
import URLImage

struct GameView: View {
    
    @ObservedObject var gameViewModel: GameViewModel
    
    init(gd: Game){
        gameViewModel = GameViewModel(gd: gd)
    }
    
    var body: some View{
        ScrollView{
            VStack{
                HStack{
                    URLImage(URL(string: gameViewModel.gameData.assets.coverMedium?.uri ?? "https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101028/112815904-stock-vector-no-image-available-icon-flat-vector-illustration.jpg?ver=6")!, placeholder: Image("imageNA")){ proxy in
                        proxy.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 150)
                    .padding(.leading)
                    
                    
                    Spacer()
                    Text(gameViewModel.gameData.names.international ?? "Title Not Found")
                    Spacer()
                }.padding(.bottom)
                    .padding(.top)

                    ForEach(gameViewModel.gameCategories, id: \.id){ thing in
                            VStack(alignment: .leading){
                                if thing.type == "per-game"{
                                    Text(thing.name).font(.largeTitle)
                                    GameCategoryRecordListView(gC: thing).frame(height: 550)
                                }
                            }
                    
                        
                        
                    }
                
                    
                Spacer()
            }
                
            
                
            }.navigationBarTitle("", displayMode: .inline)
        }
    }


struct tempView: View {
    var body: some View{
        Text("Test")
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        tempView()
    }
}
