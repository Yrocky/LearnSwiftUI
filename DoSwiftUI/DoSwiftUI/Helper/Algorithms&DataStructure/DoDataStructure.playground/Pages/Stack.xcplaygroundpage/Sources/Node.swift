import Foundation

class Node<V> {
    var value: V
    var next: V?
    
    init(_ value: V) {
        self.value = value
    }
}
