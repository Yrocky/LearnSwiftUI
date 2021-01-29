//
//  RecordDatePickerView.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/9.
//

import SwiftUI

struct RecordDatePickerView: View {
    
    var text: String
    @Binding var selected: Int
    
    @State private var inEdit: Bool = false
    @Environment(\.recordRowHeight) private var rowHeight: CGFloat
    
    var body: some View{
        VStack{
            HStack {
                Text(text)
                
                Spacer()
                // The 1st of every month
                // The 2nd of every month
                // The 3rd of every month
                // The 4th of every month
                Text("The \(displayText(selected)) of every month")
                    .foregroundColor(Color(red:0.08, green:0.52, blue:0.82))
            }
            .frame(height: rowHeight)
            .onTapGesture {
                self.inEdit.toggle()
            }
            
            Picker("", selection: $selected) {
                ForEach(dateRange, id:\.self) {
                    Text(displayText($0))
                        .tag($0)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .isVisible(inEdit)
        }
    }
    
    private var dateRange: [Int] {
        (1...31).map{ $0 }
    }
    
    private func displayText(_ num: Int) -> String {
        if num == 1 { return "1st" }
        else if num == 2 { return "2nd" }
        else if num == 3 { return "3rd" }
        else { return "\(num)th" }
    }
}
