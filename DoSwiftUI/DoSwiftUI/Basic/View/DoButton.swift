//
//  DoButton.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/29.
//

import SwiftUI

struct DoButton: View {
    var body: some View {
        ExampleContainerView("Button") {
         
            doBasic
        }
    }
    
    var doBasic: some View {
        VExampleView("basic") {
            
        }
    }
}

struct DoButton_Previews: PreviewProvider {
    static var previews: some View {
        DoButton()
    }
}
