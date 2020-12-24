//
//  DoLazyStack.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoLazyStack: View {
    
    var body: some View {
        ExampleContainterView("Lazy*Stack"){
            
            doBasic
            
        }
    }
    
    var doBasic: some View {
        
        VExampleView("LazyHStack") {
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(0..<120){ _ in
                        contentView
                    }
                }
            }
        }
    }
    
    var contentView: some View {
        Text("Hello, World!")
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(3.0)
    }
}

struct DoLazyStack_Previews: PreviewProvider {
    static var previews: some View {
        DoLazyStack()
    }
}
