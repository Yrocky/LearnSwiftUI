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
            
            doOnTapGesture
            
            doLongPressGesture
            
            doOnLongPressGesture
            
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
    
    @State private var tapCounter = 0
    
    var doTapGesture: some View {
        HExampleView("TapGesture") {
            
            /*:
             `TapGesture`是对点击手势的抽象，其Value为`()`，也就是说他并不会引起任何数据的变化，
             因此我们不能调用`onChanged`来获取Value的变化回调。同时，调用`updating`也是无意义的。
             TapGesture初始化的时候我们可以设置`count`来实现单击、双击、三击的手势效果。
             */
            Text("Taped \(tapCounter)")
                .font(.system(size: 17))
                .foregroundColor(.orange)
                .gesture(
                    TapGesture(count: 2).onEnded({
                        print("完成一次双击")
                    })
                )
            
            Circle()
                .fill(Color.orange)
                .frame(width: 60, height: 60)
                .gesture(
                    TapGesture(count: 1)
                        .onEnded {
                            tapCounter += 1
                            print("tap gesture end")
                        }
                )
        }
    }
    
    @State private var onTapGestureCounter = 0
    
    var doOnTapGesture: some View {
        
        HExampleView("onTapGesture") {
        
            /*:
             swiftUI为我们提供了便捷添加的TapGesture的方法：`onTapGesture(count:preform:)`，
             通过该方法，我们可以设置手指个数以及点击的回调，preform回调其实就是TapGesture的`onEnd`回调。
             */
            
            Text("onTapGesture count:\(onTapGestureCounter)")
            
            Ellipse()
                .fill(Color.green)
                .frame(width: 100, height: 60)
                .onTapGesture {
                    self.onTapGestureCounter += 1
                }
        }
    }
    
    @GestureState var longPressGestureState = false
    @State private var longPressGestureCounter = 0
    @State private var longPressGestureIsActive = false
    
    var doLongPressGesture: some View {
        HExampleView("LongPressGesture") {
            /*:
             `LongPressGesture`是对长按手势的抽象，他有两个属性：
             ``` swift
             var minimumDuration: Double
             
             var maximumDistance: CGFloat
             ```
             `minimumDuration`表示最少长按多久(s)可以使手势生效，
             `maximumDistance`表示在长按的时候最大移动多少位移，可以取消手势。
             比如下面实例中对这两个属性分别设置为5和50，
             表示，至少长按5s才可以生效，0-5s这段时间内如果移动距离超过50就会取消手势。
             它的Value为一个布尔值，用来表示`长按手势是否处于响应中`，
             从手指开始接触屏幕0-5s这段时间如果位移没有超过50，就为true，否则就为false。
             */
            
            VStack(alignment: .leading){
                
                Text("GestureState: \(longPressGestureState.description)")
                
                Text("LongPress counter: \(longPressGestureCounter)")
            }
            .font(.system(size: 14))
            .foregroundColor(.red)
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 60)
                .gesture(
                    LongPressGesture(minimumDuration: 5, maximumDistance: 50)
                        .updating($longPressGestureState) { (currentState, gestureState, transaction) in
                            gestureState = currentState
                            print("LongPress transaction \(transaction)")
                        }
                        .onChanged { _ in
                            longPressGestureCounter += 1
                        }
                        .onEnded { value in
                            longPressGestureIsActive = value
                        }
                )
        }
    }
    
    @State private var onLongPressGestureState = false
    
    var doOnLongPressGesture: some View {
        
        HExampleView("onLongPressGesture") {
            /*:
             与TapGesture一样，swiftUI也为LongPressGesture提供了一个便捷添加方法：`onLongPressGesture(::::)`，
             除了初始化时候需要设置的两个变量，还有两个回调。
             由于其Value为一个布尔值，所以这两个回调：`pressing`、`perform`，
             分别表示`updating`和`onEnded`。
             */
            Capsule()
                .fill(Color(red:0.97, green:0.54, blue:0.88))
                .frame(width: 100, height: 60)
                .onLongPressGesture {
                    print("onLongPressGesture perform 1")
                }
            
            let color : Color = onLongPressGestureState ?
                Color(red:0.36, green:0.79, blue:0.96) :
                Color(red:0.40, green:0.22, blue:0.94)
            
            Circle()
                .fill(color)
                .frame(width: 60, height: 60)
                .onLongPressGesture(
                    minimumDuration: 3,
                    maximumDistance: 60
                ) { value in
                    self.onLongPressGestureState = value
                } perform: {
                    print("onLongPressGesture perform 2")
                }
        }
    }
    
    @State private var inRectangle = false
    @GestureState var dragGestureLocation = CGPoint.zero
    @GestureState var dragGestureOffset = CGSize.zero
    
    @State private var currentDragOffset: CGSize = .zero
    @State private var finalDragOffset: CGSize = .zero
    
    @State private var state : DragGestureState = DragGestureState()
    
    var doDragGesture: some View {
        
        VExampleView("DragGesture") {
            
            HStack {
            
                Circle()
                    .fill(Color.red)
                    .frame(width: 60, height: 60)
                    .offset(dragGestureOffset)
                    .animation(.easeInOut)
                    .gesture(
                        DragGesture(minimumDistance: 10, coordinateSpace: .local)
                            .updating($dragGestureOffset) { (value, state, transaction) in
                                state = value.translation
                            }
                    )
                
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 100, height: 60)
                    .offset(CGSize(width: currentDragOffset.width + finalDragOffset.width,
                                   height: currentDragOffset.height + finalDragOffset.height))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.currentDragOffset = value.translation
                            }
                            .onEnded{ value in
                                self.finalDragOffset = self.currentDragOffset
                                self.currentDragOffset = .zero
                            }
                    )
            }
            
            RubbishView(state.location)
                .frame(height: 70)
        }
    }

    @GestureState var magnifyBy = CGFloat(1.0)
    
    @State private var magnCurrentValue: CGFloat = 0
    @State private var magnFinalValue: CGFloat = 1
    
    var doMagnificationGesture: some View {
        VExampleView("MagnificationGesture") {
           
            /*:
             `MagnificationGesture`是一个`双指缩放手势`，其Value为CGFloat类型，
             其实就是手势的`minimumScaleDelta`属性，表示最小可以缩小到原始值的多少倍，
             但是并没有设置最大的尺寸限制。
             我们可以使用`updating`以及`GestureState`来记录手势的缩放比例，
             但如果想要在手势结束的时候记录下缩放比例，以保持被作用的View的尺寸，
             比如这样：
             ``` swift
             .onEnded {
                 self.magnifyBy = $0
             }
             ```
             这样会报错：`Cannot assign to property: 'magnifyBy' is a get-only property`。
             这个时候需要使用两个变量来分别记录增量和终量。这部分逻辑借鉴[hackingwithswift](https://www.hackingwithswift.com/books/ios-swiftui/how-to-use-gestures-in-swiftui)中的示例。
             */
                
            Circle()
                .fill(Color.purple)
                .frame(width: 100 * magnifyBy,
                       height: 100 * magnifyBy)
                .gesture(
                    MagnificationGesture(minimumScaleDelta: 0.5)
                        .updating($magnifyBy, body: { (current, state, trans) in
                            state = current
                        })
                        .onChanged {
                            print("MagnificationGesture change value \($0)")
                        }
                        .onEnded {
                            print("MagnificationGesture end value \($0)")
                            //: 报错
                            //self.magnifyBy = $0
                        }
                )
                        
            Rectangle()
                .fill(Color.blue)
                .frame(width: 100 * (magnCurrentValue + magnFinalValue),
                       height: 60 * (magnCurrentValue + magnFinalValue))
                .gesture(
                    MagnificationGesture()
                        .onChanged {
                            self.magnCurrentValue = $0 - 1
                        }
                        .onEnded { _ in
                            self.magnFinalValue += self.magnCurrentValue
                            self.magnCurrentValue = 0
                        }
                )
        }
    }
    
    @State private var rotaAngle: Angle = Angle(degrees: 0.0)
    
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)
    
    var doRotationGesture: some View {
        HExampleView("RotationGesture") {
            
            /*:
             `RotationGesture`是旋转手势，其Value为`Angle`类型，对应的是`minimumAngleDelta`属性，
             表示手势旋转了多少角度，
             */
            
            Text("Helo world~")
                .font(.system(size: 30))
                .bold()
                .padding()
                .rotationEffect(rotaAngle)
                .foregroundColor(Color(red:0.29, green:0.95, blue:0.63))
                .gesture(
                    RotationGesture()
                        .onChanged {
                            print("RotationGesture change value \($0)")
                            self.rotaAngle = $0
                        }
                        .onEnded{
                            print("RotationGesture end value \($0)")
                            self.rotaAngle = $0
                        }
                )
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.orange)
                .frame(width: 120, height: 60)
                .rotationEffect(finalAmount + currentAmount)
                .gesture(
                    RotationGesture()
                        .onChanged { self.currentAmount = $0 }
                        .onEnded{ _ in
                            self.finalAmount += self.currentAmount
                            self.currentAmount = .degrees(0)
                        }
                )
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
