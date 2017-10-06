import Foundation

public struct Graph {
    private var adjList: [[Int]]
    
    public enum RunType {
        case normal, custom
    }
    
    // Convenience init with filename
    public init(fileName: String) {
        adjList = []
        if let result = FileReader.read(fileName) {
            adjList = Array(repeating: [], count: result.points+1)
            result.tuples.forEach { addEdge(from: $0.0, to: $0.1) }
        }
    }
    
    public mutating func addEdge(from source: Int, to destination: Int) {
        adjList[source] = adjList[source] + [destination]
    }
    
    public func bfsCustom(vertex: Int) -> MaxDict {
        var queue = Queue<Int>()
        
        var distances = MaxDict()
        (0..<adjList.count).forEach { distances.updateValue(-1, forKey: $0) }
        distances.updateValue(0, forKey: vertex)
        
        queue.enqueue(vertex)
        
        while !queue.empty() {
            if let front = queue.dequeue() {
                if front < adjList.count {
                    adjList[front].forEach { v in
                        if distances[v] == -1 {
                            queue.enqueue(v)
                            distances[v] = distances[front]! + 1
                        }
                    }
                }
            }
        }
        return distances
    }
    
    public func bfsNormal(vertex: Int) -> [Int : Int] {
        var queue = Queue<Int>()
        
        var distances = [Int : Int]()
        (0..<adjList.count).forEach { distances.updateValue(-1, forKey: $0) }
        distances[vertex] = 0
        
        queue.enqueue(vertex)
        
        while !queue.empty() {
            if let front = queue.dequeue() {
                if front < adjList.count {
                    adjList[front].forEach { v in
                        if distances[v] == -1 {
                            queue.enqueue(v)
                            distances[v] = distances[front]! + 1
                        }
                    }
                }
            }
        }
        return distances
    }
    
    public func eccentricityNormal(_ vertex: Int) -> Int {
        let distances = bfsNormal(vertex: vertex)
        var max: Int = -1
        
        distances.values.forEach { val in
            if val > max {
                max = val
            }
        }
        return max
    }
    
    public func eccentricityCustom(_ vertex: Int) -> Int {
        return bfsCustom(vertex: vertex).max
    }
    
    // max eccentricity for entire graph
    public func diameter(type: RunType) -> Int {
        var max: Int = -1
        (0..<adjList.count).forEach { v in
            let eccen = (type == .normal) ? eccentricityNormal(v) : eccentricityCustom(v)
            if eccen > max {
                max = eccen
            }
        }
        return max
    }
}

public struct MaxDict {
    private var dict: [Int : Int]
    
    private var internalMax: Int
    
    public init() {
        dict = [:]
        internalMax = -1
    }
    
    public var max: Int {
        return internalMax
    }
    
    mutating public func updateValue(_ val: Int, forKey: Int) {
        dict.updateValue(val, forKey: forKey)
        if val > max {
            internalMax = val
        }
    }
    
    public subscript(val: Int) -> Int? {
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
    
    public func normalDict() -> [Int : Int] {
        return dict
    }
}
