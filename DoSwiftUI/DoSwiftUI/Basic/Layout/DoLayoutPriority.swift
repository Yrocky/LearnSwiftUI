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
            
//            doBasic
//
//            doWithFixedSize
            
            doText
            
            doModifLayoutPriority
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
    
    var doText: some View {
        VExampleView("提升 layoutPriority 展示全部信息") {
         
            /*:
             通过前面我们知道，父View在为子View布局的时候会根据子View设置的frame来计算，那时我们提到了一个灵活性的(`flexible`)，灵活性越低的View，布局的优先级越高。另外，还可以通过`layoutPriority`来直接提高布局的优先级，默认的所有View的优先级都为0，通过为View设置一个大于0的值来提高布局的优先性。比如下面右边的Text是长文本，由于父View空间的限制，展示不全，这时候为他设置priority为1，结果会挤压左边的Text，从而显示完全。
             
             我们发现，Image并没有被挤压，这是由于他已经有了固定的尺寸，在布局的时候优先级最高。
             */
            HStack{
                Text("Hi")
                
                Image("icon_tecxture_1")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("I'm Rocky Young, is an iOS Enginner.")
            }
            .frame(width: 210, height: 50)
            .background(Color.green.opacity(0.2))
            
            HStack{
                Text("Hi")
                
                Image("icon_tecxture_1")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("I'm Rocky Young, is an iOS Enginner.")
                    .layoutPriority(1)
            }
            .frame(width: 210, height: 50)
            .background(Color.pink.opacity(0.2))
        }
    }
    
    @State private var leftLayoutPriority: Double = 0
    @State private var midLayoutPriority: Double = 0
    @State private var rightLayoutPriority: Double = 0
    
    var doModifLayoutPriority: some View {
        VExampleView("动态修改 LayoutPriority") {
            HStack{
                Text("Hi")
                    .layoutPriority(leftLayoutPriority)
                
                Image("icon_tecxture_1")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("I'm Rocky Young,")
                    .layoutPriority(midLayoutPriority)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                
                Text("is an iOS Enginner.")
                    .layoutPriority(rightLayoutPriority)
            }
            .frame(width: 250, height: 50)
            .background(Color.pink.opacity(0.2))
            
            Stepper("left \(Int(leftLayoutPriority))", value: $leftLayoutPriority)
            
            Stepper("mid \(Int(midLayoutPriority))", value: $midLayoutPriority)
            
            Stepper("right \(Int(rightLayoutPriority))", value: $rightLayoutPriority)
        }
    }
}

struct DoLayoutPriority_Previews: PreviewProvider {
    static var previews: some View {
        DoLayoutPriority()
    }
}
