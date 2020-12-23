//
//  DoShape.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoShape: View {
    
    var body: some View {
        
        ScrollView(.vertical) {
    
            VStack{
                
                doBasicBuildInShap
                
                doRotatedShape
                
                doContainerRelativeShape
                
                doScaledShape
                
                doOffsetShape
                
                doTransformedShape
            }
        }
    }
    
    @State var width : CGFloat = 50
    @State var height : CGFloat = 50
    
    var doBasicBuildInShap: some View {
        
        VStack{
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    /*:
                     swiftUI内置了一些形状，都是常用的几何形状，比如
                     * Rectangle，矩形
                     * RoundedRectangle，圆角矩形，可以设置圆角大小
                     * Circle，圆形，swiftUI会选取宽、高的最小值作为直径来绘制圆形
                     * Ellipse，椭圆形
                     * Capsule，直译为胶囊，在2D上，它的四个角都是1/4圆，圆的直径为宽、高中的最小值
                     */
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
                .padding()
            }
            .frame(width: 300, height: 100)
            .border(Color.gray.opacity(0.2))
            
            Slider(value: $width, in: 50...100){
                Text("width")
            }
            .padding()
            
            Slider(value: $height, in: 50...100) {
                Text("height")
            }
            .padding()
        }
    }
    
    @State var angleDegrees: Double = 0
    
    var doRotatedShape: some View {
        
        VStack{
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
            .makupStroke(with: .orange)
            
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
    
    @State var widthSacle: CGFloat = 1.0
    @State var heightSacle: CGFloat = 1.0
    
    var doScaledShape: some View {
        
        VStack{
            
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
    
    @State var offsetX: CGFloat = 1.0
    @State var offsetY: CGFloat = 1.0
    
    var doOffsetShape: some View {
        
        VStack{
            
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
        TransformedShape(
            shape: Rectangle(),
            transform: CGAffineTransform(scaleX: widthSacle, y: heightSacle)
        )
        .makupStroke(with: .blue)
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
