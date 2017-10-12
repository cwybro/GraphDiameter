import Foundation


//let smallGraph = Graph(fileName: "small")
//let largeGraph = Graph(fileName: "large")
//
//print("small: \(smallGraph)")
//print("Diameter of small (normal): \(smallGraph.diameter(type: .normal))")
//print("Diameter of small (custom): \(smallGraph.diameter(type: .custom))")
//
//print("large: \(largeGraph)")
//print("Diameter of large (normal): \(largeGraph.diameter(type: .normal))")
//print("Diameter of large (custom): \(largeGraph.diameter(type: .custom))")

//let veryLarge = Graph(fileName: "path_1000")
//
//if veryLarge.diameter(type: .normal) == 1000 && veryLarge.diameter(type: .custom) == 1000 {
//
//    var experiment = Experiment()
//
//    experiment.add(withId: "custom") {
//        veryLarge.diameter(type: .custom)
//    }
//    experiment.add(withId: "normal") {
//        veryLarge.diameter(type: .normal)
//    }
//
//    let result = experiment.run(trials: 3, internalLoops: 1)
//    print(result)
//    print(result.average)
//}

// double sweep does not work on paths
let graph = Graph(fileName: "graph_10")

print("Diameter with bruteForce: \(graph.diameter(type: .bruteForce))")
print("Diameter with akiba: \(graph.diameter(type: .akiba))")
print("Diameter with custom: \(graph.diameter(type: .custom))")

var experiment = Experiment()

experiment.add(withId: "bruteForce") {
    graph.diameter(type: .bruteForce)
}

experiment.add(withId: "custom") {
    graph.diameter(type: .custom)
}

let result = experiment.run(trials: 10, internalLoops: 10000)
//print("Result: \(result)")
print("Sum: \(result.sum)")
print("Average: \(result.average)")

//print("Diameter with double sweep: \(graph.doubleSweep())")
//print("Diameter with normal diameter: \(graph.diameter(type: .normal))")

//var experiment = Experiment()
//experiment.add(withId: "doubleSweep") {
//    graph.doubleSweep()
//}
//experiment.add(withId: "normalDiam") {
//    graph.diameter(type: .normal)
//}
//let result = experiment.run(trials: 3, internalLoops: 100)
//print(result)
//print("results: \(result.average)")

