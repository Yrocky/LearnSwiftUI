//
//  DoCoordinateSpace.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/17.
//

import SwiftUI

struct DoCoordinateSpace: View {
    var body: some View {
        
        ExampleContainterView("CoordinateSpace"){
            
            doCustomSize
            
            doGlobalCoordinateSpace
            
            doCustomCoordinateSpace
        }
    }
    
    var doCustomSize: some View {
        /*:
         swiftUI会给我们的子View一个合适的范围来显示，
         一般来说我们不需要对要展示的View进行位置的修改。
         比如，下面的VStack中有Text和Rectangle两个子View，
         由于Text会使用内部的文本撑起一个size，
         所以在VStack中其余的空间就是Rectangle的最终显示尺寸。
         
         如果我们不想使用这个尺寸或者根据swiftUI建议的尺寸做一个修改，
         我们就需要用到`GeometryReader`，
         在他的初始化的回调中可以通过`GeometryProxy`来获取父View给的建议尺寸。
         */
        VExampleView("子 View 不使用父 View 建议的尺寸", height: 100) {

            VStack(alignment: .leading, spacing: 0){
                
                Text("Hello world~")
                    .padding()
                    .background(Color.red)
                
                MyRectangle()
            }
        }
    }
    
    var doGlobalCoordinateSpace: some View {
        
        VExampleView("global") {
            /*:
             通过CoordinateSpace，我们拿到
             */
            
            Rectangle()
                .fill(Color.blue)
                //: 通过这个modifer，可以设置一个坐标系统，
                .coordinateSpace(name: CoordinateSpace.global)
        }
    }
    
    var doCustomCoordinateSpace: some View {
        
        VExampleView("Custom CoordinateSpace", height: 100) {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Fetch super view rect with coordinateSpace")
                    .padding(4)
                    .font(.system(size: 17))
                    .background(Color.orange)
                HStack(alignment: .center, spacing: 10){
                    MyKernelView()
                    MyKernelView()
                }
                .coordinateSpace(name: MyKernelView.SuperView.two)
            }
            .coordinateSpace(name: MyKernelView.SuperView.one)
        }
    }
    
    struct MyRectangle: View {
        var body: some View{
            GeometryReader{ proxy in
                Rectangle()
                    .fill(Color.blue)
                    .offset(x: 20, y: 10.0)
                    .frame(width: proxy.size.width * 0.8, height: proxy.size.height * 0.5)
            }
        }
    }
    
    /*:
     在`GeometryReader`的初始化回调中，我们可以做任何关于布局的自定义操作，
     但是如果我们要获取到`父View`甚至`祖父View`的尺寸，要如何做呢？
     
     我们可以使用`coordinateSpace`，通过这个modifer，
     我们可以为指定的View设定在view-tree中的坐标标识，
     这样在子View中就可以根据这个拿到上层View的尺寸。
     */
    
    /// Assigns a name to the view's coordinate space, so other code can operate
    /// on dimensions like points and sizes relative to the named space.
    ///
    /// Use `coordinateSpace(name:)` to allow another function to find and
    /// operate on a view and operate on dimensions relative to that view.
    ///
    /// The example below demonstrates how a nested view can find and operate on
    /// its enclosing view's coordinate space:
    ///
    ///     struct ContentView: View {
    ///         @State private var location = CGPoint.zero
    ///
    ///         var body: some View {
    ///             VStack {
    ///                 Color.red.frame(width: 100, height: 100)
    ///                     .overlay(circle)
    ///                 Text("Location: \(Int(location.x)), \(Int(location.y))")
    ///             }
    ///             .coordinateSpace(name: "stack")
    ///         }
    ///
    ///         var circle: some View {
    ///             Circle()
    ///                 .frame(width: 25, height: 25)
    ///                 .gesture(drag)
    ///                 .padding(5)
    ///         }
    ///
    ///         var drag: some Gesture {
    ///             DragGesture(coordinateSpace: .named("stack"))
    ///                 .onChanged { info in location = info.location }
    ///         }
    ///     }
    ///
    /// Here, the ``VStack`` in the `ContentView` named “stack” is composed of a
    /// red frame with a custom ``Circle`` view ``View/overlay(_:alignment:)``
    /// at its center.
    ///
    /// The `circle` view has an attached ``DragGesture`` that targets the
    /// enclosing VStack's coordinate space. As the gesture recognizer's closure
    /// registers events inside `circle` it stores them in the shared `location`
    /// state variable and the ``VStack`` displays the coordinates in a ``Text``
    /// view.
    ///
    /// ![A screenshot showing an example of finding a named view and tracking
    /// relative locations in that view.](SwiftUI-View-coordinateSpace.png)
    ///
    /// - Parameter name: A name used to identify this coordinate space.
    
    struct MyKernelView: View {
        
        enum SuperView: String {
            case one = "super-view"
            case two = "super-super-view"
        }
        
        var body: some View{
            GeometryReader{ proxy in
                
                let rect = proxy.frame(in: .named(SuperView.two))
                let width = rect.size.width
                let height = rect.size.height
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: width, height: height)
            }
        }
    }
}

struct DoCoordinateSpace_Previews: PreviewProvider {
    static var previews: some View {
        DoCoordinateSpace()
    }
}
