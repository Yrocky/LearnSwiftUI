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
    
    struct MyShape: Shape {
        func path(in rect: CGRect) -> Path {
            Path()
        }
    }
}

struct DoCustomShape_Previews: PreviewProvider {
    static var previews: some View {
        DoCustomShape()
    }
}
