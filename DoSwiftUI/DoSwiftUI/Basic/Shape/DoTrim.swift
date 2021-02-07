//
//  DoTrim.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/24.
//

import SwiftUI

struct DoTrim: View {
    var body: some View {
        ExampleContainerView("trim") {
         
            doBasic
        }
    }
    
    var doBasic: some View {
        VExampleView("basic") {
            /*:
             trim，意为裁剪，相当于Sketch软件中的剪刀，不过在SwiftUI中trim被表示为在原始View上裁剪出一个范围，最终只展示这一部分。
             需要注意的是，这个modifer只对Shape拓展的，前面我们知道，一个形状有描边以及填充两种核心概念，描边在SwiftUI中是使用stroke来实现，填充使用fill来实现。
             */
            
            Rectangle()
                .trim(from: 0, to: 0.5)
                .stroke(Color.pink, lineWidth: 1)
                .background(Color.progressBackgroundColor)
                .frame(width: 200, height: 40)
            
            Circle()
                .trim(from: 0.3, to: 0.9)
                .fill(Color.progressBackgroundColor)
                .frame(width: 50, height: 50)
            
            Circle()
                .trim(from: 0.3, to: 0.9)
                .stroke(Color.pink, lineWidth: 1)
                .frame(width: 50, height: 50)
            
            ZStack{
                Rectangle()
                    .trim(from: 0, to: 0.5)
                    .fill(Color.progressBackgroundColor)
                    .frame(width: 100, height: 40)
                
                Rectangle()
                    .trim(from: 0.5, to: 1)
                    .fill(Color.pink)
                    .frame(width: 100, height: 40)
            }
        }
    }
}

struct DoTrim_Previews: PreviewProvider {
    static var previews: some View {
        DoTrim()
    }
}
