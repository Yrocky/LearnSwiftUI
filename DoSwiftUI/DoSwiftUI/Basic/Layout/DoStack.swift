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
        ExampleContainerView("*Stack"){

            doHStack
            
            doVStack
            
            doZStack

            doFuncationBuilder
        }
    }
    
    var doHStack: some View {
        /*:
         `*Stack`中都允许我们使用`alignment`来设置对齐方式，
         只不过在具体的布局中有一些区别。
         */
        VExampleView("HStack") {
            
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
    }
    
    var doVStack: some View {
        
        VExampleView("VStack") {
            
            VStack(alignment: .leading) {
                /*:
                 由于VStack、HStack都可以根据内部的子View撑起尺寸，
                 所以一般来说并不需要为他们设置具体的尺寸。
                 但是如果设置的尺寸大于子View撑起的尺寸，
                 会发现View并没有按照我们设想的那样排列。
                 
                 下面例子中，子View们撑起的最大宽度为100，但是为VStack设置的width为300，
                 最终展示的效果是，这`100宽度的空间`居于`300宽度空间`的`中间`（这里高度相同，都为50），
                 而我们设想的是子这100宽度的空间在300宽度空间的最左边。
                 
                 这是为什么呢？如何实现我们设想的效果呢？
                 
                 这是因为*Stack设置的对齐方式仅仅是让子View们如何对齐，
                 通过ViewBuilder我们可以知道，子View们最终是以`TupleView`交给swiftUI去渲染的。
                 这就可以解释为什么虽然子View们可以按照正确的对齐方式排列，但是他们整体却是居中显示的，
                 因为*Stack指定的alignment是作用在子View们上的，而他们的容器TupleView默认是居中的。
                 
                 我们只需要为*Stack指定frame的时候指明另一个alignment即可：
                 `.frame(width: 300, alignment: .leading)`，设置这个alignment可以要求内部的子View如何排列。
                 具体关于alignment的内容请参考：https://swiftui-lab.com/alignment-guides/。
                 */
                Rectangle()
                    .fill(Color.red.opacity(0.2))
                    .frame(width: 100, height: 20)
                
                Rectangle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: 30, height: 20)
            }
            .frame(width: 200, alignment: .leading)
            .background(Color.gray.opacity(0.1))
        }
    }
    
    var doZStack: some View {
        /*:
         使用ZStack可以将子View作为有视觉层级的进行排布，
         最后添加的最接近眼睛，而先添加的会被后添加的View所遮挡。
         */
        
        VExampleView("ZStack") {
            
            ZStack(alignment: .topLeading){
                Rectangle()
                    .fill(Color.blue)
                    //                    .opacity(0.3)
                    .frame(height: 100)
                Text("This is a message.")
                RoundedRectangle(cornerRadius: 80)
                    .fill(Color.yellow)
                    //                .opacity(0.3)
                    .frame(height: 120)
            }
            .border(Color.gray)
            .padding()
            .border(Color.white)
        }
    }
    
    var doFuncationBuilder: some View {
        VStack{
            /*:
             在swift5.1中，我们可以省略具有返回值方法的`return`关键字，
             
             */
        }
    }
}

struct DoStack_Previews: PreviewProvider {
    static var previews: some View {
        DoStack()
    }
}
