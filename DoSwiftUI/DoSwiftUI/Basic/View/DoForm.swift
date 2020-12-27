//
//  DoForm.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoForm: View {
    var body: some View {
        ExampleContainterView("Form") {
         
            doBasic
            
            doSection
            
            doSomeView
        }
    }
    
    var doBasic: some View {
        VExampleView("基础用法", height: 200) {
            /*:
             `Form`是swiftUI为我们提供的一个特殊的View，类比于web前端的表单控件，
             我们可以使用ForEach来组装一个动态的表单，也可以直接放置View来实现静态的表单。
             */
            Form {
                ForEach(0..<10) {
                    
                    Text("name \($0)")
                }
            }
        }
    }
    
    var doSection: some View {
        VExampleView("Section", height: 200) {
            /*:
             与List组件一样，除了使用ForEach，我们还可以结合着Section来创建Form。
             */
            
            Form {
                Section(
                    header: Text("header"),
                    footer: Text("footer")
                ) {
                    ForEach(0..<5) {
                        Text("NO.\($0)")
                    }
                }
            }
        }
    }
    
    @State var textFieldValue = ""
    @State var stepperValue = 1
    @State var sliderValue = 0.4
    @State var toggleValue = true
    @State var pickerValue = 2
    
    var doSomeView: some View {
        VExampleView("some controls", height: 200) {
            /*:
             其实是List的一种特殊形式，
             在Form中我们可以使用之前用到的Toggle、Slider、Stepper、TextField这些来完成信息的输入。
             */
            Form {
                
                HStack{
                    Image(systemName: "lock.doc.fill")
                        .foregroundColor(.orange)
                    
                    TextField("email", text: $textFieldValue)
                }
                
                Stepper(value: $stepperValue) {
                    Text("Count:\(stepperValue)")
                }
                
                Slider(value: $sliderValue) {
                    Text("Progress:\(sliderValue)")
                }
                
                Toggle(isOn: $toggleValue) {
                    Text("Dark mode")
                }
                
                Picker("Choose one", selection: $pickerValue) {
                    ForEach(0..<10) {
                        Text("NO.\($0)")
                    }
                }
            }
        }
    }
}

struct DoForm_Previews: PreviewProvider {
    static var previews: some View {
        DoForm()
    }
}
