//
//  DoGradient.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/15.
//

import SwiftUI

struct DoGradient: View {
    
    var body: some View {
        
        ExampleContainterView("Gradient"){
            /*:
             swiftUI提供了3种渐变效果：
             * LinearGradient，线性渐变
             * RadialGradient，
             */
            doLinearGradient
            
            doRadialGradient
            
            doLinearGradientAsBackground
        }
    }
    
    var doLinearGradient: some View {
        
        VExampleView("LinearGradient", height: 80) {
        
            LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                           startPoint: .leading,
                           endPoint: .trailing)
        }
    }
    
    var doRadialGradient: some View {
        
        VExampleView("RadialGradient", height: 80) {
            
            RadialGradient(
                gradient: Gradient(colors: [.red, .blue, .green]),
                center: .center,
                startRadius: 5,
                endRadius: 90
            )
        }
    }
    
    var doLinearGradientAsBackground: some View {
        VExampleView("将 LinearGradient 用于 background", height: 40) {
            
            Text("Hello")
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                                           startPoint: .leading,
                                           endPoint: .trailing))
        }
    }
    
}

struct DoGradient_Previews: PreviewProvider {
    static var previews: some View {
        DoGradient()
    }
}
