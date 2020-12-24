//
//  DoOutlineGroup.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/21.
//

import SwiftUI

struct DoOutlineGroup: View {
    
    struct Node<Value: Hashable>: Hashable {
        let value: Value
        var children: [Node]? = nil
    }
    
    let tree: [Node<String>] = [
        .init(
            value: "a",
            children: [
                .init(value: "a01"),
                .init(value: "a02"),
                .init(value: "a03"),
            ]
        ),
        .init(
            value: "b",
            children: [
                .init(value: "b001"),
                .init(value: "b002"),
                .init(value: "b003"),
                .init(value: "b004", children:[
                    .init(value: "b004-01"),
                    .init(value: "b004-02"),
                ]),
                .init(value: "b005"),
            ])
    ]
    //: https://swiftwithmajid.com/2020/09/02/displaying-recursive-data-using-outlinegroup-in-swiftui/
    var body: some View {
        
        ExampleContainterView("OutlineGroup"){
            
            VExampleView("基本使用") {
                
                OutlineGroup(tree, id: \.value, children: \.children) {
                    Text($0.value)
                        .font(.system(size: 20))
                        .foregroundColor(.orange)
                }
            }
            
            VExampleView("和 List 做对比", height: 200) {
                
                List(tree, id: \.value, children: \.children) {
                    Text($0.value)
                        .font(.system(size: 18))
                        .foregroundColor(.blue)
                }.listStyle(SidebarListStyle())
            }
        }
    }
    
}

struct DoOutlineGroup_Previews: PreviewProvider {
    static var previews: some View {
        DoOutlineGroup()
    }
}
