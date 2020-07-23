//
//  GameCategoryRecordListView.swift
//  Speedster
//
//  Created by Agron Gemajli on 7/9/20.
//  Copyright © 2020 Agron Gemajli. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct GameCategoryRecordListView: View {
    
    @ObservedObject var categoryRecordViewModel: GameCategoryRecordViewModel
    
    init(gC: GameCategory) {
        self.categoryRecordViewModel = GameCategoryRecordViewModel(gC: gC)
    }
    
    var body: some View{
        VStack{
            Divider()
            if categoryRecordViewModel.listRecord.count != 0 {
                
                List (categoryRecordViewModel.listRecord){ rec in
                    NavigationLink(destination: WebView(request: rec.run.videos.links.first!.uri)
                        .navigationBarTitle("", displayMode: .inline)){
                        HStack(alignment: .center){
                            Text("\(rec.place)")
                            Spacer()
                            
                            Text("\(self.categoryRecordViewModel.secondsToHoursMinutesSeconds(seconds: Int(rec.run.times.ptime!)))")
                            }
                    }.buttonStyle(PlainButtonStyle())
                    .frame(height: 40)
                    
                }
            } else {
                Text("Oof")
            }
        }
        .padding(.trailing)
        .padding(.leading)
        
        
        
    }
}

struct WebView : UIViewRepresentable {
    
    let request: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}



