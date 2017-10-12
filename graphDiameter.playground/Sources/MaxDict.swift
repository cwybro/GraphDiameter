import Foundation

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
