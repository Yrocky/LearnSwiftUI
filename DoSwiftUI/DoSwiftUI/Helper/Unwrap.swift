//
//  Unwrap.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/2/9.
//

import SwiftUI

struct Unwrap<Value, Content>: View where Content: View {
    
    var value: Value?
    var content: (Value) -> Content
    
    init(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.content = content
    }
    
    var body: some View {
        if let value = value {
            content(value)
        } else {
            EmptyView()
        }
    }
}

struct HaveOptionValueView: View {

    var someOptionValue: String?
    
    var body: some View{
        /*:
         如果某些View需要根据option value来决定是都展示，得益于function builder功能，我们可以这么写：
         
         ```swift
         if let value = someOptionValue {
             Text(value)
         }
         ```
         
         但是这样的写法会让整体的View变得很臃肿，可读性变得很差。虽然可以将解包操作放到计算属性中，但是过多的解包计算属性也会造成代码很冗余。
         
         这个时候我们应该考虑的是将这个逻辑封装起来，提供一个Unwrap-View，只在option value被解包的时候才展示具体的View，如果不存在，就提供一个EmptyView。
         
         ```swift
         struct Unwrap<Value, Content>: View where Content: View {
             
             var value: Value?
             var content: (Value) -> Content
             
             init(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
                 self.value = value
                 self.content = content
             }
             
             var body: some View {
                 if let value = value {
                     content(value)
                 } else {
                     EmptyView()
                 }
             }
         }
         ```
         */
        VStack{
            if let value = someOptionValue {
                Text(value)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            
            Unwrap(someOptionValue) {
                Text($0)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
        }
        .padding()
        .background(Color.pink)
        .cornerRadius(4)
    }
}

struct HaveOptionValueExampleView: View {
    
    var body: some View{
        VStack{
            HaveOptionValueView(someOptionValue: "Hello")
            
            HaveOptionValueView()
        }
    }
}
