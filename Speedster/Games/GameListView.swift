//
//  GameView.swift
//  Speedster
//
//  Created by Agron Gemajli on 7/8/20.
//  Copyright © 2020 Agron Gemajli. All rights reserved.
//

import Foundation
import SwiftUI
import URLImage

struct GameListView: View {
    
    @ObservedObject var gameListViewModel = GameListViewModel()
    
    @State var text: String = ""
    
    var body: some View{
        NavigationView{
            VStack{
                HStack {
                    TextField("Text Field Test", text: $gameListViewModel.currentSearch)
                    Spacer()
                    Button(action: {
                        self.gameListViewModel.searchGames()
                    }){
                        Text("Search")
                    }
                }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                
                List(gameListViewModel.listGames){ game in
                    GameListRowView(gameData: game)
                }.navigationBarTitle("Games List")
                }.background(Color.init(hex: "#dfe6e9")).cornerRadius(3)
            
        }
    }
}

struct GameListRowView: View {
    @State var gameData: Game
    
    var body: some View{
        NavigationLink(destination: GameView(gd: gameData)){
            
            HStack(alignment: .center){
                URLImage(URL(string: gameData.assets.coverMedium?.uri ?? "https://www.wildhareboca.com/wp-content/uploads/sites/310/2018/03/image-not-available-683x1024.jpg")!, placeholder: { _ in
                    Image("imageNA")             // Use different image for the placeholder
                        .resizable()                        // Make it resizable
                        .frame(width: 100.0) // Set frame to 150x150
                }) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.frame(width: 100)
                Spacer()
                Text(gameData.names.international ?? "Title Not Found")
                Spacer()
            }.frame(height: 150)
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
