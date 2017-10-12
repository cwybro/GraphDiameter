import Foundation

public struct Graph {
    public var adjList: [[Int]]
    
    public enum RunType {
        case bruteForce, akiba, custom1, custom2, custom3
    }
    
    public var size: Int {
        return adjList.count
    }
    
    public var transposedAdjList: [[Int]] {
        var tAdjList: [[Int]] = Array(repeating: [], count: adjList.count)
        
        adjList.enumerated().forEach { index, arr in
            arr.forEach { num in
                tAdjList[num] = tAdjList[num] + [index]
            }
        }
        return tAdjList
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
}

// MARK: - Helper methods
extension Graph {
    // MARK: Breadth First Search
    private func bfs(aList: [[Int]], vertex: Int) -> [Int : Int] {
        var queue = Queue<Int>()
        
        var distances = [Int : Int]()
        (0..<aList.count).forEach { distances.updateValue(-1, forKey: $0) }
        distances[vertex] = 0
        
        queue.enqueue(vertex)
        
        while !queue.empty() {
            if let front = queue.dequeue() {
                if front < aList.count {
                    aList[front].forEach { v in
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
    
    // MARK: Eccentricity
    private func eccentricity(aList: [[Int]], vertex: Int) -> Int {
        let distances = bfs(aList: aList, vertex: vertex)
        var max: Int = -1
        
        distances.values.forEach { val in
            if val > max {
                max = val
            }
        }
        return max
    }
    
    private func eccentricityConcurrent(aList: [[Int]], vertex: Int) -> Int {
        let distances = bfs(aList: aList, vertex: vertex)
        var num = MaxInt()
        
        DispatchQueue.concurrentPerform(iterations: distances.values.count) { v in
            num.max = distances[v]!
        }
        return num.max
    }
    
    private func doubleSweep(_ loops: Int=1) -> Int {
        var diameter = -1
        
        (0..<loops).forEach { _ in
            // Select random vertex - v
            let v = Int(arc4random_uniform(UInt32(adjList.count)))
            
            // Compute eccentricity and find w
            var eccen = -1
            var w = -1
            let distances = bfs(aList: self.adjList, vertex: v)
            distances.forEach { if $0.1 > eccen { w = $0.0; eccen = $0.1 } }
            
            let wDist = bfs(aList: self.transposedAdjList, vertex: w)
            let max = wDist.values.max() ?? -1
            if max > diameter {
                diameter = max
            }
        }
        return diameter
    }
}

// MARK: - Solutions
extension Graph {
    // MARK: Diameter
    public func diameter(type: RunType) -> Int {
        switch type {
        case .bruteForce: return bruteForce()
        case .akiba: return akiba()
        case .custom1: return custom1()
        case .custom2: return custom2()
        case .custom3: return custom3()
        }
    }
    
    private func bruteForce() -> Int {
        // Find max distance of performing BFS from all vertices
        var max: Int = -1
        (0..<adjList.count).forEach { v in
            let eccen = eccentricity(aList: self.adjList, vertex: v)
            if eccen > max {
                max = eccen
            }
        }
        return max
    }
    
    private func akiba() -> Int {
        return -1
    }
    
    // Concurrent eccentricity computations
    private func custom1() -> Int {
        let distances = SyncArray()
        DispatchQueue.concurrentPerform(iterations: adjList.count) { v in
            let eccen = eccentricity(aList: self.adjList, vertex: v)
            distances.append(eccen)
        }
        return distances.max()
    }
    
    // Custom 1 & Concurrent max on individual eccentricity computations
    private func custom2() -> Int {
        let distances = SyncArray()
        DispatchQueue.concurrentPerform(iterations: adjList.count) { v in
            let eccen = eccentricityConcurrent(aList: self.adjList, vertex: v)
            distances.append(eccen)
        }
        return distances.max()
    }
    
    // Brute-force with concurrent eccentricity computations
    private func custom3() -> Int {
        var max: Int = -1
        (0..<adjList.count).forEach { v in
            let eccen = eccentricityConcurrent(aList: self.adjList, vertex: v)
            if eccen > max {
                max = eccen
            }
        }
        return max
    }
}
