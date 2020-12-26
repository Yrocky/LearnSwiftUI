//
//  DoColor.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/26.
//

import SwiftUI

struct DoColor: View {
    var body: some View {
        
        ExampleContainterView("Color") {
            
            doBuildInColor
            
            doColorOpacity
            
            doColourDisk
            
            doWithUIColor
        }
    }
    
    var doBuildInColor: some View {
        VExampleView("内置的 Color ") {
         
            VStack{
                
                ColorExhibitionView([.secondary, .black, .white, .gray])
                
                ColorExhibitionView([.red, .green, .blue, .orange])
                
                ColorExhibitionView([.yellow, .pink, .purple, .primary])
            }
            .background(Color(red:0.91, green:0.91, blue:0.91))
        }
    }
    
    
    @State var colorOpacity: Double = 0.5
    
    var doColorOpacity: some View {
        
        VExampleView("opacity") {
            
            ColorExhibitionView(
                [Color.red.opacity(colorOpacity),
                 Color.green.opacity(colorOpacity),
                 Color.blue.opacity(colorOpacity),
                 Color.orange.opacity(colorOpacity)
                ]
            )

            Slider(value: $colorOpacity, in: 0...1)
        }
    }
    
    @State var red: Double = 0.4
    @State var green: Double = 0.1
    @State var blue: Double = 0.7
    
    var doColourDisk: some View {
        VExampleView("colour disk") {
     
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: red, green: green, blue: blue))
                .frame(height: 40)
            
            ColorSlider(title: "Red", value: $red)
            
            ColorSlider(title: "Green", value: $green)
            
            ColorSlider(title: "Blue", value: $blue)
        }
    }
    
    var doWithUIColor: some View {
        
        VExampleView("UIColor") {
            
            Rectangle()
                .fill(Color(UIColor.red))
                .frame(width: 100, height: 30)
            
            Color("Red")
                .frame(width: 100, height: 30)
        }
    }
    
    struct ColorExhibitionView: View {
        
        var colors: [Color] = []
        
        init(_ colors: [Color] = []) {
            self.colors = colors
        }
        
        var body: some View {
            HStack(alignment: .top) {
                ForEach(colors) { color in
                    ColorView(color)
                }
            }
        }
    }
    
    struct ColorView: View {
        
        let color: Color
        
        init(_ color: Color = .clear) {
            self.color = color
        }
        
        var body: some View {
            
            VStack{
                
                RoundedRectangle(cornerRadius: 6)
                    .fill(color)
                    .frame(width: 40, height: 40)
                
                Text(color.id)
                    .font(.system(size: 14))
                    .foregroundColor(color)
                    .frame(width: 80)
            }
        }
    }
    
    struct ColorSlider: View {
        
        let title: String
        @Binding var value: Double
        
        var body: some View{
            HStack{
                
                Text(title)
                    .font(.system(size: 16))
                    .frame(width: 50, alignment: .leading)
                
                Slider(value: $value, in: 0...1, step: 0.01)
                
                Text("\(value)")
                    .font(.system(size: 13))
                    .frame(width: 40)
            }
        }
    }
}

extension Color: Identifiable {
    public var id: String {
        "\(self.description)"
    }
}

struct DoColor_Previews: PreviewProvider {
    static var previews: some View {
        DoColor()
    }
}
