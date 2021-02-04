//
//  DoLayoutPriority.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoLayoutPriority: View {
    
    var body: some View {
        
        ExampleContainerView("layoutPriority") {
            
            doBasic
            
            doWithFixedSize
        }
    }
    
    var doBasic: some View {
    
        VExampleView("有 Spacer 的地方 使用 layoutPriority") {
            
            HStack(spacing: 0){
                
                /*:
                 在swiftUI的layout-system中，如果
                 */
                Text("Hello, World!")
                    .foregroundColor(.red)
                    //                .layoutPriority(0.5)
                    .border(Color.red.opacity(0.2))
                
                Spacer()
                
                Text("qwertyuiopasdfghjklzxcvbnm1234567890")
                    //                .layoutPriority(1)
                    .foregroundColor(.blue)
                    .border(Color.blue.opacity(0.2))
                
            }
            .frame(width: 200, height: 100)
        }
    }
    
    var doWithFixedSize: some View {
        
        VExampleView("View 有固定尺寸") {
            
            HStack(spacing: 0){
                
                /*:
                 而在固定尺寸的View中，设置`layoutPriority`并不会有任何作用。
                 */
                Text("Hello")
                    .frame(width: 80, height: 30)
                    .foregroundColor(.red)
                    .layoutPriority(0.5)
                    .border(Color.red.opacity(0.2))
                
                Spacer()
                
                Text(" World!")
                    .frame(width: 100, height: 30)
                    .layoutPriority(1)
                    .foregroundColor(.blue)
                    .border(Color.blue.opacity(0.2))
            }
            .frame(width: 200, height: 100)
            .padding(.top, 10)
        }
    }
}

struct DoLayoutPriority_Previews: PreviewProvider {
    static var previews: some View {
        DoLayoutPriority()
    }
}
