//
//  DoEnvironment.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/21.
//

import SwiftUI

struct DoEnvironment: View {
    var body: some View {
        /*:
         父View可以通过environment来从上至下的给子View传递数据，
         子View通过访问对应的environment可以得到在视图树中共享的数据。
         
         https://developer.apple.com/documentation/swiftui/environmentvalues
         */
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DoEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        DoEnvironment()
    }
}
