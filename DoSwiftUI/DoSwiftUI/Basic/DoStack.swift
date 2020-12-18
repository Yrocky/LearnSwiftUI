//
//  DoStack.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoStack: View {
    var body: some View {
        /*:
         在前面的学习中，我们使用了很多的`*Stack`来完成一些布局：HStack、VStack、ZStack，
         他们分别表示水平方向、垂直方向以及屏幕纵向上的布局。
         
         VStack和HStack都会根据其子View类撑起对应的尺寸，
         当然我们也可以使用`.frame`来设置指定的尺寸。
         */
        VStack(alignment: .center){
            
            doHStack
            
            doZStack
        }
        .background(Color.red)
    }
    
    var doHStack: some View {
        /*:
         `*Stack`中都允许我们使用`alignment`来设置对齐方式，
         只不过在具体的布局中有一些区别。
         */
        HStack(alignment: .top){
            Text("1 Hello, World!")
            Text("2 Hello, World!")
            Text("3 Hello, World!")
            Text("4 Hello, World!")
            Text("5 Hello, World!")
            Text("6 Hello, World!")
        }
        .border(Color.green)
    }
    
    var doZStack: some View {
        /*:
         使用ZStack可以将子View作为有视觉层级的进行排布，
         最后添加的最接近眼睛，而先添加的会被后添加的View所遮挡。
         */
        ZStack(alignment: .topLeading){
            Rectangle()
                .fill(Color.blue)
//                    .opacity(0.3)
                .frame(height: 100)
            Text("This is a message.")
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
                .opacity(0.3)
                .frame(height: 120)
        }
        .border(Color.gray)
        .padding()
        .border(Color.white)
    }
}

struct DoStack_Previews: PreviewProvider {
    static var previews: some View {
        DoStack()
    }
}
