//
//  DoList_2.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/25.
//

import SwiftUI

struct DoList_2: View {
    var body: some View {
        
        ExampleContainterView("List") {
         
            doListStyle
            
        }
    }
    
    var doListStyle: some View {
        VExampleView("ListStyle") {
            
        }
    }
}

struct DoList_2_Previews: PreviewProvider {
    static var previews: some View {
        DoList_2()
    }
}
