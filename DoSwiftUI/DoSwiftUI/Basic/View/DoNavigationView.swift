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
    
    var doBasic: some View {
//        VExampleView("基础用法", height: 200) {
            
            NavigationView {
                Text("Home")
                Text("Message")
//            }
        }
    }
}

struct DoNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        DoNavigationView()
    }
}
