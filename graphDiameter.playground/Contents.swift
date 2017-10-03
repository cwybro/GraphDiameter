import Foundation


let smallGraph = Graph(fileName: "small")
let largeGraph = Graph(fileName: "large")

if largeGraph.diameter(type: .normal) == 3 && largeGraph.diameter(type: .custom) == 3 {
    
    var experiment = Experiment()
    experiment.add(withId: "custom") {
        largeGraph.diameter(type: .custom)
    }
    experiment.add(withId: "normal") {
        largeGraph.diameter(type: .normal)
    }
    
//    let result = experiment.run(trials: 3, internalLoops: 10000)
//    print(result)
//    print(result.averages)
}

//var experiment = Experiment()
//experiment.add(withId: "somethingSlow") {
//    (0..<10).forEach { _ in 2+2 }
//}
//experiment.add(withId: "somethingFast") {
//    2+2
//}
//let result = experiment.run(trials: 10, internalLoops: 1000)
//print(result)
//print(result.averages)


