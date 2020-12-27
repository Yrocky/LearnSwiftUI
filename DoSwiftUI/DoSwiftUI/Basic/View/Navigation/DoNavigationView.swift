//
//  DoNavigationView.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/25.
//

import SwiftUI

struct DoNavigationView: View {
    var body: some View {
        
//        ExampleContainterView("NavigationView") {
            
            doBasic
//        }
    }
    let items = [
        "Chocolate", "Vanilla",
        "Strawberry", "Mint Chip",
        "Pistachio"
    ]
    
    var doBasic: some View {
//        VExampleView("基础用法", height: 200) {
            
            NavigationView {
                List(items, id:\.self) {
                    Text($0)
                }
                .navigationTitle("Today's Flavors")
//            }
        }
    }
}

struct DoNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        DoNavigationView()
    }
}
