//
//  RecordInputTextView.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/9.
//

import SwiftUI

struct RecordInputTextView: View {
    
    private var title: String
    private var placehold: String
    private var text: Binding<String>
    
    @State private var inEdit: Bool = false
    
    init(_ title:String, placehold: String, text: Binding<String>) {
        self.title = title
        self.placehold = placehold
        self.text = text
    }
    
    var body: some View{
        GeometryReader{ proxy in
            
            HStack{
                
                Text(self.title)
                
                TextField(
                    placehold,
                    text:text,
                    onEditingChanged:{ self.inEdit = $0 },
                    onCommit:{ self.inEdit = false }
                )
                .frame(height: proxy.size.height)
                
                Button(
                    action: onClear,
                    label: {
                        Image(systemName: "clear.fill")
                            .accentColor(Color.gray.opacity(0.3))
                    })
                    .frame(
                        width:proxy.size.height,
                        height:proxy.size.height
                    )
                    .isVisible(
                        inEdit && self.text.wrappedValue.count > 0
                    )
            }
        }
    }
    
    private func onClear() {
        self.text.wrappedValue = ""
    }
}
