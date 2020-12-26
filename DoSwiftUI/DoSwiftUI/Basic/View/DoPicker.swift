//
//  DoPicker.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/26.
//

import SwiftUI

struct DoPicker: View {
    var body: some View {
        ExampleContainterView("Picker") {
            
//            doBasic
//
//            doPickerWithLabel
//
//            doPickerWithForEach
            
            doPickerStyle
        }
    }
    
    @State var selectGender = Gender.male
    
    var doBasic: some View {
        VExampleView("静态的 Picker") {
            /*:
             通过在ViewBuilder中创建固定个数的View来实现一个静态的`Picker`，
             可以是任意的View，貌似为Picker设置的title没有生效。
             */
            Picker("选择性别", selection: $selectGender) {
                GenderView(.male).tag(Gender.male)
                GenderView(.female).tag(Gender.female)
            }
            
            Text("当前选择的是：\(selectGender.rawValue)")
        }
    }
    
    var doPickerWithLabel: some View {
        VExampleView("结合 Label 使用") {
            
            /*:
             同样的我们可以使用自定义的Label来实现title，但是还不生效。
             */
            Picker(selection: $selectGender,
                        label: Label("Select Your Gender", systemImage: "hand.tap.fill")) {
                GenderView(.male).tag(Gender.male)
                GenderView(.female).tag(Gender.female)
            }
            
            Text("Your choosed was:\(selectGender.rawValue)")
                .font(.system(size: 17))
                .foregroundColor(.blue)
            
            Button {
                selectGender.toggle()
            } label: {
                Text("Toggle")
                    .foregroundColor(.orange)
            }

        }
    }
    
    @State var currentEdge = Edge.top
    
    var doPickerWithForEach: some View {
        VExampleView("结合 ForEach 使用") {
            /*:
             结合ForEach，我们可以创建一个动态的Picker，做法就是在ViewBuilder中使用ForEach创建多个选项。
             
             */
            Picker("Select Edge:", selection: $currentEdge) {
                ForEach(Edge.allCases) { edge in
                    Text(edge.rawValue)
                        .tag(edge)
                }
            }
        }
    }
    
    @State var currentSelected = 1
    
    var doPickerStyle: some View {
        
        VStack{
            
            VExampleView("DefaultPickerStyle") {
                /*:
                 Picker也提供了`PickerStyle`给我们来设置样式，默认的Style是DefaultPickerStyle，
                 在不同的平台上有不同的表现：
                 
                 * On iOS and watchOS the default is a wheel.
                 * On macOS, the default is a pop-up button.
                 * On tvOS, the default is a segmented control.
                 
                 */
                Picker("Select Edge:", selection: $currentEdge) {
                    ForEach(Edge.allCases) { edge in
                        Text(edge.rawValue)
                            .tag(edge)
                    }
                }
                .pickerStyle(DefaultPickerStyle())
            }
            
            VExampleView("InlinePickerStyle") {
                
                /*:
                 InlinePickerStyle是在14.0之后推出的样式，看结果是统一将选项在
                 */
                Picker("Select Edge:", selection: $currentEdge) {
                    ForEach(Edge.allCases) { edge in
                        Text(edge.rawValue)
                            .tag(edge)
                    }
                }
                .pickerStyle(InlinePickerStyle())
            }
            
            VExampleView("MenuPickerStyle") {
                /*:
                 `MenuPickerStyle`是可以通过点击自身的title来使用pop方式展现的样式，
                 同时当可选项比较多（多余5个）的时候，建议使用这个Style，
                 
                 > Use this style when there are more than five options.
                 */
                Picker("Which is your number:", selection: $currentSelected) {
                    ForEach(1..<30) { index in
                        Text("NO.\(index)")
                            .tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                VStack{
                    Picker("", selection: $currentSelected) {
                        ForEach(1..<30) { index in
                            Text("NO.\(index)")
                                .tag(index)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Which is your number:")
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            VExampleView("WheelPickerStyle") {
                
                Picker("Which is your number:", selection: $currentSelected) {
                    ForEach(1..<6) { index in
                        Text("NO.\(index)")
                            .tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            
            VExampleView("SegmentedPickerStyle") {
                
                /*:
                 顾名思义，`SegmentedPickerStyle`其实是UISegmentControl的样式，
                 这样看来，在swiftUI中，UIPickerView和UISegmentControl其实是使用同一个类型实现的。
                 */
                Picker("Which is your number:", selection: $currentSelected) {
                    ForEach(1..<6) { index in
                        Text("NO.\(index)")
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
    struct GenderView: View {
        
        let gender: Gender
        
        init(_ gender: Gender) {
            self.gender = gender
        }
        
        var body: some View {
            HStack{
                
                gender.image()
                
                Text(gender.rawValue)
                    .font(.system(size: 16))
                    .foregroundColor(.orange)
            }
        }
    }
    
    enum Gender: String, CaseIterable, Identifiable {
        case male
        case female
        
        var id: String { self.rawValue }
        
        func image() -> Image {
            
            switch self {
            case .male:
                return Image(systemName: "mustache.fill")
            case .female:
                return Image(systemName: "mouth.fill")
            }
        }
        
        mutating func toggle() {
            switch self {
            case .male:
                self = .female
            case .female:
                self = .male
            }
        }
    }
    
    enum Edge : String, CaseIterable, Identifiable {

        case top
        case leading
        case bottom
        case trailing
        
        var id: String {self.rawValue}
    }
    
}

struct DoPicker_Previews: PreviewProvider {
    static var previews: some View {
        DoPicker()
    }
}
