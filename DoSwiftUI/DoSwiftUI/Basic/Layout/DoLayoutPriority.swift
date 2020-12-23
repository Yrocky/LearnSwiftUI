//
//  DoLayoutPriority.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoLayoutPriority: View {
    
    var body: some View {
        
        doBasic
        
        doWithFixedSize
    }
    
    var doBasic: some View {
    
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
        .frame(width: 300, height: 100)
        .border(Color.gray.opacity(0.2))
    }
    
    var doWithFixedSize: some View {
        
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
        .frame(width: 300, height: 100)
        .border(Color.gray.opacity(0.2))
        .padding(.top, 10)
    }
}

struct DoLayoutPriority_Previews: PreviewProvider {
    static var previews: some View {
        DoLayoutPriority()
    }
}