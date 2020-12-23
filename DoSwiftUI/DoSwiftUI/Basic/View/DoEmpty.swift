//
//  DoEmpty.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/22.
//

import SwiftUI

struct DoEmpty: View {
    var body: some View {

        doInCondition
        
        doInMarco
        
    }
    
    @State var condition = true
    var doInCondition: some View {
        
        HStack{

            /*:
             我们知道在swiftUI中，所有UI都是根据结构体来创建的，
             我们操作的任何比如ScrollView、List、Image这些都并不是UI控件，
             只是在要渲染的时候，swiftUI根据这些结构体表示的`UI状态`来绘制对应的视图。
             
             在一些场景下，我们可以使用EmptyView来表示没有UI可以被渲染到屏幕上，
             比如依赖判断语句显示视图的场景，结合宏来做显示逻辑的场景。
             EmptyView不会显示任何内容的原因是，其`Body = Never`，
             因此为其设置任何的mdifer都不会生效。
             
             */
            Button(action: {
                self.condition.toggle()
            }, label: {
                Text("Tap me")
            })
            
            if condition {
                Text("Hello world!")
                    .background(Color.orange)
            } else {
                EmptyView()
                    .background(Color.red)
            }
        }
        .frame(width:400, height: 100)
        .background(Color.gray.opacity(0.2))
    }
    
    var doInMarco: some View {
        /*:
         我们可以在宏中应用EmptyView。
         */
        #if DEBUG
        return Text("Hello World <DEBUG>")
        #else
        return EmptyView()
        #endif
    }
}

struct DoEmpty_Previews: PreviewProvider {
    static var previews: some View {
        DoEmpty()
    }
}
