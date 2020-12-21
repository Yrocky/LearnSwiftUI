//
//  DoGradient.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/15.
//

import SwiftUI

struct DoGradient: View {
    
    var body: some View {
        VStack{
            /*:
             swiftUI提供了3种渐变效果：
             * LinearGradient，线性渐变
             * RadialGradient，
             */
            HStack{
                
                doLinearGradient
                
                doRadialGradient
                
                doLinearGradientAsBackground
            }
            .frame(width: 300, height: 100)
        }
    }
    
    var doLinearGradient: some View {
        LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                       startPoint: .leading,
                       endPoint: .trailing)
            .padding()
    }
    
    var doRadialGradient: some View {
        RadialGradient(
            gradient: Gradient(colors: [.red, .blue, .green]),
            center: .center,
            startRadius: 5,
            endRadius: 90
        )
    }
    
    var doLinearGradientAsBackground: some View {
        Text("Hello")
            .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                                       startPoint: .leading,
                                       endPoint: .trailing))
    }
    
}

struct DoGradient_Previews: PreviewProvider {
    static var previews: some View {
        DoGradient()
    }
}
