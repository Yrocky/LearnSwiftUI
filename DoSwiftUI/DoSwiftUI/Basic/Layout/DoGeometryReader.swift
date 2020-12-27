//
//  DoGeometryReader.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoGeometryReader: View {
    
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        
        doBasic
        
    }
    
    var doBasic: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Rectangle()
                                .fill(self.colors[index % self.colors.count])
                                .frame(height: 150)
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                        }
                        .frame(width: 150)
                    }
                }
                .padding(.horizontal, (fullView.size.width - 150) / 2)
            }
        }
        .padding()
//        .edgesIgnoringSafeArea(.all)
    }
    
    struct CardView: View {
        
        private var color: Color = .clear
        
        init(color: Color = .clear) {
            self.color = color
        }
        
        var body: some View {
            GeometryReader { geo in
                Rectangle()
                    .fill(self.color)
                    .frame(height: 150)
//                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
            }
            .frame(width: 150)
        }
    }
}

struct DoGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        DoGeometryReader()
    }
}
