//
//  DoProgressView.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/24.
//

import SwiftUI

struct DoProgressView: View {
    var body: some View {
        
        ExampleContainerView("ProgressView"){
            
//            doLoading
//
//            doProgress
//
            doDynamicProgress
//
//            doProgressStyle
            
            doCustomProgressStyle
        }
    }
    
    var doLoading: some View {
        /*:
         在swiftUI中，进度条和加载进度合二为一，都使用`ProgressView`来表示，
         不使用任何`value`相关的api创建的就是一个加载中的控件，不过并不允许修改颜色。
         */
        VStack(spacing: 10){
            
            HExampleView("默认加载中样式"){
                
                ProgressView()
                
                ProgressView("Loading...")
            }
            
            HExampleView("自定义文案"){
                
                ProgressView {
                    
                    HStack{
                        Image(systemName: "icloud.and.arrow.up.fill")
                            .foregroundColor(.purple)
                        Text("uploading...")
                    }
                }
            }
            
            HExampleView("尝试修改tintColor，失败"){
                
                ProgressView()
                    .foregroundColor(.orange)
                    .accentColor(.red)
            }
        }
    }
    
    var doProgress: some View {
        
        VStack(spacing: 10){
            /*:
             使用和`value`相关的api创建的就是一个具常规的进度条。
             */
            
            VExampleView("使用默认的样式，并设置tintColor"){
                
                ProgressView(value: 0.25)
                    .accentColor(.red)
            }
            
            VExampleView("设置范围"){
                
                ProgressView(value: 36, total: 100)
            }
            
            VExampleView("设置label") {
                
                ProgressView(value: 0.28, total: 1.0) {
                    Text("Read progress")
                }
            }
            
            VExampleView("设置label&currentValueLabel") {
                
                ProgressView(value: progressValue) {
                    Text("Download progress")
                } currentValueLabel: {
                    Text("Finished \(progressValue * 100) %")
                }
            }
        }
    }
    
    @State private var progressValue = 0.2
    
    var doDynamicProgress: some View {
        
        VExampleView("动态修改ProgressView", height: 80) {
            
            ProgressView(value: progressValue, total: 1){
                Text("滑动Slider，修改当前进度")
            }
            .accentColor(.orange)
            .foregroundColor(.orange)
            
            Slider(
                value: $progressValue.animation(),
                in: 0...1
            )
            .accentColor(.orange)
        }
    }
    
    var doProgressStyle: some View {
        
        VStack{
            
            /*:
             ProgressView可以通过一个遵守`ProgressViewStyle协议`的实例来修改样式，
             swiftUI为我们提供了几种内置的样式:
             * DefaultProgressViewStyle，默认的样式，常规的进度条
             * LinearProgressViewStyle，和Default效果上一样
             * CircularProgressViewStyle，加载中的效果
             
             当然，我们通过自定义类型来实现特定的样式。
             */
            VExampleView("DefaultProgressViewStyle") {
                
                ProgressView(value: 0.4, total: 1)
                    .progressViewStyle(DefaultProgressViewStyle())
            }
            
            VExampleView("LinearProgressViewStyle") {
                
                ProgressView(value: 0.28, total: 1)
                    .progressViewStyle(LinearProgressViewStyle())
            }
            
            VExampleView("CircularProgressViewStyle") {
                
                ProgressView(value: 0.8, total: 1)
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
        }
    }
    
    var doCustomProgressStyle: some View {
        
        VStack{
        
            VExampleView("一个简单的自定义ProgressViewStyle", height: 100) {
            
                ProgressView(value: progressValue, total: 1) {
                    Text("Uploading")
                } currentValueLabel: {
                    Text("current progress")
                }
                .progressViewStyle(MyProgressViewStyle())
            }
            
            VExampleView("另一个自定义的ProgressViewStyle") {
                ProgressView(value: progressValue)
                    .progressViewStyle(MyOtherProgressStyle())
            }
            
            VExampleView("一个复杂点儿的自定义ProgressViewStyle") {
                
                ProgressView(value: progressValue, total: 1)
                    .frame(height: 100)
                    .progressViewStyle(MyGradientProgressViewStyle())
            }
        }
    }
    
    struct MyOtherProgressStyle: ProgressViewStyle {
        
        let cornerRadius: CGFloat = 10
        
        /*:
         将alignmentGuide运用到ProgressViewStyle中，
         
         使用overlay不行，会被切割，不仅会被Rectangle切割，还会被ZStack切割，
         
         ```swift
         Rectangle().overlay(
             Image(systemName: "figure.walk")
                 .foregroundColor(.green),
             alignment: .trailing
         )
         ```
         
         虽然可以单独将cornerRadius在背景Color上设置，但是Rectangle就又没有圆角了，所以还是需要将Image与Rectangle放在同一层。
         使用一个ZStack将Rectangle与Image进行嵌套，但是结果并不是很好，第一ProgressView的尺寸变得不正常，第二Image的中线并没有与Rectangle的右边线对齐。这个时候就需要将Color、Rectangle、Image放在同一层，使用自定义alignmentGuide来完成
         
         */
        func makeBody(configuration: Configuration) -> some View {
    
            GeometryReader{ proxy in
                ZStack(alignment: .leading){
                    Color
                        .progressBackgroundColor
                        .cornerRadius(cornerRadius)
                    Rectangle()
                        .fill(Color.pink)
                        .frame(
                            width: proxy.size.width * CGFloat(configuration.fractionCompleted ?? 0)
                        )
                        .cornerRadius(cornerRadius)
//                    Image(systemName: "figure.walk")
//                        .resizable()
//                        .frame(width: proxy.size.height, height: proxy.size.height)
//                        .foregroundColor(.green)
                }
            }
        }
    }
    
    struct MyProgressViewStyle: ProgressViewStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            
            VStack(alignment: .leading){
                
                /*:
                 无法将configuration中的label和currentValueLabel进行移除。
                 */
                configuration.label
                    .foregroundColor(Color.orange)
                    .font(.system(size: 20))
                
                ProgressView(configuration)
                    .labelsHidden()
                    .accentColor(color(with: configuration))
                
                configuration.currentValueLabel
                    .foregroundColor(Color.green)
                    .font(.system(size: 12))
            }
            .padding()
        }
        
        func color(with configuration: Configuration) -> Color {
            let fraction = configuration.fractionCompleted ?? 0
            return Color.red.opacity(max(0.1, fraction))
        }
    }
    
    struct MyGradientProgressViewStyle: ProgressViewStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            
            ZStack{
    
                Circle()
                    .trim(from: 0.1, to: 0.9)
                    .stroke(Color.progressBackgroundColor, style: strokeStyle())
                    .rotationEffect(Angle(degrees: 90))
                
                Circle()
                    .trim(from: 0.1, to: progress(with: configuration))
                    .stroke(Color.pink, style: strokeStyle())
                    .rotationEffect(Angle(degrees: 90))
                
                Text("\(text(with: configuration))")
                    .foregroundColor(.pink)
            }
        }
        
        func strokeStyle() -> StrokeStyle {
            StrokeStyle(lineWidth: 10, lineCap: .round)
        }
        
        var gradient: AngularGradient {
            AngularGradient(
                gradient: Gradient(colors: [.green, .orange, .red]),
                center: .center,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 45)
            )
        }
        
        func progress(with configuration: Configuration) -> CGFloat {
            let fraction = configuration.fractionCompleted ?? 0
            return CGFloat(0.1 + (0.9 - 0.1) * fraction)
        }
        
        func text(with configuration: Configuration) -> String{
            let fraction = configuration.fractionCompleted ?? 0
            let percentageFormatter = NumberFormatter()
            percentageFormatter.numberStyle = .percent
            return percentageFormatter.string(from: NSNumber(value: fraction)) ?? "0%"
        }
        
        struct ProgressView: View {
            var body: some View{
                Text("")
            }
        }
    }
}

extension Color {
    static var progressBackgroundColor: Color {
        Color(red: 0.83, green: 0.87, blue: 0.89)
    }
}
struct DoProgressView_Previews: PreviewProvider {
    static var previews: some View {
        DoProgressView()
    }
}
