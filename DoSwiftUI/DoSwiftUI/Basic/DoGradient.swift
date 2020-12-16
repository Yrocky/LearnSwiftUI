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
                RadialGradient(
                    gradient: Gradient(colors: [.red, .blue, .green]),
                    center: .center,
                    startRadius: 5,
                    endRadius: 90
                )
                LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                               startPoint: .leading,
                               endPoint: .trailing)
                    .padding()
                Text("Hello")
                    .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading
                                                    , endPoint: .trailing))
            }.frame(width: 300, height: 100)
        }
    }
}

struct DoGradient_Previews: PreviewProvider {
    static var previews: some View {
        DoGradient()
    }
}
