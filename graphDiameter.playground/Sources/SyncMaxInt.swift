import Foundation

public struct MaxInt {
    private let accessQueue = DispatchQueue(label: "SyncMaxIntAccess", attributes: .concurrent)
    
    private var maxBack: Int = 0
    public var max: Int {
        get {
            var num = -1
            accessQueue.sync {
                num = maxBack
            }
            return num
        }
        set {
            accessQueue.sync {
                if newValue > maxBack {
                    maxBack = newValue
                }
            }
        }
    }
}

