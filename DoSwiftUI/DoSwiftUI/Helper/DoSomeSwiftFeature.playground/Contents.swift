import UIKit

var str = "Hello, playground"

//: @autoclosure

func oop(exp: @autoclosure () -> Bool, msg: @autoclosure () -> String) {
    if !exp() {
        print("Error: \(msg())")
    }
}

func uzp(exp: () -> Bool, msg: () -> String) {
    if !exp() {
        print("Error: \(msg())")
    }
}

struct TimeZoneWidget {
    
    var exp: Bool = false

    func foo() {
//        oop(exp: { false }, msg: { "network error" })
        oop(exp: exp, msg: "empty data")
        
        uzp { exp } msg: { "lost network connect"}

    }

    var label: UILabel = UILabel()
    
    func anim() {
        animate(label.frame.origin.y = 100)
        
        animate(modifLabel())
        
//        animate(modifLabelAndReturn())
    }
    
    func modifLabel() {
        
        label.frame.origin.y = 100
        label.backgroundColor = .orange
        label.frame.size.width = 80
    }
    
    func modifLabelAndReturn() -> String {
        
        label.frame.origin.y = 100
        label.backgroundColor = .orange
        label.frame.size.width = 80
        
        return "modif"
    }
    
    func fetchValueFromDictionary() {
        let dic : [String: Any] = [
            "name": "rocky",
            "age": 28
        ]
        
        let age = dic.value(forKey: "age", defaultValue: 30)
        let address = dic.value(forKey: "address", defaultValue: "Chain.shanghai")
    }
}

func animate(
    _ animation: @autoclosure @escaping () -> Void,
    duration: TimeInterval = 0.25
) {
    UIView.animate(withDuration: duration, animations: animation)
}

extension Dictionary where Value == Any {
    
    func value<T>(forKey key: Key, defaultValue: @autoclosure () -> T) -> T {
        guard let v = self[key] as? T else {
            return defaultValue()
        }
        
        return v
    }
}

//: KeyPath

struct Person{
    var name: String
    var age: Int = 20
    var address: String = "Chain"
}


let persons = [
    Person(name: "aaa"),
    Person(name: "bb"),
    Person(name: "cccc")
]

let names = persons.map { $0.name }
let addresses = persons.map { $0.address }

extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
}

let ages = persons.map(\.age)

