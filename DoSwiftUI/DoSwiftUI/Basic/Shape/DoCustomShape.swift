//
//  DoRectangle.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoCustomShape: View {
    var body: some View {
        
        ExampleContainterView("CustomShape"){
            
            doTriangle
            
            doCustomPath
            
            doLineShape
        }
    }
    
    var doTriangle: some View {
        
        /*:
         通过`Rectangle`我们可以创建一个矩形，在表现上，它属于几何学，
         并且在swiftUI中，他的使用频率还是比较高的，因此这里单独拎出来。
         
         Rectangle遵守`Shape`协议
         */
        
        VExampleView("Triangle") {
            
            Rectangle()
                .fill(Color.blue)
                .cornerRadius(3.0)
            
        }
    }
    
    var doCustomPath: some View {
        
        let gradient = LinearGradient(
            gradient: Gradient(colors: [.green, .orange]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        return VExampleView("Custom Path") {
            BalloonPath()
                .fill(gradient)
                .frame(width:100, height:100)
        }
    }
    
    @State private var toX: CGFloat = 100
    @State private var step: CGFloat = 10
    
    var doLineShape: some View {
        VExampleView("line") {
            
            Line(from: .zero, to: CGPoint(x: toX, y: 40))
                .stroke(Color.orange)
                .frame(height: 50)
            
            Stepper("Add", value: $toX.animation(), step: 40)
        }
    }
    
    struct MyShape: Shape {
        func path(in rect: CGRect) -> Path {
            Path()
        }
    }
    
    struct BalloonPath: Shape {
        func path(in rect: CGRect) -> Path {
            let p = balloon
            let bounds = p.boundingRect
            let scaleX = rect.size.width / bounds.size.width
            let scaleY = rect.size.height / bounds.size.height
            return p.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        }
        
        let balloon = Path{ p in
            p.move(to: CGPoint(x: 50, y: 0))
            p.addQuadCurve(to: CGPoint(x: 0, y: 50),
                           control: CGPoint(x: 0, y: 0))
            p.addCurve(to: CGPoint(x: 50, y: 150),
                       control1: CGPoint(x: 0, y: 100),
                       control2: CGPoint(x: 50, y: 100))
            p.addCurve(to: CGPoint(x: 100, y: 50),
                       control1: CGPoint(x: 50, y: 100),
                       control2: CGPoint(x: 100, y: 100))
            p.addQuadCurve(to: CGPoint(x: 50, y: 0),
                           control: CGPoint(x: 100, y: 0))
        }
    }
    
    struct Line: Shape {
        
        var from: CGPoint
        var to: CGPoint
        
        var animatableData: AnimatablePair<CGPoint, CGPoint>{
            get { AnimatablePair(from, to) }
            set {
                from = newValue.first
                to = newValue.second
            }
        }
        func path(in rect: CGRect) -> Path {
            Path { path in
                path.move(to: from)
                path.addLine(to: to)
            }
        }
    }
}

extension CGPoint: VectorArithmetic {
    
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    public mutating func scale(by rhs: Double) {
        x = x * CGFloat(rhs)
        y = y * CGFloat(rhs)
    }
    
    public var magnitudeSquared: Double {
        100
    }
    
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    

}

struct DoCustomShape_Previews: PreviewProvider {
    static var previews: some View {
        DoCustomShape()
    }
}
