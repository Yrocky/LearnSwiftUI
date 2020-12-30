//
//  DoOutlineGroup.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/25.
//

import SwiftUI

struct DoOutlineGroup: View {
    
    var body: some View {
        //: https://swiftwithmajid.com/2020/09/02/displaying-recursive-data-using-outlinegroup-in-swiftui/
        ExampleContainterView("OutlineGroup", version: "2.0") {
            
            doBasic
            
            doUseIdentifiable
            
            doDynamic
        }
    }
    
    var doBasic: some View {
        
        VExampleView("基础使用") {
            /*:
             `OutlineGroup`是swiftUI2.0推出的控件，
             它可以用来很容易的展示一个`树形结构`，也就是俗称的`递归数据`。
             通过OutlineGroup，只需要指定元素的`id`和`children`即可，
             前者用来标识元素的唯一性，后者就是用来递归的属性。
             
             */
            OutlineGroup(tree, id: \.value, children: \.children) {
                
                    Text($0.value)
                        .font(.system(size: 20))
                        .foregroundColor(.orange)
            }
        }
    }
    
    var doUseIdentifiable: some View {
        
        VExampleView("遵守 Identifiable 的递归数据") {
            /*:
             从头文件中可以看到，如果递归数据遵守`Identifiable`协议，就可以省略id。
             */
            OutlineGroup(root, children: \.children) {
                
                Text($0.name)
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
            }
            
            /*:
             可以看到，OutlineGroup的展示效果并不是很好看，
             它更多的是结合List、Form、Section这些控件来构建界面。
             */
        }
    }
    
    var doDynamic: some View {
        
        VExampleView("动态的修改 OutlineGroup ") {
            OutlineGroup(root, children: \.children) {
                
                Text($0.name)
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
            }
            
            HStack{
                
                Button("Append") {
                    withAnimation {
                        self.root.append(File("root \(self.root.count)",
                                              children: [File("new root sub ")]))
                    }
                }
                
                Button("Delete") {
                    withAnimation {
                        if self.root.count > 0 {
                            self.root.removeLast()
                        }
                    }
                }
            }
        }
    }
    
    struct File: Hashable, Identifiable {
        
        let id = UUID()
        var name : String
        var children: [File]? = nil
        
        init(_ name: String, children: [File]? = nil) {
            self.name = name
            self.children = children
        }
    }
    
    @State private var root: [File] = [
        File("root", children: [
            File("home", children: [
                File("swiftUI"),
                File("objc"),
                File("vue"),
                File("java")
            ]),
            File("system"),
            File("lib"),
            File("doucment")
        ])
    ]
    
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
                    .init(value: "b004-01", children: [
                        .init(value: "b004-01-01"),
                        .init(value: "b004-01-02"),
                    ]),
                    .init(value: "b004-02"),
                ]),
                .init(value: "b005"),
            ])
    ]
}

struct DoOutlineGroup_Previews: PreviewProvider {
    static var previews: some View {
        DoOutlineGroup()
    }
}
