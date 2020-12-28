//
//  DoBasicGesture.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/28.
//

import SwiftUI

struct DoBasicGesture: View {
    var body: some View {
        
        ExampleContainterView("BasicGesture") {
            
            doGesture
            
            doTapGesture
            
            doLongPressGesture
            
            doDragGesture
            
            doMagnificationGesture
            
            doRotationGesture
        }
    }
    
    var doGesture: some View {
        VExampleView("Gesture") {
            /*:
             在swiftUI中，`Gesture`协议是对手势的抽象，其定义如下：
             
             ```swift
             public protocol Gesture {

                 associatedtype Value
                 associatedtype Body : Gesture
                 var body: Self.Body { get }
             }
             ```
             虽然Gesture也有body属性，但是其并不是一个View，
             其中的`Value`表示手势所能`引起何种数据的变化`，这一点在下面几个常用手势中很重要。
             
             我们可以通过`onChanged`、`updating`、`onEnded`来获取Gesture状态变化的回调。
             updating通过`GestureState`可以让我们的View与Gesture的状态进行绑定，
             同样的，Gesture状态的改变直观的表示就是其协议中Value的改变。
             onChanged是用来获取Value发生改变之后的回调，只要Value改变一次，就会调用一次。
             onEnd是手势结束时候的回调，正常结束、异常结束都会调用，
             比如LongPressGesture，可以设置最小、最长按压时间，
             如果在最小时间之前、最长时间之后移开手指就会调用该回调。
             */
        }
    }
    
    @State var tapCounter = 0
    
    var doTapGesture: some View {
        HExampleView("TapGesture") {
            
            /*:
             `TapGesture`是对点击手势的抽象，其Value为`()`，也就是说他并不会引起任何数据的变化，
             因此我们不能调用`onChanged`来获取Value的变化回调。同时，调用`updating`也是无意义的。
             */
            let tapGesture = TapGesture(count: 1)
                .onEnded {
                    tapCounter += 1
                    print("tap gesture end")
                }
            
            Text("Taped \(tapCounter)")
                .font(.system(size: 17))
                .foregroundColor(.orange)
            
            Circle()
                .fill(Color.orange)
                .frame(width: 60, height: 60)
                .gesture(tapGesture)
        }
    }
    
    @GestureState var longPressGestureState = false
    @State var longPressGestureCounter = 0
    @State var longPressGestureIsActive = false
    
    var doLongPressGesture: some View {
        HExampleView("LongPressGesture") {
            /*:
             
             */
            let longPressGesture = LongPressGesture(minimumDuration: 2, maximumDistance: 5)
                .updating($longPressGestureState) { (currentState, gestureState, transaction) in
                    gestureState = currentState
                }
                .onChanged { _ in
                    longPressGestureCounter += 1
                }
                .onEnded { value in
                    longPressGestureIsActive = value
                }
            
            Text("LongPress \(longPressGestureCounter)")
                .font(.system(size: 17))
                .foregroundColor(.red)
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 60)
                .gesture(longPressGesture)
            
            Toggle(isOn: $longPressGestureIsActive) {
                
            }
            .toggleStyle(DoToggle.MyToggleStyle())
        }
    }
    
    @Environment(\.exampleViewWidth)
    private var exampleViewWidth: CGFloat
    
    let colors: [Color] = [
        .red,
//        .green, .orange, .purple, .blue
    ]
    
    @State var inRectangle = false
    @GestureState var dragGestureLocation = CGPoint.zero
    @GestureState var dragGestureOffset = CGSize.zero
    
    @State private var state : DragGestureState = DragGestureState()
    
    var doDragGesture: some View {
        
        VExampleView("DragGesture") {
         
            let dragGesture = DragGesture(minimumDistance: 10, coordinateSpace: .local)
                .updating($dragGestureOffset) { (value, state, transaction) in
                    state = value.translation
                }
            
            HStack {
            
                ForEach(colors) {
                    Circle()
                        .fill($0)
                        .frame(width: 60, height: 60)
                        .offset(dragGestureOffset)
                        .gesture(dragGesture)
                        .animation(.easeInOut)
                }
            }
            
            RubbishView(state.location)
                .frame(height: 70)
        }
    }

    var doMagnificationGesture: some View {
        VExampleView("MagnificationGesture") {
            
        }
    }
    
    var doRotationGesture: some View {
        VExampleView("RotationGesture") {
            
        }
    }
    
    private struct DragGestureState {
        
        var location: CGPoint = .zero
        var translation: CGSize = .zero
        
        mutating func updating(with state: DragGesture.Value) {
            location = state.location
            translation = state.translation
        }
    }
    
    struct RubbishView: View {
        
        var targetPoint: CGPoint? = nil
        
        init(_ targetPoint: CGPoint? = nil) {
            self.targetPoint = targetPoint
        }
        
        var body: some View{
        
            GeometryReader{ proxy in
                Rectangle()
                    .strokeBorder(borderColor(with: proxy.frame(in: .local)), style: strokeStyle)
                    .frame(
                        width: proxy.frame(in: .local).size.width,
                        height: proxy.size.height
                    )
            }
        }
        
        func borderColor(with rect: CGRect) -> Color {
            if isTargetPoint(in: rect) {
                return .gray
            }
            return .orange
        }
        
        func isTargetPoint(in rect: CGRect) -> Bool {
            if let target = targetPoint {
                return rect.contains(target)
            }
            return false
        }
        
        var strokeStyle: StrokeStyle {
            StrokeStyle(
                lineWidth: 1,
                lineCap: .round,
                lineJoin: .round,
                miterLimit: 3,
                dash: [5,10],
                dashPhase: 3
            )
        }
    }
}

struct DoBasicGesture_Previews: PreviewProvider {
    static var previews: some View {
        DoBasicGesture()
    }
}
