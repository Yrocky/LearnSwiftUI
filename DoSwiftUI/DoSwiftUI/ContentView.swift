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
        
        List() {
            DoText()
            DoImage()
            DoLabel()
            DoStepper()
            DoSlider()
            DoToggle()
            DoProgressView()
            DoTextField()
            DoScrollView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
