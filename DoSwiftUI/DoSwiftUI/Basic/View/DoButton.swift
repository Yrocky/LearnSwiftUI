//
//  DoButton.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/29.
//

import SwiftUI

struct DoButton: View {
    var body: some View {
        ExampleContainerView("Button") {
         
            doBasic
            
            doButtnStyle
            
            doCustomButtonStyle
        }
    }
    
    var doBasic: some View {
        VExampleView("basic") {
            /*:
             在SwiftUI中，`Button`是对按钮的抽象，在这里，按钮被简化为它最原始的内容：展示标签、响应的事件。
             */
        }
    }
    
    var doButtnStyle: some View {
        VExampleView("ButtonStyle") {
        
            DisplayButtonStyle(
                name: "DefaultButtonStyle",
                style: DefaultButtonStyle()
            )
            
            DisplayButtonStyle(
                name: "PlainButtonStyle",
                style: PlainButtonStyle()
            )
            
            DisplayButtonStyle(
                name: "BorderlessButtonStyle",
                style: BorderlessButtonStyle()
            )
        }
    }
    
    var doCustomButtonStyle: some View {
        VExampleView("custom ButtonStyle") {
         
            Button("Login"){}
                .buttonStyle(BorderedButtonStyle(color: .green))
        }
    }
    
    struct DisplayButtonStyle<Style>: View where Style: PrimitiveButtonStyle {
        
        var styleName: String
        var buttonStyle: Style
        
        init(name: String, style: Style) {
            self.styleName = name
            self.buttonStyle = style
        }
        
        var body: some View{
            
            VStack(alignment: .center){
                
                Text("\(styleName)")
                    .font(.system(size: 13))
                    .foregroundColor(Color.gray.opacity(0.6))
                
                Button("Commit") {}
                    .buttonStyle(buttonStyle)
            }
        }
    }
    
    struct BorderedButtonStyle: PrimitiveButtonStyle {
        
        var color: Color = .pink
        
        func makeBody(configuration: Configuration) -> some View {
            configuration
                .label
                .foregroundColor(color)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .padding()
                .border(color, width: 1)
        }
    }
}

struct DoButton_Previews: PreviewProvider {
    static var previews: some View {
        DoButton()
    }
}
