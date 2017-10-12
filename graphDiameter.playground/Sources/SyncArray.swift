import Foundation

public class SyncArray {
    public var array: [Int] = []
    private let accessQueue = DispatchQueue(label: "SyncArrayAccess", attributes: .concurrent)
    
    public func append(_ newElement: Int) {
        accessQueue.async(flags: .barrier) {
            self.array.append(newElement)
        }
    }
    
    public func max() -> Int {
        var max: Int = -1
        accessQueue.sync {
            if let arrMax = array.max() {
                if arrMax > max {
                    max = arrMax
                }
            }
        }
        return max
    }
}

