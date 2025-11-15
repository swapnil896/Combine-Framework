import UIKit
import Combine

// Map

let numbersPublisher = [1, 2, 3, 4, 5].publisher
let squaredPub = numbersPublisher.map { $0 * $0 }
let cancellable = squaredPub.sink { value in
    print(value)
}

// FlatMap

let namesPublisher = ["John", "Mary", "Steven"].publisher
let flatennedPublisher = namesPublisher.flatMap { name in
    name.publisher
}
let cancellable2 = flatennedPublisher.sink { char in
    print(char)
}

// Merge

let pub1 = [1, 2, 3].publisher
let pub2 = [4, 5, 6].publisher

let mergedPublishers = Publishers.Merge(pub1, pub2)
let cancellable3 = mergedPublishers.sink { value in
    print(value)
}
