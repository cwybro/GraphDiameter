import Foundation

public typealias Closure = () -> ()

public struct Experiment {
    
    private var operations: [Operation]
    
    public init() {
        operations = []
    }
    
    mutating public func add(withId: String, closure: @escaping Closure) {
        let operation = Operation(id: withId, block: closure)
        operations.append(operation)
    }
    
    public func run(trials: Int, internalLoops: Int) -> Result {
        var result = Result()

        (0..<trials).forEach { _ in

            operations.forEach { op in
                let time = timer(internalLoops) {
                    op.block()
                }

                result.add(time: time, forId: op.id)
            }
        }
        return result
    }
    
    private func timer(_ loops: Int, closure: Closure) -> TimeInterval {
        let now = Date()
        (0..<loops).forEach { _ in closure() }
        return -now.timeIntervalSinceNow
    }
}

public struct Operation {
    let id: String
    let block: Closure
}

public struct Result {
    public var times: [String : [TimeInterval]] = [:]
    
    public var average: [String : TimeInterval] {
        var avg: [String : TimeInterval] = [:]
        times.forEach { (key, value) in
            let reduced = value.reduce(0,+) / TimeInterval(value.count)
            avg[key] = reduced
        }
        return avg
    }
    
    public var sum: [String : TimeInterval] {
        var sum: [String : TimeInterval] = [:]
        times.forEach { (key, value) in
            let singleSum = value.reduce(0,+)
            sum[key] = singleSum
        }
        return sum
    }
    
    mutating func add(time: TimeInterval, forId: String) {
        if times[forId] != nil {
            times[forId] = times[forId]! + [time]
        } else {
            times[forId] = [time]
        }
    }
}
