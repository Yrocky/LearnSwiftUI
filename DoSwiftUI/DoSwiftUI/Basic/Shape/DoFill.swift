//
//  DoFill.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoFill: View {
    var body: some View {
        
        ExampleContainterView("fill") {
            
            doBasic
            
            doShapeStyle
            
            doFillStyle
        }
    }
    
    var doBasic: some View {
        /*:
         在前面的一些示例中，我们会经常的用到`fill`这个函数来做一些大小、范围的标识，
         比较多的就是传入一个Color实例，其实fill是`Shape协议`的一个拓展方法。
         他有两个参数：content、style，
         其中content是一个遵守`ShapeStyle协议`的实例，style是`FillStyle`的实例对象。
         
         ```swift
         func fill<S>(_ content: S, style: FillStyle = FillStyle()) -> some View where S : ShapeStyle
         ```
         */
        HExampleView("基本用法"){
        
            Rectangle()
                .fill()
                .frame(width: 100, height: 70)
            
            Rectangle()
                .fill(Color.clear)
                .frame(width: 100, height: 70)
            
            Rectangle()
                .fill(Color.orange.opacity(0.2))
                .frame(width: 100, height: 70)
        }
    }
    
    var doShapeStyle: some View {
        
        /*:
         `ShapeStyle`本身是一个协议，在swiftUI中遵守该协议的类型有：
         `Color`、`LinearGradient`、`RadialGradient`、`AngularGradient`、`BackgroundStyle`、`ForegroundStyle`、`ImagePaint`这几种（依次按照常用于否排序）。
         本身作为一个显示内容在一个`区域`内进行展示，协议核心内容如下：
         
         ```swift
             public func `in`(_ rect: CGRect) -> some ShapeStyle
         ```
         
         并且通过一个目前还未正式化的`_ShapeView`类型可以知道，最终呈现的其实是一个矩形，也就是说，虽然叫做shap-style，但是却仅仅支持一种shap，也许之后官方会拓展不同的shap吧，因此这里才使用一个私有的_ShapeView。
         ```swift
         extension ShapeStyle where Self : View, Self.Body == _ShapeView<Rectangle, Self> {

             public var body: _ShapeView<Rectangle, Self> { get }
         }
         ```
         */
        Text("")
        
    }

    var doFillStyle: some View {
        
        /*:
         `FillStyle`是一个结构体，通过它的实例我们栅格化矢量形状的样式，通俗一点就是决定填充规则，
         决定填充规则的有两个参数：`eoFill`、`antialiased`，前者表示填充规则，后者表示是否要抗锯齿。
         如果开启eoFill，则表示使用`even-odd`规则，如果关闭则表示使用`non-zero`规则。
         
         
         使用non-zero表示只有在闭合路径的内部就填充，外面就不填充。
         
         https://www.jianshu.com/p/7c254edf620d
         https://blog.csdn.net/fudesign2008/article/details/7241778
         */
        
        HStack{
           
            Rectangle()
                
        }
    }
}

struct DoFill_Previews: PreviewProvider {
    static var previews: some View {
        DoFill()
    }
}
