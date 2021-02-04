//
//  DoSpacer.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoSpacer: View {
    
    var body: some View {
        
        ExampleContainerView("Spacer") {
            
            doBasic
            
            doBasic_2
            
            doDynamicViewSize
            
            doSpacerFrameValue
            
            doSpacerMinLengthValue
        }
    }
    
    var doBasic: some View {
            
        HExampleView("使用 Spacer 撑起剩余空间", height: 80) {
            
            /*:
             我们知道在swiftUI的布局中，默认会将子View居中显示，
             通过使用`Spacer`可以将剩余的空间占满，来将View挤压到对应的位置，
             并且对Spacer设置样式的一些modifer将不会生效。
             因为其作用仅仅是提供一个空间，所以可以通过设置一个具体的尺寸来决定空间的大小。
             */
            Rectangle()
                .fill(Color.orange.opacity(0.2))
                .frame(width: 30)
            
            Spacer()
                .background(Color.red.opacity(0.2))
        }
        .frame(width: 300)
    }
    
    var doBasic_2: some View {
    
        HExampleView("使用 Spacer 撑起剩余空间", height: 80) {
            
            /*:
             如果父View在根据已有子View计算出对应的尺寸之后还有剩余，
             Spacer将会填满该空间，在这个实例中就表现为，
             两个View被分别挤到了左侧和右侧。
             */
            Rectangle()
                .fill(Color.orange.opacity(0.2))
                .frame(width: 30)
            
            Spacer()
                
            Rectangle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 100)
        }
        .frame(width: 300)
    }
    
    @State private var addSpacer = true
    
    var doDynamicViewSize: some View {
    
        HExampleView("动态的添加 Spacer ", height: 80) {
    
            /*:
             以上是在子View固定尺寸之后有剩余空间，Spacer的表现，
             如果在子View们的尺寸已经撑满父View，使用Spacer会如何显示呢？
             
             我们会发现，即使已经没有了剩余空间，
             使用了Spacer之后，还是留出来了一些空间。
             
             why?
             
             */
            Text("Hello, World!")
                .foregroundColor(.orange)
                .border(Color.orange.opacity(0.2))
            
            Group{
                if addSpacer {
                    Spacer()
                }
            }
            
            Text("qwertyuiopasdfghjklzxcvbnm1234567890")
                .foregroundColor(.blue)
                .border(Color.blue.opacity(0.2))
            
        }
        .frame(width: 300)
        .onTapGesture {
            withAnimation {
                self.addSpacer.toggle()
            }
        }
    }
    
    var doSpacerFrameValue: some View {
        
        VExampleView("使用 Spacer 做间隔，但还是成组居中", height: 80) {
            
            ZStack {
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 200)
                    .border(Color.green)
                    .zIndex(100)
                
                HStack {
                    
                    /*:
                     首先我们使用`frame`来设置具体的尺寸，设置之后该区域就不会被安排放置View，
                     新增加的View将会在区域之后进行放置。
                     */
                    Rectangle()
                        .fill(Color.orange.opacity(0.2))
                        .frame(width: 30)
                    
                    Spacer()
                        .frame(width: 70)
                    
                    Rectangle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 100)
                    
                }
            }
        }
    }
    
    @State private var rightViewWidth: CGFloat = 70
    
    var doSpacerMinLengthValue: some View {
        
        VExampleView("为 Spacer 设置 minLength"){
            
            HStack {
                
                /*:
                 除了使用`frame`设置尺寸，还可以使用其初始化方法，
                 可以通过初始化直接设置一个`minLength`来决定最小值。
                 顾名思义，设置了最小值之后，就决定了Spacer最少要展示的空间。
                 如果父View有多余该最小值的空间，那么Spacer的尺寸将会被拉伸到对应的值。
                 */
                Rectangle()
                    .fill(Color.orange.opacity(0.2))
                    .frame(width: 30)
                
                Spacer(minLength: 70)
                
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: rightViewWidth)
                
            }
            .frame(width: 300, height: 100)
            .border(Color.gray.opacity(0.2))
            
            Slider(value: $rightViewWidth, in: 10...300)
                .accentColor(Color.blue.opacity(0.2))
                .padding()
        }
    }
}

struct DoSpacer_Previews: PreviewProvider {
    static var previews: some View {
        DoSpacer()
    }
}
