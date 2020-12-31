//
//  DoComposingGesture.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/28.
//

import SwiftUI

struct DoComposingGesture: View {
    var body: some View {
        
        ExampleContainterView("ComposingGesture") {
            
            /*:
             前面我们接触到的手势都是单个的，如果一个视图上可能有多个手势，
             我们就需要决定手势之间的顺序或者依赖，swiftUI为我们提供了三个组合手势，可以将前面介绍的单个手势进行组合，他们分别是：
             * `ExclusiveGesture`，两个手势中只有其中一个可以生效
             * `SequenceGesture`，可以将两个手势以序列的方式依次生效
             * `SimultaneousGesture`，两个手势同时生效，和之前的`.simultaneousGesture`类似
             
             除了可以初始化对应的手势实例，swiftUI还为Gesture提供了便捷的依赖方法，来将两个手势进行依赖设置：
             ```swift
             
             func exclusively<Other>(before: Other) -> ExclusiveGesture<ExclusiveGesture<First, Second>, Other>
             
             func sequenced<Other>(before other: Other) -> SequenceGesture<Self, Other> where Other : Gesture
             
             func simultaneously<Other>(with other: Other) -> SimultaneousGesture<Self, Other> where Other : Gesture
             ```
             
             */
            
            doExclusiveGesture
            
            doSequenceGesture
            
            doSimultaneousGesture
        }
    }
    
    @GestureState private var exclusiveGestureState = ExclusiveGesture<TapGesture, DragGesture>.Value.first(())
    
    @GestureState private var dragGestureOffset: CGSize = .zero
    
    var doExclusiveGesture: some View {
        VExampleView("ExclusiveGesture") {
            /*:
             
             */
            
            let tapGesture = LongPressGesture(minimumDuration: 4)
                .onEnded { _ in
                    print("tap gesture end")
                }
            let dragGesture = DragGesture()
                .updating($dragGestureOffset){ (current, state, trans) in
                    state = current.translation
                }
                .onChanged {
                    print("drag gesture change \($0.translation)")
                }
                .onEnded { _ in
                    print("drag gesture end")
                }
            let composingGesture = dragGesture.exclusively(before: tapGesture)
            
            let exclusiveGesture = ExclusiveGesture(tapGesture, dragGesture)
                .updating($exclusiveGestureState) { current, state, trans in
                    print("gesture current:\(current)")
//                    state = .first(())
                }
            
            Circle()
                .fill(Color.orange)
                .frame(width: 60, height: 60)
                .offset(dragGestureOffset)
                .gesture(composingGesture)
        }
    }
    
    var doSequenceGesture: some View {
        VExampleView("SequenceGesture") {
            
        }
    }
    
    var doSimultaneousGesture: some View {
        VExampleView("SimultaneousGesture") {
            
        }
    }
}

struct DoComposingGesture_Previews: PreviewProvider {
    static var previews: some View {
        DoComposingGesture()
    }
}
