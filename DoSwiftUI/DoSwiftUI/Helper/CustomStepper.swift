//
//  CustomStepper.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/2/5.
//

import SwiftUI

struct CustomStepper<Label>: View where Label: View {
    
    fileprivate var onIncrement: (() -> Void)?
    fileprivate var onEditingChanged: (Bool) -> Void
    fileprivate var onDecrement: (() -> Void)?
    fileprivate var label: Label

    init(
        onIncrement: (() -> Void)?,
        onDecrement: (() -> Void)?,
        onEditingChanged: @escaping (Bool) -> Void = { _ in },
        @ViewBuilder label: () -> Label
    ) {
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
        self.onEditingChanged = onEditingChanged
        self.label = label()
    }
    
    var body: some View{
        
        HStack {
            label
                .lineLimit(1)
            
            Spacer()
            
            HStack{
                
                Text("－")
                    .onTapGesture(perform: decrease)
                    .frame(minWidth: 40, minHeight: 40)
                    .disabled(decreaseDisabled)
                    .background(Color.pink)
                
                Text("＋")
                    .onTapGesture(perform: increase)
                    .frame(minWidth: 40, minHeight: 40)
                    .disabled(increaseDisabled)
                    .background(Color.pink)
                
//                Button("－", action: decrease)
//                    .buttonStyle(
//                        StepperButtonStyle(.decrease, disabled: decreaseDisabled)
//                    )
//                    .disabled(decreaseDisabled)
//                    .frame(minWidth: 40, minHeight: 40)
//
////                Text("\(value.wrappedValue)")
////                    .font(.system(size: 13, design: .rounded))
////                    .foregroundColor(.pink)
////                    .frame(minWidth: 20, maxWidth: 50)
//
//                Button("＋", action: increase)
//                    .buttonStyle(
//                        StepperButtonStyle(.increase, disabled: increaseDisabled)
//                    )
//                    .disabled(increaseDisabled)
//                    .frame(minWidth: 40, minHeight: 40)
            }
        }
    }
    
    fileprivate var decreaseDisabled: Bool = true
    fileprivate var increaseDisabled: Bool = true
//    private var decreaseDisabled: Bool {
//        value.wrappedValue <= bounds.lowerBound
//    }
//
//    private var increaseDisabled: Bool {
//        value.wrappedValue >= bounds.upperBound
//    }
//
    private func decrease() {
        print("decrease")
        self.onDecrement?()
    }

    private func increase() {
        print("increase")
        self.onIncrement?()
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
        }
    }
}

extension CustomStepper {
    
    init<V>(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }, @ViewBuilder label: () -> Label) where V : Strideable {
        
        self.init(
            onIncrement: {
                let result = value.wrappedValue.advanced(by: step)
                value.wrappedValue = max(min(result, bounds.upperBound), bounds.lowerBound)
//                self.increaseDisabled = false
            },
            onDecrement: {
                let result = value.wrappedValue.advanced(by: -step)
                value.wrappedValue = min(max(result, bounds.lowerBound), bounds.upperBound)
//                value.wrappedValue >= bounds.upperBound
            },
            onEditingChanged: onEditingChanged,
            label: label
        )
    }
}

//protocol StepperStyle {
//    
//    associatedtype Body: View
//    
//    typealias Configuration = StepperStyleConfiguration
//    
//    func makeBody(configuration: Self.Configuration) -> Self.Body
//}
//
//struct StepperStyleConfiguration {
//    
//    struct Label: View {
//        // 虽然叫做Label，但是其实是用来包裹Stepper中的View的，比如label、increment、decrement
//        init<Content: View>(content: Content) {
//            body = AnyView(content)
//        }
//        var body: AnyView
//    }
//    
//    let label: StepperStyleConfiguration.Label
//}
//
//struct RoundedRectangleStepperStyle: StepperStyle{
//
//    func makeBody(configuration: Configuration) -> some View {
//
//    }
//    
//}
