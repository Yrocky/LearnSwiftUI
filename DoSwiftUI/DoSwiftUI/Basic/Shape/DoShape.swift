//
//  DoShape.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoShape: View {
    
    var body: some View {
        
        ExampleContainerView("Shape") {
            
            doBasicBuildInShap
            
            doRotatedShape
            
            doContainerRelativeShape
            
            doScaledShape
            
            doOffsetShape
            
            doTransformedShape
            
            doInsettableShape
        }
    }
    
    @State private var width : CGFloat = 50
    @State private var height : CGFloat = 50
    
    var doBasicBuildInShap: some View {
        
        VStack{
            
            VExampleView("系统内置的 Shape 类型") {
                
                /*:
                 swiftUI内置了一些形状，都是常用的几何形状，比如
                 * Rectangle，矩形
                 * RoundedRectangle，圆角矩形，可以设置圆角大小
                 * Circle，圆形，swiftUI会选取宽、高的最小值作为直径来绘制圆形
                 * Ellipse，椭圆形
                 * Capsule，直译为胶囊，在2D上，它的四个角都是1/4圆，圆的直径为宽、高中的最小值
                 */
                ScrollView(.horizontal) {
                    
                    HStack{
                        
                        Rectangle()
                            .makupFill(with: .red, width: width, height: height)
                        
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .makupFill(with: .orange, width: width, height: height)
                        
                        Circle()
                            .makupFill(with: .green, width: width, height: height)
                        
                        Ellipse()
                            .makupFill(with: .blue, width: width, height: height)
                        
                        Capsule()
                            .makupFill(with: .pink, width: width, height: height)
                    }
                }
                
                HStack{
                    
                    Text("width")
                    
                    Slider(value: $width, in: 50...100)
                }
                
                HStack{
                    
                    Text("height")
                    
                    Slider(value: $height, in: 50...100)
                }
            }
            
        }
    }
    
    @State private var angleDegrees: Double = 0
    
    var doRotatedShape: some View {
        
        VExampleView("RotatedShape") {
            /*:
             `RotatedShape`可以将原Shape进行旋转，
             通过设置`angle`来决定旋转的角度，
             `anchor`决定了旋转的锚点，是`UnitPoint`类型的，
             可以使用系统提供的便捷锚点，也可以自定义锚点。
             */
            RotatedShape(
                shape: Rectangle(),
                angle: Angle.degrees(angleDegrees),
                anchor: .topLeading
            )
            .makupStroke(with: .blue)
            
            RotatedShape(
                shape: Rectangle(),
                angle: Angle.degrees(angleDegrees),
                anchor: .center
            )
            .makupStroke(with: .red)
            
            RotatedShape(
                shape: Rectangle(),
                angle: Angle.degrees(angleDegrees),
                anchor: .init(x: 0.25, y: 0.25)
            )
            .makupStroke(with: .green)
            
            Slider(value: $angleDegrees.animation(), in: 0...360)
                .padding()
        }
    }
    
    var doContainerRelativeShape: some View {
        Text("0")
    }
    
    @State private var widthSacle: CGFloat = 1.0
    @State private var heightSacle: CGFloat = 1.0
    
    var doScaledShape: some View {
        
        VExampleView("ScaledShape") {
            
            ScaledShape(
                shape: Ellipse(),
                scale: CGSize(width: widthSacle, height: heightSacle),
                anchor: .top
            )
            .makupStroke(with: .red)
            
            Slider(value: $widthSacle.animation(), in: -1...2, step: 0.1)
                .padding()
            
            Slider(value: $heightSacle.animation(), in: -1...2, step: 0.1)
                .padding()
        }
    }
    
    @State private var offsetX: CGFloat = 1.0
    @State private var offsetY: CGFloat = 1.0
    
    var doOffsetShape: some View {
        
        VExampleView("OffsetShape") {
            
            OffsetShape(
                shape: Rectangle(),
                offset: CGSize(width: offsetX, height: offsetY)
            )
            .makupStroke(with: .green)

            Slider(value: $offsetX.animation(), in: -50...50)
                .padding()
            
            Slider(value: $offsetY.animation(), in: -50...50)
                .padding()
        }
    }
    
    var doTransformedShape: some View {
        
        /*:
         `TransformedShape`可以将原Shape根据`CGAffineTransform`进行转换，是以上几种转换的核心方法。
         */
        VExampleView("TransformedShape") {
            
            TransformedShape(
                shape: Rectangle(),
                transform: CGAffineTransform(scaleX: widthSacle, y: heightSacle)
            )
            .makupStroke(with: .blue)
            .frame(width: 100, height: 70)
        }
    }
    
    
    var doInsettableShape: some View {
        
        /*:
         遵守`InsettableShape`协议的Shape将具备装饰功能，也就是为Shape进行描边、填充等设置，
         在`fill`和`stroke`部分我们已经知道，可以通过`ShapeStyle协议`和`StrokeStyle类型`来完成对一个Shape的填充和描边任务，所以这个协议中的主要方法可以看做是fill和stroke的结合：
         
         ```swift
         func strokeBorder<S>(_ content: S, style: StrokeStyle, antialiased: Bool = true) -> some View where S : ShapeStyle
         
         func strokeBorder(style: StrokeStyle, antialiased: Bool = true) -> some View
         
         func strokeBorder<S>(_ content: S, lineWidth: CGFloat = 1, antialiased: Bool = true) -> some View where S : ShapeStyle
         
         func strokeBorder(lineWidth: CGFloat = 1, antialiased: Bool = true) -> some View
         ```
         
         另外，在协议内部还有一个方法`inset(by:)`，通过该方法可以对Shape进行对应维度上尺度的调整。
         比如下面示例中，对Rectangle调用`inset(by: -10)`将会在原始宽、高的基础上增加10单位，
         而调用`inset(by: 10)`将会减少10单位，其他Shape作用一样，只不过是调整的维度不同。
         
         ```swift
         /// Returns `self` inset by `amount`.
         func inset(by amount: CGFloat) -> Self.InsetShape
         ```
         */
        
        HExampleView("InsettableShape"){
    
            ZStack{
                
                Rectangle()
                    .inset(by: -10)
                    .fill(Color.blue)
                    .frame(width: 80, height: 50)
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 80, height: 50)
                
                Rectangle()
                    .inset(by: 10)
                    .fill(Color.green)
                    .frame(width: 80, height: 50)
            }
            .padding()
            
            ZStack{
                
                Circle()
                    .inset(by: -10)
                    .fill(Color.blue)
                    .frame(width: 80, height: 80)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 80, height: 80)
                
                Circle()
                    .inset(by: 10)
                    .fill(Color.green)
                    .frame(width: 80, height: 80)
            }
            .padding()
        }
    }
}

fileprivate extension Shape {
    
    func makupStroke(with color: Color) -> some View {
        self.stroke(color, lineWidth: 1)
            .frame(width: 100, height: 70)
    }
    
    func makupFill(with color: Color, width: CGFloat, height: CGFloat) -> some View {
    
        self.fill(color)
            .frame(width: width, height: height)
    }
}

struct DoShape_Previews: PreviewProvider {
    static var previews: some View {
        DoShape()
    }
}
