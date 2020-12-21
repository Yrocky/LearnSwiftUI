//
//  DoForEach.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/21.
//

import SwiftUI

struct DoForEach: View {
    var body: some View {
        
        VStack{
            
            doRange
            
            doString
            
            doCustomData
            
            doUseIdentifiable
        }
    }
    
    /*
     public struct ForEach<Data, ID, Content> where Data : RandomAccessCollection, ID : Hashable {

         /// The collection of underlying identified data that SwiftUI uses to create
         /// views dynamically.
         public var data: Data

         /// A function you can use to create content on demand using the underlying
         /// data.
         public var content: (Data.Element) -> Content
     }

     @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
     extension ForEach : DynamicViewContent where Content : View {
     }

     @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
     extension ForEach : View where Content : View {

         /// The type of view representing the body of this view.
         ///
         /// When you create a custom view, Swift infers this type from your
         /// implementation of the required `body` property.
         public typealias Body = Never
     }

     @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
     extension ForEach where ID == Data.Element.ID, Content : View, Data.Element : Identifiable {

         /// Creates an instance that uniquely identifies and creates views across
         /// updates based on the identity of the underlying data.
         ///
         /// It's important that the `id` of a data element doesn't change unless you
         /// replace the data element with a new data element that has a new
         /// identity. If the `id` of a data element changes, the content view
         /// generated from that data element loses any current state and animations.
         ///
         /// - Parameters:
         ///   - data: The identified data that the ``ForEach`` instance uses to
         ///     create views dynamically.
         ///   - content: The view builder that creates views dynamically.
         public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content)
     }

     @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
     extension ForEach where Content : View {

         /// Creates an instance that uniquely identifies and creates views across
         /// updates based on the provided key path to the underlying data's
         /// identifier.
         ///
         /// It's important that the `id` of a data element doesn't change, unless
         /// SwiftUI considers the data element to have been replaced with a new data
         /// element that has a new identity. If the `id` of a data element changes,
         /// then the content view generated from that data element will lose any
         /// current state and animations.
         ///
         /// - Parameters:
         ///   - data: The data that the `ForEach` instance uses to create views
         ///     dynamically.
         ///   - id: The key path to the provided data's identifier.
         ///   - content: The view builder that creates views dynamically.
         public init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (Data.Element) -> Content)
     }

     @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
     extension ForEach where Data == Range<Int>, ID == Int, Content : View {

         /// Creates an instance that computes views on demand over a given constant
         /// range.
         ///
         /// The instance only reads the initial value of the provided `data` and
         /// doesn't need to identify views across updates. To compute views on
         /// demand over a dynamic range, use ``ForEach/init(_:id:content:)``.
         ///
         /// - Parameters:
         ///   - data: A constant range.
         ///   - content: The view builder that creates views dynamically.
         public init(_ data: Range<Int>, @ViewBuilder content: @escaping (Int) -> Content)
     }
     */
    var doRange: some View {
        /*:
         通过`ForEach`，我们可以很便捷的创建多个类型相同的View，
         看起来他和swift中的`forEach()`函数差不多，但是在swiftUI中
         ，ForEach的限制比较多。
         
         通过头文件我们看到ForEach有三个泛型约束：`Data`、`ID`、`Content`。
         其中Content是用来最终展示的内容，为View类型，
         而另外两者指定为`Data : RandomAccessCollection`和`ID : Hashable`，
         
         RandomAccessCollection说明Data是具备随机访问的集合
         https://www.swiftbysundell.com/tips/generic-algorithms/
         
         头文件中的分类中有三个初始化方法，首先是通过Range来初始化
         
         ```swift
         let a = 1..<10// Range(1..<10)
         let b = 1...10// ClosedRange(1...10)
         ```
         */
        ScrollView(.horizontal){
            HStack{
                ForEach(1..<10){ index in
                    itemLabel(with: index)
                }
            }
        }
    }
    
    var doString: some View {
        ScrollView(.horizontal){
            HStack{
                /*:
                 这里我们使用一个字符串数组来进行循环，但是我们需要指明`id`参数为`\.self`，
                 他的意思是使用数组中元素本身作为唯一标识符，这样会方便swiftUI对视图进行增删。
                 */
                ForEach(["H","e","l","l","o",",","W","o","r","l","d"], id:\.self){
                    Text($0)
                        .foregroundColor(.blue)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                }
            }
        }
    }
    
    struct Person {
        var id: Int
        var name: String
    }
    
    let persons = [
        Person(id:10, name: "Aaaa"),
        Person(id:10, name: "BBB"),
        Person(id:10, name: "C"),
    ]
    
    var doCustomData: some View {
        
        ScrollView(.horizontal){
            HStack{
                /*:
                 如果是我们自定义的类型，
                 比如这里的Person，我们使用它的id作为唯一标识，
                 但是数组中的id都是相同的，最终的界面中将不会显示后面两个，
                 只有3个第一个数据下的视图。
                 
                 这就说明swiftUI会使用这个唯一标识进行视图的添加，
                 又由于数组中三个元素的id都相同，swiftUI认为后面两个数据和第一个是一样的，
                 结果导致只会使用第一个数据来创建View。
                 */
                ForEach(persons, id:\.self.id) { person in
                    itemLabel(with: 10, person.name)
                }
            }
        }
    }
    
    struct Car: Identifiable {
        
        var id = UUID()//: Identifiable 协议中必须实现的属性
        var price: Int
    }
    
    let cars = [
        Car(price: 100),
        Car(price: 120),
        Car(price: 190),
        Car(price: 300)
    ]
    
    var doUseIdentifiable: some View {
        ScrollView(.horizontal){
            HStack{
                /*:
                 最后一个初始化方法中，限制了Data.Element必须遵守`Identifiable`协议，
                 这样就不需要显示的指明唯一标识`id`了，因为Identifiable协议中必须拥有一个`id属性`，
                 这样正好符合ForEach该分类的限制条件。
                 */
                ForEach(cars){ car in
                    itemLabel(with: 1, "This car sale $\(car.price)")
                }
            }
        }
    }
    
    /*:
     以上就是ForEach的三种初始化方法，针对不同的数据可以使用对应的方法，
     但是三个方法中都不能很方便的获取到遍历的索引。
     另外，针对于数组中元素类型为字符串、整型这些基础类型来说，总要使用`id`来显式的指明唯一标识。
     
     */
    
    func itemLabel(with index: Int, _ title: String = "World") -> some View {
        Label(
            title: { Text(title) },
            icon: { Image(systemName: "\(index).circle").foregroundColor(.orange) })
            .padding()
            .border(Color.gray)
    }
    
}

struct DoForEach_Previews: PreviewProvider {
    static var previews: some View {
        DoForEach()
    }
}
