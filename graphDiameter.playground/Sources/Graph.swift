import Foundation

public struct Graph {
    private var dict: [Vertex : [Vertex]]
    
    public enum RunType {
        case normal, custom
    }
    
    public var vertices: [Vertex] {
        return Array(dict.keys)
    }
    
    public init(arr: [(Int,Int)]) {
        dict = [:]
        arr.forEach { edge in
            let source = Vertex(id: edge.0)
            let destination = Vertex(id: edge.1)
            
            addEdge(from: source, to: destination)
        }
    }
    
    // Convenience init with filename
    public init(fileName: String) {
        dict = [:]
        if let result = FileReader.read(fileName) {
            let tupleArr = result.parse()
            
            tupleArr.forEach { edge in
                let source = Vertex(id: edge.0)
                let destination = Vertex(id: edge.1)
                
                addEdge(from: source, to: destination)
            }
        }
    }
    
    public mutating func addEdge(from source: Vertex, to destination: Vertex) {
        if let neighbors = dict[source] {
            dict[source] = neighbors + [destination]
        } else {
            dict[source] = [destination]
        }
    }
    
    public func bfsCustom(vertex: Vertex) -> MaxDict {
        var queue = Queue<Vertex>()
        
        var distances = MaxDict()
        dict.keys.forEach { distances.updateValue(-1, forKey: $0) }
        distances.updateValue(0, forKey: vertex)
        
        var parent = [Vertex : Vertex]()
        
        queue.enqueue(vertex)
        
        while !queue.empty() {
            if let front = queue.dequeue() {
                if let neighbors = dict[front] {
                    neighbors.forEach { v in
                        if distances[v] == -1 {
                            queue.enqueue(v)
                            distances[v] = distances[front]! + 1
                            parent[v] = front
                        }
                    }
                }
            }
        }
        return distances
    }
    
    public func bfsNormal(vertex: Vertex) -> [Vertex : Int] {
        var queue = Queue<Vertex>()
        
        var distances = [Vertex : Int]()
        dict.keys.forEach { distances.updateValue(-1, forKey: $0) }
        distances[vertex] = 0
        
        var parent = [Vertex : Vertex]()
        
        queue.enqueue(vertex)
        
        while !queue.empty() {
            if let front = queue.dequeue() {
                if let neighbors = dict[front] {
                    neighbors.forEach { v in
                        if distances[v] == -1 {
                            queue.enqueue(v)
                            distances[v] = distances[front]! + 1
                            parent[v] = front
                        }
                    }
                }
            }
        }
        return distances
    }
    
    public func getFirstVertex() -> Vertex? {
        return dict.keys.first
    }
    
    public func eccentricityNormal(_ vertex: Vertex) -> Int {
        let distances = bfsNormal(vertex: vertex)
        var max: Int = -1

        distances.values.forEach { val in
            if val > max {
                max = val
            }
        }
        return max
    }
    
    public func eccentricityCustom(_ vertex: Vertex) -> Int {
        return bfsCustom(vertex: vertex).max
    }
    
    // max eccentricity for entire graph
    public func diameter(type: RunType) -> Int {
        var max: Int = -1
        vertices.forEach { v in
            let eccen = (type == .normal) ? eccentricityNormal(v) : eccentricityCustom(v)
            if eccen > max {
                max = eccen
            }
        }
        return max
    }
}

public struct MaxDict {
    private var dict: [Vertex : Int]
    
    private var internalMax: Int
    
    public init() {
        dict = [:]
        internalMax = -1
    }
    
    public var max: Int {
        return internalMax
    }
    
    mutating public func updateValue(_ val: Int, forKey: Vertex) {
        dict.updateValue(val, forKey: forKey)
        if val > max {
            internalMax = val
        }
    }
    
    public subscript(val: Vertex) -> Int? {
        get {
            return dict[val]
        }
        set {
            guard let new = newValue else { return }
            dict[val] = new
            if new > max {
                internalMax = new
            }
        }
    }
    
    public func normalDict() -> [Vertex : Int] {
        return dict
    }
}
