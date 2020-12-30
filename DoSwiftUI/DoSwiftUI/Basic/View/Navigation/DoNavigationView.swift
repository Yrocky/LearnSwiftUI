//
//  DoNavigationView.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/25.
//

import SwiftUI

struct DoNavigationView: View {
    var body: some View {
        
        ExampleContainterView("NavigationView") {
            
            doBasic
        
            doNavigationViewStyle
        }
    }
    let items = [
        "Chocolate", "Vanilla",
        "Strawberry", "Mint Chip",
        "Pistachio"
    ]
    
    @State private var showNavigationView = false
    
    var doBasic: some View {
        VExampleView("基础用法", height: 100) {
            
            Text("Tap me show NavigationView")
                .onTapGesture {
                    self.showNavigationView.toggle()
                }
                .sheet(isPresented: $showNavigationView) {
                    
                    NavigationView {
                        List(items, id:\.self) {
                            Text($0)
                        }
                    }
                    .navigationTitle("Today's Flavors")
                }
        }
    }
    
    @State private var showNavigationView_2 = false

    var doNavigationViewStyle: some View {
        VExampleView("NavigationViewStyl", height: 100) {
            
            /*:
             `NavigationViewStyle`是swiftUI为导航样式的抽象，
             系统一共为我们提供了三种导航视图样式:
             * StackNavigationViewStyle
             * DefaultNavigationViewStyle
             * DoubleColumnNavigationViewStyle
             
             
             */
            Text("Tap me show NavigationView")
                .onTapGesture {
                    self.showNavigationView_2.toggle()
                }
                .sheet(isPresented: $showNavigationView_2) {
                    
                    NavigationView {
                        List(items, id:\.self) {
                            Text($0)
                        }
                    }
                    .navigationTitle("Today's Flavors")
                    .navigationViewStyle(StackNavigationViewStyle())
                }
        }
    }
}

struct DoNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        DoNavigationView()
    }
}
