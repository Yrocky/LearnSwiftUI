import Foundation

class Stack<V> {
    var head: Node<V>?
    var count: Int = 0
    
    public var isEmpty: Bool {
        count == 0
    }
    
    public func push(_ value: V) {
        let oldHead = head
        head = Node(value)
        head?.next = oldHead
        count ++
    }
    
    public func pop() -> V? {
        let value = head?.value
        head = head?.next
        count -= 1
        return value
    }
}
