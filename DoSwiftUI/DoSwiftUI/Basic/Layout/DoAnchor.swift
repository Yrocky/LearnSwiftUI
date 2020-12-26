//
//  DoAnchor.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoAnchor: View {
    var body: some View {
        ExampleContainterView("Anchor") {
            
            doBasic
            
        }
    }
    
    var doBasic: some View {
        VExampleView("基础用法") {
            
        }
    }
}

struct DoAnchor_Previews: PreviewProvider {
    static var previews: some View {
        DoAnchor()
    }
}
