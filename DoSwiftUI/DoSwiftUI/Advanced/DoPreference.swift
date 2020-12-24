//
//  DoPreference.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/17.
//

import SwiftUI

struct DoPreference: View {
    
    @State var activeIndex = 0
    @State var rects = [CGRect.zero]
        
    var body: some View {
        
        ExampleContainterView("Preference") {
            
            doMonthView
        }
        
    }
    
    var doMonthView: some View {
        
        VExampleView() {
            
            ZStack(alignment: .topLeading){
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.orange)
                    .border(Color.green, width: 2)
                    .frame(width: rects[activeIndex].size.width, height: rects[activeIndex].size.height)
                    .offset(x: rects[activeIndex].minX, y: rects[activeIndex].minY)
                    .animation(.easeInOut(duration: 0.25))
                
                VStack(alignment: .center){
                    MonthView(activeIndex: $activeIndex, month: "a", index: 0)
                    MonthView(activeIndex: $activeIndex, month: "aaaaaa", index: 1)
                    MonthView(activeIndex: $activeIndex, month: "aaa", index: 2)
                    MonthView(activeIndex: $activeIndex, month: "aaaaaaaaaa", index: 3)
                    MonthView(activeIndex: $activeIndex, month: "aaaaaa", index: 4)
                }
                .onPreferenceChange(MonthView.Key.self){ value in
                    self.rects.removeAll()
                    self.rects.append(contentsOf: value.map{$0.rect})
                }
            }
            .coordinateSpace(name: "container")
        }
    }
}

struct MonthView: View {
    
    @Binding var activeIndex: Int
    let month: String
    let index: Int
    
    var body: some View {
        Text(month)
            .padding()
            .font(.system(size: 20))
            .foregroundColor(.blue)
            .background(BackgroundView())
            .onTapGesture { self.activeIndex = self.index }
    }

    struct BackgroundView: View {
        
        var body: some View{
            GeometryReader{ proxy in
                Rectangle()
                    .fill(Color.clear)
                    .preference(
                        key: Key.self,
                        value: [Data(rect: proxy.frame(in: .named("container")))])
            }
        }
    }
    
    struct Data: Equatable {
        let rect: CGRect
    }
    
    struct Key: PreferenceKey {
        
        typealias Value = [Data]
        
        static var defaultValue: Value = []
        
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value.append(contentsOf: nextValue())
        }
    }
}

struct DoPreference_Previews: PreviewProvider {
    static var previews: some View {
        DoPreference()
    }
}
