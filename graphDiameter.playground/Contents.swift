import Foundation


let smallGraph = Graph(fileName: "small")
let largeGraph = Graph(fileName: "large")

print("small: \(smallGraph)")
print("Diameter of small (normal): \(smallGraph.diameter(type: .normal))")
print("Diameter of small (custom): \(smallGraph.diameter(type: .custom))")

print("large: \(largeGraph)")
print("Diameter of large (normal): \(largeGraph.diameter(type: .normal))")
print("Diameter of large (custom): \(largeGraph.diameter(type: .custom))")
//
//if largeGraph.diameter(type: .normal) == 3 && largeGraph.diameter(type: .custom) == 3 {
//
//    var experiment = Experiment()
//
//    experiment.add(withId: "custom") {
//        largeGraph.diameter(type: .custom)
//    }
//    experiment.add(withId: "normal") {
//        largeGraph.diameter(type: .normal)
//    }
//
//    let result = experiment.run(trials: 3, internalLoops: 1000)
//    print(result)
//    print(result.averages)
//}

let path = Graph(fileName: "path_10")
let graph = Graph(fileName: "graph_10")

print("Path: \(path)")
print("Diameter of path (normal): \(path.diameter(type: .normal))")
print("Diameter of path (custom): \(path.diameter(type: .custom))")

print("Graph: \(graph)")
print("Diameter of graph (normal): \(graph.diameter(type: .normal))")
print("Diameter of graph (custom): \(graph.diameter(type: .custom))")

