//
//  DoSlider.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoSlider: View {
    
    @State private var value = 0.4
    
    var body: some View {
        
        ExampleContainerView("Slider"){
            
            doSlider
            
            doCustomLabelSlider
            
            doMinAndMaxLabelSlider
            
            doStepSlider
            
            doFullSlider
        }
        
        /*:
         不过Slider并没有Toggle那样自定义样式接口，
         swiftUI中并不存在一个SliderStyle的协议让我们自定义样式。
         */
    }
    
    var doSlider: some View {
        /*:
         `Slider`是swiftUI中用来表示滑竿的控件，功能上等同于UIKit的UISlider，
         和Stepper类似，Slider也具备`当前值`、`范围`两个重要的属性，
         同时也有滑动的事件回调。
         */
        VExampleView("基础用法") {
            
            Text("current value:\(value)")
            
            Slider(value: $value, in: 0...1)
                .padding()
                //: 为Slider设置`foregroundColor`并不会生效
//                .foregroundColor(.orange)
                //: 需要为其设置`accentColor`才可以改变颜色，类似于UIKit中的tintColor
                .accentColor(.orange)
        }
    }
    
    var doCustomLabelSlider: some View {
        /*:
         貌似创建自定义的Label并不会生效
         */
        VExampleView("设置 range、label，但是 label 不生效") {
            
            Slider(value: $value, in: 0...10) {
                //: 不生效
                Text("current: \(value)")
            }
        }
    }
    
    var doMinAndMaxLabelSlider: some View {
        /*:
         我们还可以为滑竿设置最小值的视图，以及最大值的视图，可以是任意的View
         */
        VExampleView("设置 minimum、maximumValueLabel ") {
        
            Slider(
                value: $value,
                minimumValueLabel: Text("0"),
                maximumValueLabel: Text("1")) {
                //: 依然，不生效
                Text("current: \(value)")
            }
        }
    }
    
    var doStepSlider: some View {
        /*:
         Slider也具备设置步长
         */
        VExampleView("设置 step ") {
            
            Slider(
                value: $value,
                in: 0...1,
                step: 0.2) {
                //: 依然，不生效
                Text("Slider value:\(value)")
            }
        }
    }
    
    var doFullSlider: some View {
        
        VExampleView("range、step、minimum、maximumValueLabel、label") {
            
            /*:
             得益于swift 5.0之后提供的FunctionBuilder功能，我们可以在这里写变量。
             
             我们设置一个Image为最大、最小的展示Label
             */
            let minLabel = Image(systemName: "sun.min")
                .resizable()
                .frame(width: 40, height: 40)
            let maxLabel = Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 40, height: 40)
            
            Slider(
                value: $value,
                in: 0...1,
                step: 0.02,
                minimumValueLabel: minLabel,
                maximumValueLabel: maxLabel) {
                //: 依然，不生效
                Text("current: \(value)")
            }
        }
    }
    
}

struct DoSlider_Previews: PreviewProvider {
    static var previews: some View {
        DoSlider()
    }
}
