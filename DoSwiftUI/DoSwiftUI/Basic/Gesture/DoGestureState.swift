//
//  DoGestureState.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/2/8.
//

import SwiftUI

struct DoGestureState: View {
    var body: some View {
        VStack{
    
            LongPressView()
            
            DragView()
            
            ExampleDragableView()
        }
    }
}

struct LongPressView: View {
    
    @GestureState private var isLongPressTap = false
    @State private var isPressTap = false
    
    var body: some View{
        Image(systemName: "star.circle.fill")
            .font(.system(size: 100))
            .foregroundColor(.pink)
            .opacity(isLongPressTap ? 0.5 : 1)
            .scaleEffect(isPressTap ? 0.5 : 1)
            .animation(.easeInOut)
            .gesture(longPressGesture)
    }
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 1)
            // 通过`updateing`来修改状态
            .updating($isLongPressTap) { (current, state, transaction) in
                state = current
            }
            .onEnded { _ in
                self.isPressTap.toggle()
            }
    }
}


struct DragView: View {
    
    @GestureState private var offset = CGSize.zero
    
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View {
        
        VStack{
            /*:
             使用DragGesture以及其Value中的translation，我们可以在移动的时候同时对Image进行偏移，这样可以达到Image跟随手指的效果，但是在手势终止的时候，Image会回到原始位置，很显然是由于没有记录最后位置导致的，所以我们还需要一个变量来记录Image最新的位置。
             */
            Image(systemName: "star.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.pink)
                .offset(offset)
                .animation(.easeInOut)
                .gesture(dragGesture)
            /*:
             
             */
            Image(systemName: "star.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
                .offset(
                    x: dragOffset.width + position.width,
                    y: dragOffset.height + position.height
                )
                .animation(.easeInOut)
                .gesture(dragGestureWithPosition)
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($offset) { (current, state, transaction) in
                // 将current中的数据绑定到GestureState上，DragGesture的Value为
                state = current.translation
            }
    }
    
    var dragGestureWithPosition: some Gesture {
        DragGesture()
            .updating($dragOffset) { (value, state, trans) in
                state = value.translation
            }
            .onEnded { (value) in
                self.position.width += value.translation.width
                self.position.height += value.translation.height
            }
    }
}

struct LongPressDragView: View {
    /*:
     接着我们来做一个需要长按超过一定的时间，然后可以响应拖拽的View，这其中，就涉及到手势之间的先后顺序。
     我们需要把前面两个View中运用到的结合到一起。
     */
    
    @GestureState private var isPressed = false
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View{
        
        Image(systemName: "star.circle.fill")
            .font(.system(size: 100))
            .foregroundColor(.pink)
            .opacity(isPressed ? 0.5 : 1)
            .offset(
                x: dragOffset.width + position.width,
                y: dragOffset.height + position.height
            )
            .gesture(
                longPressGesture
                    .sequenced(before: dragGesture)
            )
    }
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 3)
            .updating($isPressed) { (current, state, trans) in
                state = current
            }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { (value, state, trans) in
                state = value.translation
            }
            .onEnded { value in
                self.position.width += value.translation.width
                self.position.height += value.translation.height
            }
    }
}


struct DragableView<Content>: View where Content: View {
    
    private var content: () -> Content
    private var minimumDuration: Double = 3
    
    @GestureState private var isPressed = false
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    init(
        minimumDuration: Double = 3,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.minimumDuration = minimumDuration
    }
    
    var body: some View{
        content()
            .opacity(isPressed ? 0.5 : 1)
            .animation(.easeInOut)
            .offset(
                x: dragOffset.width + position.width,
                y: dragOffset.height + position.height
            )
            .gesture(
                longPressGesture
                    .sequenced(before: dragGesture)
            )
    }
    
    private var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: minimumDuration)
            .updating($isPressed) { (current, state, trans) in
                state = current
            }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { (value, state, trans) in
                state = value.translation
            }
            .onEnded { value in
                self.position.width += value.translation.width
                self.position.height += value.translation.height
            }
    }
}

struct ExampleDragableView: View {
    
    var body: some View{
        
        DragableView(minimumDuration: 1) {
            
            HStack {
                Image("icon_tecxture_3")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Young Rocky")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                    
                    Text("Chain ShangHai minhang R.renmin NO.10086")
                        .font(.system(size: 14))
                }
            }
            .padding(4)
            .border(Color.pink)
        }
    }
}
