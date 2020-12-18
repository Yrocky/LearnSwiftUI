//
//  ContentView.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct ContentView: View {
    
    var list = [
        "DoText","DoImage","DoStepper","DoSlider",
        "DoText","DoImage","DoText","DoImage",
    ]
    
    var body: some View {
        ScrollView{
            ForEach(0..<list.count) { index in
                GroupBox(
                    label: Text(list[index])
                        .font(.system(size: 17))
                        .foregroundColor(.pink)
                ) {
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
