//
//  DoLayout.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoLayout: View {
    var body: some View {
        // 系统的学习swiftUI中的layout
        // https://kean.blog/post/swiftui-layout-system
        // https://www.objc.io/blog/2020/11/09/hstacks-child-ordering/?utm_campaign=%20SwiftUI%20Weekly&utm_medium=email&utm_source=Revue%20newsletter
        ExampleContainerView("Layout") {
            
            doPosition
            
            doPositionWithText
            
            doOffset
        }
    }
    
    var doPosition: some View {
        VExampleView("position") {
            
            HStack{
                Circle()
                    .fill(Color.green)
                    .frame(width: 20, height: 20)
                    .position(x: 0, y: 0)
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 20, height: 20)
                    .position(x: 10, y: 10)
            }
            .frame(width: 200, height: 50)
            .background(Color.pink.opacity(0.3))
        }
    }
    
    var doPositionWithText: some View {
        VExampleView("position") {
            
            /*:
             通过下面我们发现，position不仅可以修改View的位置，还为View扩大了尺寸，
             */
            Text("Hello, world!")
                .background(Color.red)
            
            Text("Hello, world!")
                .background(Color.red)
                .position(x: 100, y: 100)
            
            Text("Hello, world!")
                .position(x: 100, y: 100)
                .background(Color.red)
        }
    }
    
    var doOffset: some View {
        VExampleView("offset") {
            /*:
             使用offset，我们是修改了Text的位置，但是使用background添加颜色之后，还是暴露了原始位置。这是因为offset改变了View应该被渲染额的位置，但没有实际改变它的
             */
            Text("Hello, world!")
                .offset(x: 100, y: 100)
                .background(Color.red)
            
            Text("Hello, world!")
                .background(Color.red)
                .offset(x: 100, y: 100)
            
            Text("Hello, world!")
                .padding()
                .border(Color.pink ,width: 2)
                .offset(x: 100, y: 100)
        }
    }
}

struct DoLayout_Previews: PreviewProvider {
    static var previews: some View {
        DoLayout()
    }
}
