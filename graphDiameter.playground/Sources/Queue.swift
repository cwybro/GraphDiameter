public struct Queue<T> {
    private var arr: [T]
    
    public init() {
        arr = []
    }
    
    public func empty() -> Bool {
        return arr.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        arr.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if arr.isEmpty {
            return nil
        } else {
            return arr.removeFirst()
        }
    }
}
