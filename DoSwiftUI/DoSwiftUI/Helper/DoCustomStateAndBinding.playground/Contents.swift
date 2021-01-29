import UIKit

var str = "Hello, playground"

@propertyWrapper
struct Binding<Value> {
    
    private var getter: () -> Value
    private var setter: (Value) -> Void
    
    var wrappedValue: Value{
        get { self.getter() }
        nonmutating set { self.setter(newValue) }
    }
    
    init(get: @escaping () -> Value, set: @escaping (Value) -> Void) {
        self.getter = get
        self.setter = set
    }
    
    var projectedValue: Binding<Value> { self }
    
    var otherBinding: Binding<Value> {
        Binding<Value>(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0 }
        )
    }
}

private var a: Int = 10

struct Example1 {
    @Binding(get: { a }, set: { a = $0})
    var aa: Int
    
    func run() {
        print("before a:\(a) aa:\(aa)")// before a:10 aa:10
        aa = 11
        print("after a:\(a) aa:\(aa)")// after a:11 aa:11
    }
}

let example1 = Example1()
example1.run()
print(example1.$aa)

//: 为Binding添加

@dynamicMemberLookup
protocol BindingConvertible{
    
    associatedtype Value
    
    var binding: Binding<Value> { get }
    
    subscript<Subject>(dynamicMember keypath: WritableKeyPath<Value, Subject>) -> Binding<Subject> { get }
}

extension BindingConvertible {
    public subscript<Subject>(dynamicMember keypath: WritableKeyPath<Value, Subject>) -> Binding<Subject> {
        return Binding<Subject>(
            get: { self.binding.wrappedValue[keyPath: keypath] },
            set: { self.binding.wrappedValue[keyPath: keypath] = $0 }
        )
    }
}

extension Binding: BindingConvertible {
    var binding: Binding<Value> { self }
}

struct Car: CustomStringConvertible {
    
    var color: String
    var money: Int

    var description: String {
        "\(color)-\(money)"
    }
}

struct Person {
    var name: String
    var car: Car
}

private var person = Person(name: "rocky", car: Car(color: "red", money: 100))

struct Example2 {
    
    @Binding(get: { person }, set: { person = $0 })
    var person2: Person
    
    var person3: Person = person
    
    func run() {
        // rocky
        print("\(person2.name)")
        /*:

         _person2其实是Binding类型，这是由于我们的Binding被`@propertyWrapper`所标记，编译器默认为我们创建了一个_person2的变量，其类型为Binding

         // Binding<Person>(getter: (Function), setter: (Function))
         */
        print("\(_person2)")
        /*:
         
         在Binding中wrappedValue这个计算属性返回的是被wrap的数据，也就是Person
         
         // Person(name: "rocky", car: red-100)
         */
        print("\(_person2.wrappedValue)")
        //: rocky
        print("\(_person2.wrappedValue.name)")
        //: Binding<Person>(getter: (Function), setter: (Function))
        print("\($person2)")
        /*:
         
         由于我们为Binding标记了`@dynamicMemberLookup`，所以可以动态的获取其wrap类型的属性
         
         // Binding<String>(getter: (Function), setter: (Function))
         */
        print("\($person2.name)")
        /*:
         
         所以我们这样可以获取到person2的name
         
         // rocky
         */
        print("\($person2.name.wrappedValue)")
    }
    
    func runModifCarMoney() {
        print("before person:\(person) person2:\(person2)")
        person2.car.money = 200
        print("after person:\(person) person2:\(person2)")
    }
    
    func runModifPersonName() {
        print("before person:\(person) person2:\(person2)")
        person2.name = "Y_rocky"
        print("after person:\(person) person2:\(person2)")
    }
    
    func runModifCar() {
        print("before person:\(person) person2:\(person2)")
        person2.car = Car(color: "green", money: 300)
        print("after person:\(person) person2:\(person2)")
    }
    
    mutating func runModifPerson3() {
        print("after person:\(person) person3:\(person3)")
        person3.name = "new name"
        person3.car.color = "orange"
        person3.car.money = 1000
        print("after person:\(person) person3:\(person3)")
    }
}

var example2 = Example2()

func exampleModifPersonName() {
    example2.run()
    example2.runModifPersonName()
    example2.run()
}

exampleModifPersonName()

example2.runModifCarMoney()
example2.runModifCar()
example2.runModifPerson3()

@propertyWrapper
class State_<Value> {
    
    var wrappedValue: Value
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    var projectedValue: Binding<Value> { binding }
    
    var binding: Binding<Value> {
        Binding<Value>(
            get: { self.wrappedValue },
            /*:
             这里使用class这个引用类型来实现State_，是由于如果是struct这个值类型，这里会得到一个编译报错
             
             ```
             Cannot assign to property: 'self' is immutable
             ```
             */
            set: { self.wrappedValue = $0 }//
        )
    }
}


struct Example3 {

    @State_
    private var byd = Car(color: "blue", money: 233)
    
    func run() {
        let inner: Binding<Car> = Binding(get: { byd }, set: { byd = $0 })
        byd.color = "red"
        byd.money = 1000
        print("byd:\(byd) inner:\(inner.wrappedValue)")
    }
}

var example3 = Example3()
example3.run()

@propertyWrapper
struct State<Value> {
    
    class Storage {
        
        var value: Value
        init(value: Value) { self.value = value }
    }
    
    private var storage: Storage
    
    var wrappedValue: Value {
        get { self.storage.value }
        nonmutating set { self.storage.value = newValue }
    }
    
    init(wrappedValue: Value) {
        self.storage = Storage(value: wrappedValue)
    }
    
    var projectedValue: Binding<Value> { binding }
    
    var binding: Binding<Value> {
        Binding<Value>(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0 }//
        )
    }
}

struct Example4 {
    @State
    var byd = Car(color: "blue", money: 233)
    
    var inner: Inner?
    
    init() {
        print("example4 init")
        self.inner = Inner(car: $byd)
    }
    
    func run() {
        let inner: Binding<Car> = Binding(get: { byd }, set: { byd = $0 })
        byd.color = "orange"
        byd.money = 100
        print("byd:\(byd) inner:\(inner.wrappedValue)")
    }
    
    struct Inner {
        
        @Binding
        var car: Car
        
        func run() {
            print("inner run")
            car.color = "inner_red"
            car.money = 999
        }
    }
}

let example4 = Example4()
print("before byd:\(example4.byd) inner:\(example4.inner!.car)")
example4.inner?.run()
print("after byd:\(example4.byd) inner:\(example4.inner!.car)")
