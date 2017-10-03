import Foundation

public struct Vertex {
    let id: Int
}

//public struct Vertex<T: Hashable> {
//    let id: T
//}

extension Vertex: Equatable, Hashable, CustomStringConvertible {
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var hashValue: Int {
        return id.hashValue
    }
    
    public var description: String {
        return "\(id)"
    }
}
