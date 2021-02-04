//
//  DoGestureViewModifer.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/29.
//

import SwiftUI

struct DoGestureViewModifer: View {
    var body: some View {
        ExampleContainerView("Gesure ViewModifer") {
            
            doAllowsHitTesting
            
            doDisable
            
            doHighPriorityGesture
            
            doSimultaneousGesture
        }
    }
    
    @State private var circleHitTestingCounter = 0
    @State private var roundedRectangleHitTestingCounter = 0
    
    var doAllowsHitTesting: some View {
        
        HExampleView("allowsHitTesting") {
            
            /*:
             在swiftUI中，我们可以使用`allowsHitTesting`来禁止View响应手势，
             如果设置为false，该View以及其子View都将不响应手势事件。
             */
            VStack {
                
                Text("Circle tapped \(circleHitTestingCounter)")
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        print("orange circle did tapped")
                        self.circleHitTestingCounter += 1
                    }
            }
            
            VStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.green)
                    .frame(width: 100, height: 60)
                    .onTapGesture {
                        print("you can't see this log")
                        self.roundedRectangleHitTestingCounter += 1
                    }
                    .allowsHitTesting(false)
                
                Text("Rectangle tapped \(roundedRectangleHitTestingCounter)")
            }
        }
    }
    
    @State private var viewWasDisable = false
    
    var doDisable: some View {
        VExampleView("disable") {
            
            /*:
             除了`allowsHitTesting`，`disable`也可以用来禁止手势点击。
             与前者不同的是，disable用在一些控件中（Button、Slider等）的时候，会有一个特殊的禁用致灰状态。
             */
            HStack{
                
                Button("Login button") {
                    print("login handle")
                }
                
                Text("User Agreement")
                    .foregroundColor(.purple)
                    .onTapGesture {
                        print("go for user agreement info")
                    }
                
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 30)
                    .onTapGesture {
                        print("you tapped Rectangle")
                    }
            }
            .disabled(viewWasDisable)
            
            Toggle(isOn: $viewWasDisable) {
                Text("you can change disable for Button & Text")
            }
        }
    }
    
    @ObservedObject private var highPriorityTappedCounter = ViewTappedCounter()

    var doHighPriorityGesture: some View {
        VExampleView("highPriorityGesture") {
            
            /*:
             如果我们给子View和父View都添加手势，由于`子View的视图层级比较高`，
             所以我们点击在子View上只会响应子View的手势，而不响应父View的手势。
             不过，我们可以通过`highPriorityGesture`来提升手势的响应优先级，
             比如提高父View的手势响应优先级，那么即使点击子View，也不会响应子View的手势。
             */
            HStack{
                
                Text("sub-View tapped \(highPriorityTappedCounter.subViewCounter)")
                
                Text("sup-View tapped \(highPriorityTappedCounter.supViewCounter)")
            }
            
            HStack{
                
                VStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            self.highPriorityTappedCounter.subViewIncrease()
                            print("sub-View did tapped")
                        }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .background(Color.orange)
                .frame(width: 300, height: 120)
            }
            .background(Color.green)
            .highPriorityGesture(
                TapGesture()
                    .onEnded{
                        self.highPriorityTappedCounter.supViewIncrease()
                        print("sup-View did tapped")
                    }
            )
        }
    }
    
    @ObservedObject private var simultaneousTappedCounter = ViewTappedCounter()
    
    var doSimultaneousGesture: some View {
        VExampleView("simultaneousGesture") {
         
            /*:
             如果希望点击子View的时候，子View和父View同时响应手势，
             我们可以使用`simultaneousGesture`来完成。
             在下面的例子中，我们使用simultaneousGesture为父View提供了一个手势，
             可以发现，在点击子View的时候，两个手势都被响应了，
             而点击父View中除了子View以外的区域的时候，只有父View的手势会被响应，这完美的符合我们预期。
             */
            HStack{
                
                Text("sub-View tapped \(simultaneousTappedCounter.subViewCounter)")
                
                Text("sup-View tapped \(simultaneousTappedCounter.supViewCounter)")
            }
            
            HStack{
                
                VStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            self.simultaneousTappedCounter.subViewIncrease()
                            print("sub-View did tapped")
                        }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .background(Color.orange)
                .frame(width: 300, height: 120)
            }
            .background(Color.green)
            .simultaneousGesture(
                TapGesture()
                    .onEnded{
                        self.simultaneousTappedCounter.supViewIncrease()
                        print("sup-View did tapped")
                    }
            )
        }
    }
}

fileprivate class ViewTappedCounter: ObservableObject {
    
    @Published var subViewCounter = 0
    @Published var supViewCounter = 0
    
    func subViewIncrease() {
        subViewCounter += 1
    }
    
    func supViewIncrease() {
        supViewCounter += 1
    }
}

struct DoGestureViewModifer_Previews: PreviewProvider {
    static var previews: some View {
        DoGestureViewModifer()
    }
}
