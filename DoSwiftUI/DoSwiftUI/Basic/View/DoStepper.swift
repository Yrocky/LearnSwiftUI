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
            
            CustomStepper(onIncrement: {
                self.customValue += 1
            }, onDecrement: {
                self.customValue -= 1
            }) {
                Text("Counter \(customValue)")
            }
        }
    }
}

struct DoStepper_Previews: PreviewProvider {
    static var previews: some View {
        DoStepper()
    }
}
