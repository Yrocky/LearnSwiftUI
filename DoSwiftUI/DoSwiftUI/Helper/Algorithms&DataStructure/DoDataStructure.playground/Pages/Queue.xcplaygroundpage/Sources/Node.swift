import Foundation

class Node<Element: Comparable> {
    
    let value: Element
    // 这里不需要为Node指定类型，编译器会知道他们需要的类型与当前实例是同一种
    weak var previous: Node?
    var next: Node?
    
    init(_ value: Element) {
        self.value = value
    }
}
