//
//  DoGradient.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/15.
//

import SwiftUI

struct DoGradient: View {
    
    var body: some View {
        
        ExampleContainerView("Gradient"){
            /*:
             swiftUI提供了3种渐变效果：
             * LinearGradient，线性渐变
             * RadialGradient，
             * AngularGradient，
             */
            
            doGradient
            
            doLinear_Radial_AngularGradient
            
            doLinearGradientAsBackground
        }
    }
    
    var doGradient: some View {
        VExampleView("Gradient", height: 280) {
            /*:
             在SwiftUI中，渐变的核心是`Gradient`，它被用来抽象渐变中颜色的变化，可以使用`Color`，也可以私用的`Stop`来自定义颜色。
             
             ```swift
             struct Gradient : Equatable {

                 @frozen public struct Stop : Equatable {

                     public var color: Color
                     public var location: CGFloat
                     public init(color: Color, location: CGFloat)
                 }

                 public var stops: [Gradient.Stop]
                 public init(stops: [Gradient.Stop])
                 public init(colors: [Color])
             }
             ```
             
             通过Color来创建渐变很好理解，毕竟Color是SwiftUI中对颜色的抽象。
             假如我们使用两个颜色做渐变（red、green），那么它们将会平分给定的空间，
             red所占的空间从起始位置开始，由red向`red与green的中间值`渐变，
             green所占的空间从分割线开始，由中间值向green渐变，同理，多个样色渐变的原理一样。
             
             但是，考虑一种渐变，red区域期望从一半开始，由red向中间值渐变，而green区域也从分割线开始到区域的一半处，由中间值渐变到green。
             这个时候就需要用到Stop，Stop在SwiftUI中也是被用来对颜色的抽象，只不过它还可以设置`location`，用来表示
             */
            Text("use Color")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 0){
                
                LinearGradient(
                    gradient: Gradient(colors: [.red, .green]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 30)
                LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: .red, location: colorStopLocation),
                            .init(color: .green, location: 1-colorStopLocation),
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 30)
            }
            
            Text("use Stop")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: .red, location: 0.2),
                        .init(color: .green, location: 0.8),
                    ]
                ),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 30)
            
            LinearGradient(
                gradient: Gradient(
                    stops: [
                        .init(color: .red, location: colorStopLocation),
                        .init(color: .green, location: 1-colorStopLocation),
                    ]
                ),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 30)
            
            Text("\(colorStopLocation)")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Slider(value: $colorStopLocation, in: 0...1)
        }
    }
    
    @State private var colorStopLocation: CGFloat = 0.2
    
    let gradient = Gradient(colors: [.red, .orange, .green])
    
    var doLinear_Radial_AngularGradient: some View {
        
        VStack{
            
            VExampleView("LinearGradient") {
                
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: gradient,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 80)
            }
            
            VExampleView("RadialGradient") {
                /*:
                 `RadialGradient`
                 */
                Rectangle()
                    .fill(
                        RadialGradient(
                            gradient: gradient,
                            center: .center,
                            startRadius: 5,
                            endRadius: 40
                        )
                    )
                    .frame(height: 80)
            }
        }
    }
    
    var doLinearGradientAsBackground: some View {
        VExampleView("将 LinearGradient 用于 background", height: 40) {
            
            Text("Hello")
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.red, .orange]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
    }
    
}

struct DoGradient_Previews: PreviewProvider {
    static var previews: some View {
        DoGradient()
    }
}
