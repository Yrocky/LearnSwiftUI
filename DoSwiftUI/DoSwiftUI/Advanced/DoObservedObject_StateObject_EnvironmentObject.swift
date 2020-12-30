//
//  DoObservedObject_StateObject_EnvironmentObject.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoObservedObject_StateObject_EnvironmentObject: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        // https://www.hackingwithswift.com/quick-start/swiftui/whats-the-difference-between-observedobject-state-and-environmentobject
        ExampleContainterView("Environment") {
                    
        }
    }
}

struct DoObservedObject_StateObject_EnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
        DoObservedObject_StateObject_EnvironmentObject()
    }
}
