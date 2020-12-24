//
//  DoForEach.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/21.
//

import SwiftUI

struct DoForEach: View {
    var body: some View {
        
        ExampleContainterView("ForEach"){
            
            doRange
            
            doString
            
            doCustomData
            
            doUseIdentifiable
        }
    }

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
        VExampleView("结合 Range 使用") {
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(1..<10){ index in
                        itemLabel(with: index)
                    }
                }
            }
        }
    }
    
    var doString: some View {
        
        VExampleView("通过 id 来标识元素的唯一性") {
            
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
        
        VExampleView("如果 id 相同，则不会创建数据对应的视图") {
            
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
        
        VExampleView("使用 Identifiable，自定义元素可以省去 id") {
            
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
