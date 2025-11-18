import UIKit
import Combine
import PlaygroundSupport

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

// Filter

let numsPublisher = (1...10).publisher
let evenNumsPublisher = numsPublisher.filter { num in
    return num % 2 == 0
}

let evenCancellable = evenNumsPublisher.sink { value in
    print(value)
}

// CompactMap

let stringsPublisher = ["1", "2", "3", "4", "A"].publisher
let intsPublisher = stringsPublisher.compactMap { Int($0) }
let intsCancellable = intsPublisher.sink { value in
    print(value)
}

// debounce
// This operator controls the rate at which publisher emits values. It pauses the emission of values from a publisher for the specified amount of time. Eg: SearchBar input

PlaygroundPage.current.needsIndefiniteExecution = true

let textPublisher = PassthroughSubject<String, Never>()

let debouncedPub = textPublisher
    .debounce(for: .seconds(0.00001), scheduler: DispatchQueue.main)
    .eraseToAnyPublisher()

let textPubCancellable = debouncedPub.sink { value in
    print(value)
}

textPublisher.send("A")
textPublisher.send("B")
textPublisher.send("C")
textPublisher.send("D")
textPublisher.send("E")
textPublisher.send("F")


