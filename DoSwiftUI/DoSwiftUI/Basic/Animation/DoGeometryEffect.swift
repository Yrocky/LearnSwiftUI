//
//  DoGeometryEffect.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/29.
//

import SwiftUI

struct DoGeometryEffect: View {
    var body: some View {
        
        ExampleContainterView("GeometryEffect") {
               
            doHeroAnimation
        }
    }
    
    @Namespace private var ns
    @State private var showCircle = false
    
    var doHeroAnimation: some View {
        
        HExampleView("Hero animation") {
         
            /*:
             通过这个动画，我们会发现，并没有按照我们预期的那样很连续的修改，
             只是系统做了一个对两个View的offset、opacity动画而已，衔接的并不连贯。
             */
            if !showCircle {
                
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 100, height: 60)
                    .matchedGeometryEffect(id: "shap", in: ns)
            }
            
            Button("make it animation"){
                withAnimation(.easeIn(duration: 2)) {
                    showCircle.toggle()
                }
            }
            
            if showCircle {
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 60, height: 60)
                    .matchedGeometryEffect(id: "shap", in: ns)
            }
        }
    }
}

extension View {

    
}

struct DoGeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        DoGeometryEffect()
    }
}
