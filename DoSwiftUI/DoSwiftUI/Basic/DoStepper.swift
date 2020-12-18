//
//  DoStepper.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoStepper: View {
    
    @State var currentValue = 2
    let specificValues = [10,100,520,999,1314,9999,99999,999999,5201314,9999999]
    @State var index = 0
    
    var body: some View {
        VStack{
            
            doBacisStepper
            
            doLabelStepper
            
            doRangeStepper
            
            doStepAndRnageStepper
            
            doActionStepper
        }
    }
    
    var doBacisStepper: some View {
        
        /*:
         Stepper的初始化可以将描述内容直接使用字符串，内部会转化成Text，
         如果有特殊的定制，可以使用尾函数来自定义样式。
         
         下面的几个例子都是使用尾函数来创建的。
         */
        Stepper(
            "Current value: \(currentValue)",
            value: $currentValue,
            step: 3
        )
    }
    
    var doLabelStepper: some View {
        /*:
         `Stepper`是swiftUI中用于展示分步选择的控件，它有多个初始化方法。
         首先初始化的时候设置当前值、步长，以及要展示的内容，
         这里的Stepper是没有范围限制的，只要在不溢出的范围内都是可以的
         */
        Stepper(value: $currentValue,
                step: 4) {
            Text("Current value: \(currentValue)")
        }
    }
    
    var doRangeStepper: some View {
        
        /*:
         还可以设置一个范围，将Stepper的值固定在范围内，
         达到了最大、最小值的时候，对应的按钮将不可用
         */
        Stepper(value: $currentValue, in: 1...30) {
            Text("Current value: \(currentValue)")
        }
    }
    
    var doStepAndRnageStepper: some View {
        /*:
         还可以同时设定范围和步长
         */
        Stepper(value: $currentValue, in: 1...20, step: 2) {
            print("\($0)")
        } label: {
            Text("Current value: \(currentValue)")
        }
    }
    
    var doActionStepper: some View {
        /*:
         除了上面的线性修改数据，还可以使用`onIncrement`和`onDecrement`
         来自定义数据的变化函数。
         */
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
        .background(Color.orange)
    }
    
}

struct DoStepper_Previews: PreviewProvider {
    static var previews: some View {
        DoStepper()
    }
}
