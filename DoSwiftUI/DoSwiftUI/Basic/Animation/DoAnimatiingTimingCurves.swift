//
//  DoAnimatiingTimingCurves.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/21.
//

import SwiftUI
import Combine

struct RecordTimingCurve: GeometryEffect {

    var onChange: (CGFloat) -> () = { _ in }
    
    var animatableData: CGFloat = 0 {
        didSet {
            onChange(animatableData)
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        .init()
    }
}

final class AnimationTrace: ObservableObject {
    
    let objectWillChange = PassthroughSubject<(), Never>()
    // 元组数组
    var data: [(time: CFTimeInterval, value: CGFloat)] = []
    
    var startTime: CFTimeInterval{
        data.first?.time ?? 0
    }
    
    var endTime: CFTimeInterval{
        data.last?.time ?? 0
    }
    
    func record(_ value: CGFloat) {
        data.append((CACurrentMediaTime(), value))
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func reset() {
        data = []
    }
}

struct Trace: Shape {
    
    var values: [(CGFloat, CGFloat)]
    
    func path(in rect: CGRect) -> Path {
        guard let f = values.first, let l = values.last else { return Path() }
        let xOffset = f.0
        let xMultiplier = l.0 - f.0
        return Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            for value in values {
                let point = CGPoint(x: rect.minX + ((value.0 - xOffset) / xMultiplier) * rect.width, y: rect.maxY - CGFloat(value.1) * rect.height)
                path.addLine(to: point)
            }
        }
    }
}

struct DoAnimatiingTimingCurves: View {
    var sdfsd: some View {
        // https://gist.github.com/chriseidhof/f1bfea3b26ed23c26f2b016a2d618ba4
        ExampleContainterView("Timing Curves") {
            
//            doTimingCurves
        }
    }
    
    let animations: [(String, Animation)] = [
        (".default", .default),
        (".linear(duration: 1)", .linear(duration: 1)),
        (".interpolatingSpring(stiffnes: 5, damping: 3)", .interpolatingSpring(stiffness: 5, damping: 3)),
        (".easeInOut(duration: 1)", .easeInOut(duration: 1)),
        (".easeIn(duration: 1)", .easeIn(duration: 1)),
        (".easeOut(duration: 1)", .easeOut(duration: 1)),
        (".interactiveSpring(response: 3, dampingFraction: 2, blendDuration: 1)", .interactiveSpring(response: 3, dampingFraction: 2, blendDuration: 1)),
        (".spring", .spring()),
        (".default.repeatCount(3)", Animation.default.repeatCount(3)),
        (".default.speed(0.5)", Animation.default.speed(0.5)),
        (".default.repeatCount(3,autoreverses: false)", Animation.default.repeatCount(3, autoreverses: false)),
    ]
    
    @ObservedObject var trace = AnimationTrace()
    @State private var animating: Bool = false
    @State private var selectedAnimationIndex: Int = 0
    @State private var slowAnimations: Bool = false
    
    var selectedAnimation: (String, Animation) {
        animations[selectedAnimationIndex]
    }
    var body: some View {
        VExampleView("") {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.pink)
                .frame(width: 50, height: 50)
                .offset(x: animating ? 100 : -100)
                .modifier(RecordTimingCurve(onChange: {
                    self.trace.record($0)
                }, animatableData: animating ? 1 : 0))
            
            VStack {
                
                Trace(values: trace.data.map {
                    (CGFloat($0), $1)
                })
                .stroke(Color.red, style: .init(lineWidth: 2))
                .frame(height: 150)
                .background(Rectangle().stroke(Color.gray, style: .init(lineWidth: 1)))
                
                HStack {
                    Text("0")
                    Spacer()
                    Text("\(trace.endTime - trace.startTime)")
                }
                
                Text("\(selectedAnimation.0)")
                    .font(.system(size: 11))
                    .lineLimit(2)
                
            }.frame(width: 200)
            
            Picker(selection: $selectedAnimationIndex, label: EmptyView(), content: {
                ForEach(0..<animations.count) {
                    Text(animations[$0].0)
                }
            })
            
            Button(action: {
                self.animating = false
                self.trace.reset()
                withAnimation(self.selectedAnimation.1.speed(self.slowAnimations ? 0.2 : 1), {
                    self.animating = true
                })
            }, label: { Text("Animate") })
            
            Toggle(isOn: $slowAnimations, label: { Text("Slow Animations") })
        }
    }
}


struct DoAnimatiingTimingCurves_Previews: PreviewProvider {
    static var previews: some View {
        DoAnimatiingTimingCurves()
    }
}
