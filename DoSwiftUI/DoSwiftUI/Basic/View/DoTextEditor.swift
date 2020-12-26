//
//  DoTextEditor.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/26.
//

import SwiftUI

struct DoTextEditor: View {
    var body: some View {
        
        ExampleContainterView("TextEditor", version: "2.0") {
            
            doBasic
            
            doSetupFixSize
            
            doText
        }
    }
    
    @State var text: String = "Your can put you text in here"
    
    var doBasic: some View {
        VExampleView("基础用法") {
            /*:
             swiftUI在iOS 14.0之后，才推出了类似于UIKit中UITextView的组件，
             这就是`TextEditor`，
             */
            
            TextEditor(text: $text)
                .border(Color.orange.opacity(0.2))
                .foregroundColor(.green)
        }
    }
    
    var doSetupFixSize: some View {
        
        VExampleView("固定范围") {
         
            TextEditor(text: $text)
                .frame(minHeight: 20, maxHeight: 100)
                .border(Color.orange.opacity(0.2))
        }
    }
    var doText: some View {
        
        VExampleView("对文本的处理") {
            
            TextEditor(text: $text)
                .font(.system(.caption2))
                .border(Color.orange.opacity(0.2))
                .lineLimit(2)
                .lineSpacing(10)
                .textCase(.uppercase)
        }
    }
}

struct DoTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        DoTextEditor()
    }
}
