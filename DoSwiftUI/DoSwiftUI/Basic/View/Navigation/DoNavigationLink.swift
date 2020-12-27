//
//  DoNavigationLink.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoNavigationLink: View {
    var body: some View {
        ExampleContainterView("NavigationLink") {
            
            doBasic
        }
    }
    
    var doBasic: some View {
        VExampleView("基础用法") {

            Text("When you tap ")
                .font(.system(size: 16))
                .foregroundColor(.orange)
            
            NavigationLink(
                "Show Detail",
                destination: Text("Detail")
            )
            .isDetailLink(true)
            
            Text("you will find it's doesn't work")
                .font(.system(size: 16))
                .foregroundColor(.orange)
        }
    }
}

struct DoNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        DoNavigationLink()
    }
}
