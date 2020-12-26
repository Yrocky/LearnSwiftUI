//
//  DoSection.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/26.
//

import SwiftUI

struct DoSection: View {
    var body: some View {
        ExampleContainterView("Section") {
            
            doBasic
        }
    }
    
    var doBasic: some View {
        VExampleView("基础用法") {
            
        }
    }
}

struct DoSection_Previews: PreviewProvider {
    static var previews: some View {
        DoSection()
    }
}
