//
//  DoStepper.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoStepper: View {
    
    var body: some View {
        
        ExampleContainerView("Stepper"){
            
//            doBacisStepper
//
//            doLabelStepper
//
//            doRangeStepper
//
//            doStepAndRnageStepper
//
//            doActionStepper
            
            doCustomStepper
        }
    }
    
    @State private var currentValue = 2

    var doBacisStepper: some View {
        
        /*:
         Stepper的初始化可以将描述内容直接使用字符串，内部会转化成Text，
         如果有特殊的定制，可以使用尾函数来自定义样式。
         
         下面的几个例子都是使用尾函数来创建的。
         */
        VExampleView("基础用法") {
            
            Stepper(
                "Current value: \(currentValue)",
                value: $currentValue,
                step: 3
            )
        }
    }
    
    var doLabelStepper: some View {
        /*:
         `Stepper`是swiftUI中用于展示分步选择的控件，它有多个初始化方法。
         首先初始化的时候设置当前值、步长，以及要展示的内容，
         这里的Stepper是没有范围限制的，只要在不溢出的范围内都是可以的
         */
        VExampleView("使用自定义的 View 作为 label") {
            
            Stepper(value: $currentValue,
                    step: 4) {
                HStack{
                    Image(systemName: "sleep")
                        .foregroundColor(.orange)
                    
                    Text("Current value: \(currentValue)")
                }
            }
        }
    }
    
    var doRangeStepper: some View {
        
        /*:
         还可以设置一个范围，将Stepper的值固定在范围内，
         达到了最大、最小值的时候，对应的按钮将不可用
         */
        VExampleView("使用 range 限制范围") {
            
            Stepper(value: $currentValue, in: 1...30) {
                Text("Current value: \(currentValue)")
            }
        }
    }
    
    var doStepAndRnageStepper: some View {
        /*:
         还可以同时设定范围和步长
         */
        VExampleView("设置 range、step、action、label") {
            
            Stepper(value: $currentValue, in: 1...20, step: 2) {
                print("\($0)")
            } label: {
                
                HStack{
                    Image(systemName: "light.min")
                    
                    Text("Current value: \(currentValue)")
                }
            }
        }
    }
    
    private let specificValues = [10,100,520,999,1314,9999,99999,999999,5201314,9999999]
    @State private var index = 0
    
    var doActionStepper: some View {
        /*:
         除了上面的线性修改数据，还可以使用`onIncrement`和`onDecrement`
         来自定义数据的变化函数。
         */
        VExampleView("自定义 onIncrement、onDecrement 规则") {
            
            Stepper(
                onIncrement: {
                    index += 1
                    if (index >= specificValues.count) {
                        index = 0
                    }
                },
                onDecrement: {
                    index -= 1
                    if (index < 0) {
                        index = specificValues.count - 1
                    }
                }) {
                Text("Current value: \(specificValues[index])")
            }
            .accentColor(Color.orange)
        }
    }
    
    @State private var customValue: Int = 1
    
    var doCustomStepper: some View {
        VExampleView("Custom Stepper") {
            /*:
             SwiftUI并没有为我们提供Stepper的Style，如果有特殊需求的Stepper，就需要自定义了。
             */
            
            CustomStepper(value: $customValue, in: 0...10) {
                Text("counter \(customValue)")
            }
        }
    }
}

struct CustomStepper<Label, V>: View where Label: View , V: Strideable {
    
    /*:
     首先，一个Stepper需要具有value、step、range
     */
    private var value: Binding<V>
    private var bounds: ClosedRange<V>
    private var step: V.Stride
    private var label: Label
    
//    fileprivate var onIncrement: (() -> Void)?
//    fileprivate var onDecrement: (() -> Void)?
//
//    public init(
//        onIncrement: (() -> Void)?,
//        onDecrement: (() -> Void)?,
//        onEditingChanged: @escaping (Bool) -> Void = { _ in },
//        @ViewBuilder label: () -> Label
//    ) {
//        self.onIncrement = onIncrement
//        self.onDecrement = onDecrement
//        self.label = label()
//    }

    init(
        value: Binding<V>,
        in bounds: ClosedRange<V>,
        step: V.Stride = 1,
        @ViewBuilder label: () -> Label
    ) {
        self.value = value
        self.bounds = bounds
        self.step = step
        self.label = label()
    }
    
    var body: some View{
        
        HStack {
            label
                .lineLimit(1)
            
            Spacer()
            
            HStack{
                
                Button("－", action: decrease)
                    .buttonStyle(
                        StepperButtonStyle(.decrease, disabled: decreaseDisabled)
                    )
                    .disabled(decreaseDisabled)
                    .frame(minWidth: 40, minHeight: 40)
                
//                Text("\(value.wrappedValue)")
//                    .font(.system(size: 13, design: .rounded))
//                    .foregroundColor(.pink)
//                    .frame(minWidth: 20, maxWidth: 50)
                
                Button("＋", action: increase)
                    .buttonStyle(
                        StepperButtonStyle(.increase, disabled: increaseDisabled)
                    )
                    .disabled(increaseDisabled)
                    .frame(minWidth: 40, minHeight: 40)
            }
        }
    }
    
    private var decreaseDisabled: Bool {
        value.wrappedValue <= bounds.lowerBound
    }
    
    private var increaseDisabled: Bool {
        value.wrappedValue >= bounds.upperBound
    }
    
    private func decrease() {
        print("decrease")
        let result = value.wrappedValue.advanced(by: -step)
        value.wrappedValue = max(result, bounds.lowerBound)
    }
    
    private func increase() {
        print("increase")
        let result = value.wrappedValue.advanced(by: step)
        value.wrappedValue = min(result, bounds.upperBound)
    }
    
    enum `Type` {
        case decrease
        case increase
    }
    
    struct StepperButtonStyle: ButtonStyle {
        
        private var type: Type
        private var disabled: Bool
        
        init(_ type: Type, disabled: Bool = true) {
            self.type = type
            self.disabled = disabled
        }
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration
                .label
                .frame(width: 30, height: 30, alignment: .center)
                .font(.system(size: 22, design: .rounded))
                .foregroundColor(Color.white)
                .background(background(configuration.isPressed))
        }
        
        func background(_ isPressed: Bool) -> some View {
            
            let fillColor = isPressed || disabled ?
                Color(red: 0.83, green: 0.40, blue: 0.42) :
                Color.pink
            
            return RoundedRectangle(cornerRadius: 4)
                .fill(fillColor)
        }
        private var background: some View {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.pink)
//            if type == .decrease { // -
//
//            } else { // +
//
//            }
        }
    }
}

struct DoStepper_Previews: PreviewProvider {
    static var previews: some View {
        DoStepper()
    }
}
