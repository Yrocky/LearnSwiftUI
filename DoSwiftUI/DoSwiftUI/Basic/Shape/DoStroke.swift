//
//  DoStroke.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoStroke: View {
    
    var body: some View {
        
        VStack(spacing: 10){
        
            doStroke
            
            doStrokeStyle
        }
    }
    
    var doStroke: some View {
    
        /*:
         `stroke`用来为Shape进行描边，所以这个方法只有遵守Shape协议的View才可以调用。
         另外需要注意的是，`stroke`的几个方法还是有区别的：
         
         ```swift
         func stroke<S>(_ content: S, style: StrokeStyle) -> some View where S : ShapeStyle
         func stroke<S>(_ content: S, lineWidth: CGFloat = 1) -> some View where S : ShapeStyle
         
         func stroke(style: StrokeStyle) -> some Shape
         func stroke(lineWidth: CGFloat = 1) -> some Shape
         ```
         
         可以看到，前两个返回的是`some View`，后面两个返回的是`some Shape`。
         这是因为一个Shape基本上可以分离成`笔触`和`填充`，
         笔触就是这里的style（StrokeStyle类型），而填充则是content（ShapeStyle），
         通过前两个方法已经完成了设置笔触和填充，后面两个方法只是设置了笔触（使用lineWidth表示默认使用直线描边），
         所以经过前面两个方法之后的返回值并不允许再次修改笔触或者填充。
         
         */
        
        ScrollView(.horizontal){
            
            HStack(spacing: 10){
                
                Rectangle()
                    //: 调用第四个方法
                    .stroke()
                    .fill(Color.red.opacity(0.2))
                    .frame(width: 100, height: 50)
                
                Circle()
                    //: 调用第二个方法
                    .stroke(Color.green.opacity(0.2))
                    //: 下面这个方法不可以调用，因为返回的是some View，其不具备fill函数
                    //.fill(Color.green)
                    .frame(width:50, height: 50)
                
                Capsule()
                    //: 调用第二个方法
                    .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                    //: 同上
                    //.fill(Color.green)
                    .frame(width:100, height: 50)
                
                Capsule()
                    //: 调用第四个方法
                    .stroke(lineWidth: 3)
                    //: 由于在stroke中没有设置content，所以这里会使用fill的颜色
                    .fill(Color.pink.opacity(0.2))
                    .frame(width:100, height: 50)
                
                Capsule()
                    //: 调用第一个方法
                    .stroke(
                        Color.purple.opacity(0.2),
                        style: strokeStyle
                    )
                    .frame(width: 100, height: 50)
                
                Capsule()
                    //: 调用第三个方法
                    .stroke(style: strokeStyle)
                    //: 由于在stroke中没有设置content，只设置了style，所以这里会使用fill的颜色
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 100, height: 50)
            }
            .padding()
        }
        .frame(width: 300, height: 100)
        .border(Color.gray.opacity(0.2))
        
    }
    
    var strokeStyle: StrokeStyle{
        
        StrokeStyle(
            lineWidth: 3,
            lineCap: .round,
            lineJoin: .miter,
            miterLimit: 0,
            dash: [5, 10],
            dashPhase: 0
        )
    }
    
    var doStrokeStyle: some View {
        
        ScrollView(.horizontal){

            HStack{
                /*:
                 在fill部分我们已经了解了ShapStyle，现在来了解一下`StrokeStyle`，
                 通过这个结构体我们可以决定描边线条的样式，包括但不限于：线宽、拐角链接方式、虚线等等。
                 
                 下面我们不仅设置了stroke还设置了broder，最后结果我们拥有了两个`描边`，一个是虚线一个是实线，
                 虚线是为Shape添加的描边，而实线则是为View添加的描边。
                 */
                Rectangle()
                    .stroke(style:
                                StrokeStyle(
                                    lineWidth:4,
                                    lineCap: .round,
                                    dash: [5,10])
                    )
                    .border(Color.orange, width: 2)
                    .frame(width: 100, height: 70)
                
                Rectangle()
                    .stroke(style:
                                StrokeStyle(
                                    lineWidth:4,
                                    lineCap: .square,
                                    dash: [5,10])
                    )
                    .frame(width: 100, height: 70)
            }
            .padding()
        }
        .frame(width: 300, height: 100)
        .border(Color.gray.opacity(0.2))
    }
}

struct DoStroke_Previews: PreviewProvider {
    static var previews: some View {
        DoStroke()
    }
}
