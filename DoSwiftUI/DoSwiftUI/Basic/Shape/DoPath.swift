//
//  DoPath.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoPath: View {
    var body: some View {
        ExampleContainerView("Path") {
         
            doBasic
            
            doDrawWithAddLine
            
            doDrawWithAddRect
            
            doDrawWithArc
            
            doBézierCurve
            
            doCloseSubpath
        }
    }
    
    var doBasic: some View {
        HExampleView("基础用法", height: 60) {
            /*:
             在swiftUI中，`Path`是构建`Shape`的重要结构，和我们使用CoreGraphics开发的时候一样，
             Path可以看做是CGPath在swiftUI中的实现。
             在iOS中，画布是从左上角为`{0,0}`开始的，水平向右为x轴正方向，垂直向下为y轴正方向。
             */
            Group{
                
                Path(aCGPath)
                    .stroke(Color.green)
                
                Path(CGRect(origin: .zero, size: CGSize(width: 60, height: 45)))
                    .stroke(Color.orange)
                    
                Path(ellipseIn: CGRect(origin: .zero, size: CGSize(width: 60, height: 30)))
                    .stroke(Color.purple)
                    
                Path(roundedRect: CGRect(origin: .zero, size: CGSize(width: 60, height: 40)), cornerRadius: 10)
                    .stroke(Color.blue)
            }
            .frame(width: 60, height: 60, alignment: .center)
            .border(Color.gray.opacity(0.2))
        }
    }
    
    var doDrawWithAddLine: some View {
        
        HExampleView("Draw with addLine", height: 60) {
            Group{
                
                /*:
                 `move`负责前往一个目标点，一般用来做笔触的起点，
                 而其他的诸如`addLine`、`addQuadCurve`、`addCurve`、`addEllipse`、`addArc`等等负责绘制特殊的线条，同时会移动笔触到线条的终点。
                 */
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: 60, y: 0))
                    path.addLine(to: CGPoint(x: 30, y: 60))
                    path.closeSubpath()
                }
                .stroke(Color.red, lineWidth: 1)
                
                Path { path in
                    for i in 0...6 {
                        path.move(to: CGPoint(x: 0, y: i * 10))
                        path.addLine(to: CGPoint(x: 60, y: i * 10))
                    }
                }
                .stroke(Color.orange, lineWidth: 1)
                
                Path { path in
                    for i in 0...6 {
                        path.move(to: CGPoint(x: i * 10, y: 0))
                        path.addLine(to: CGPoint(x: i * 10, y: 60))
                    }
                }
                .stroke(Color.green)
                
                Path{ path in
                    
                    for i in 0...6 {
                        path.move(to: CGPoint(x: 0, y: i * 10))
                        path.addLine(to: CGPoint(x: 60, y: i * 10))
                    }
                    
                    for i in 0...6 {
                        path.move(to: CGPoint(x: i * 10, y: 0))
                        path.addLine(to: CGPoint(x: i * 10, y: 60))
                    }
                }
                .stroke(Color.purple)
            }
            .border(Color.gray.opacity(0.2))
        }
    }
    
    var doDrawWithAddRect: some View {
        HExampleView("Draw with addRect", height: 60) {
            
            Group {
                Path { path in
                    path.move(to: .zero)
                    path.addRect(CGRect(origin: .zero, size: CGSize(width: 60, height: 60)))
                }
                .stroke(Color.red)
                
                Path { path in
                    path.move(to: .zero)
                    path.addRects([
                        CGRect(origin: .zero, size: CGSize(width: 30, height: 60)),
                        CGRect(origin: CGPoint(x: 35, y: 0), size: CGSize(width: 30, height: 60)),
                    ])
                }
                .stroke(Color.green)
                
                Path{ path in
                    path.move(to: .zero)
                    path.addRect(CGRect(origin: .zero, size: CGSize(width: 30, height: 30)), transform: .init(scaleX: 2, y: 2))
                }
                .stroke(Color.orange)
            }
            .border(Color.gray.opacity(0.2))
        }
    }
    
    @State private var endAngle: Double = 145
    
    var doDrawWithArc: some View {
        VExampleView("Draw with arc", height: 100) {
            
            HStack{
                
                Group{
                    
                    Path{ path in
                        path.move(to: CGPoint(x: 60, y: 30))
                        path.addArc(center: CGPoint(x: 30, y: 30), radius: 30, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: endAngle), clockwise: true)
                    }
                    .stroke(Color.purple)
                    
                    Path{ path in
                        path.move(to: CGPoint(x: 60, y: 30))
                        path.addArc(center: CGPoint(x: 30, y: 30), radius: 30, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: endAngle), clockwise: false)
                    }
                    .stroke(Color.purple)
                    
                    ZStack{
    
                        Path{ path in
                            path.move(to: CGPoint(x: 60, y: 30))
                            path.addArc(center: CGPoint(x: 30, y: 30), radius: 30, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 270), clockwise: true)
                        }
                        .stroke(Color.red, lineWidth: 4)
                        
                        Path { path in
                            path.move(to: CGPoint(x: 30, y: 0))
                            path.addArc(tangent1End: CGPoint(x: 60, y: 0), tangent2End: CGPoint(x: 60, y: 60), radius: 30)
                        }
                        .stroke(Color.green)
                    }
                }
                .border(Color.gray.opacity(0.2))
            }
            
            Slider(value: $endAngle, in: 1...359)
        }
    }
    
    var doBézierCurve: some View {
        HExampleView("Bézier curve", height: 60) {
            
            Group {
                
                Path{ path in
                    path.move(to: CGPoint(x: 0, y: 30))
                    path.addQuadCurve(to: CGPoint(x: 30, y: 30), control: CGPoint(x: 20, y: 0))
                    path.addQuadCurve(to: CGPoint(x: 60, y: 30), control: CGPoint(x: 40, y: 80))
                }
                .stroke(Color.blue)
                
                Path{ path in
                    path .move(to: CGPoint(x: 0, y: 30))
                    path.addCurve(to: CGPoint(x: 60, y: 30),
                                  control1: CGPoint(x: 20, y: -10),
                                  control2: CGPoint(x: 40, y: 80))
                }
                .stroke(Color.red)
                
            }
            .border(Color.gray.opacity(0.2))
        }
    }
    var doCloseSubpath: some View {
        HExampleView("closeSubpath", height: 60) {
           
            /*:
             如果最终绘制的终点和起点是一样的，那么图形看起来是闭合的，
             一般不会有什么差异，但如果使用特殊的折角类型，或者笔画宽度比较大，
             还是可以看出来差异的，所以一般会使用`closeSubpath`来封闭图形。
             */
            
            Path{ path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 60, y: 0))
                path.addLine(to: CGPoint(x: 30, y: 60))
                path.addLine(to: .zero)
            }
            .stroke(Color.purple, lineWidth: 4)
            
            Path{ path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 60, y: 0))
                path.addLine(to: CGPoint(x: 30, y: 60))
                path.closeSubpath()
            }
            .stroke(Color.orange, lineWidth: 4)
        }
    }
    var doDraw_2: some View {
        VExampleView("Draw", height: 200) {
        }
    }
    
    var aCGPath: CGPath {
        CGPath(
            rect: aCGRect,
            transform: nil)
    }
    
    var aCGRect: CGRect {
        CGRect(
            origin: .zero,
            size: .init(width: 40, height: 40)
        )
    }
}

struct DoPath_Previews: PreviewProvider {
    static var previews: some View {
        DoPath()
    }
}
