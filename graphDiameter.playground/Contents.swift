import Foundation


let graph = Graph(fileName: "graph_max_2000")

print("Diameter with bruteForce: \(graph.diameter(type: .bruteForce))")
//print("Diameter with akiba: \(graph.diameter(type: .akiba))")
print("Diameter with parallelBF: \(graph.diameter(type: .parallelBF))\n")
//print("Diameter with custom2: \(graph.diameter(type: .custom2))")
//print("Diameter with custom3: \(graph.diameter(type: .custom3))\n")

var experiment = Experiment()

experiment.add(withId: "bruteForce") {
    graph.diameter(type: .bruteForce)
}

experiment.add(withId: "parallelBF") {
    graph.diameter(type: .parallelBF)
}

//experiment.add(withId: "custom2") {
//    graph.diameter(type: .custom2)
//}

//experiment.add(withId: "custom3") {
//    graph.diameter(type: .custom3)
//}

//experiment.add(withId: "akiba") {
//    graph.diameter(type: .akiba)
//}

let result = experiment.run(trials: 1, internalLoops: 1)
//print("Result: \(result)")
//print("Sum: \(result.sum)")
print("Average: \(result.average)\n")
result.compare(to: "parallelBF")
//result.compare(to: "bruteForce")

