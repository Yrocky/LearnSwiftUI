//
//  DoBorder.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoBorder: View {
    var body: some View {
        
        ExampleContainterView("border") {
            
            doInColor
            
            doInGradientColor
            
            doBorderWithPadding
        }
    }
    
    var doInColor: some View {
        /*:
         
         在以往的实例中，我们会使用`border`来标识一个View的尺寸，
         它是View的一个分类方法，
         接受`ShapeStyle`以及线宽两个参数。
         ShapeStyle在fill的讲解中已经掌握，所以目前为止，我们只能使用这些内置的类型来对View进行描边。
         
         ```swift
         func border<S>(_ content: S, width: CGFloat = 1) -> some View where S : ShapeStyle
         ```
         
         和Shape的`stroke`方法不同，border是为View添加描边，是我们通俗意义上的描边，
         而stroke则是和Shape有概念上关联的，它是组成Shape的一部分，另外部分是fill以及path。
         
         */
        VExampleView("使用 Color") {
            
            Rectangle()
                .fill(Color.clear)
                .border(Color.orange.opacity(0.2))
                .frame(width: 100, height: 70)
        }
    }
    
    var doInGradientColor: some View {
        /*:
         为View设置渐变描边比UIKit中的实现简单的多了。
         */
        VExampleView("使用 Gradient") {
            
            Rectangle()
                .fill(Color.clear)
                .border(LinearGradient(gradient: Gradient(colors: [.green,.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 100, height: 70)
        }
    }
    
    var doBorderWithPadding: some View {
        
        /*:
         
         */
        VExampleView("border 通常用于测试 View 的尺寸") {
            
            Text("Hello world")
                .border(Color.red)
                .padding()
                .border(Color.green)
                .frame(width: 200, height: 100)
                .border(Color.orange)
        }
    }
}

struct DoBorder_Previews: PreviewProvider {
    static var previews: some View {
        DoBorder()
    }
}
