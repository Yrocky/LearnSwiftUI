//
//  Checkbox.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/13.
//

import SwiftUI

struct Checkbox: View {
    
    @Binding var selected : Bool
    var tintColor: Color
    var text: String
    
    var body: some View {
        
        Button(action: {
            self.selected.toggle()
        }) {
            HStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(overlay)
                    .frame(width:30, height: 30)
                
                Text(text)
                    .foregroundColor(displayColor)
                    .padding(.trailing, 5)
            }
        }
    }
    
    var overlay: some View {
        Image(
            systemName: selected ? "checkmark.square.fill" : "square"
        )
        .foregroundColor(displayColor)
    }
    
    private var displayColor: Color {
        selected ? tintColor : .gray
    }
}

struct ExampleCheckboxView: View {
    @State private var a: Bool = false
    var body: some View{
        Checkbox(
            selected: $a,
            tintColor: .orange,
            text: "Checked?"
        )
    }
}

struct ExampleCheckboxGroupView: View {
    @State private var selected: Int = 0
    var body: some View{
        
        CheckboxGroup(data:[
            ExampleCheckboxItem(key: 1, title: "111"),
            ExampleCheckboxItem(key: 2, title: "222"),
            ExampleCheckboxItem(key: 3, title: "333"),
            ExampleCheckboxItem(key: 4, title: "444"),
        ], selected: $selected)
        .padding()
    }
}
struct Checkbox_Previews: PreviewProvider {

    
    static var previews: some View {
        VStack{
            
            ExampleCheckboxView()
            
            ExampleCheckboxGroupView()
        }
    }
}

struct CheckboxGroup<Key>: View where Key: Equatable {
    
    var tintColor: Color = .green
    var data: [ExampleCheckboxItem<Key>]
    @Binding var selected: Key
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(data) { item in
                HStack{
                    
                    Checkbox(selected: Binding<Bool>(get: {
                        item.key == self.selected
                    }, set: { _ in
                        self.selected = item.key
                    }), tintColor: tintColor, text: item.title)
                    
                    Spacer()
                }
            }
        }
    }
}

struct ExampleCheckboxItem<Key>: Identifiable where Key: Equatable{
    
    var key: Key
    var title: String
        
    var id = UUID()
}
