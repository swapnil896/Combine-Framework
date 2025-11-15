import UIKit
import Combine

//------------------------------------------------------------------

// Simplest form of a Publisher, which publishes just one value
let publisher = Just("Hello world")

// Subscriber
let cancellable = publisher.sink { value in
    print(value)
}

// cancels the subscription, but it is not required as the subscriber automatically gets cancelled once the above part (Pub, sub) goes out of scope
cancellable.cancel()

//------------------------------------------------------------------

let publisher2 = Just(123)
publisher2.sink { value in
    print(value)
}

//------------------------------------------------------------------
// Sequence Publisher

// In Combine, every Publisher has two associated types:
// Publisher where Output == T, Failure == E
// Never is a special type in Swift that means “this can never happen.”
// When a publisher’s Failure type is Never, it means:
// “This publisher will never fail — it will only complete successfully.”

let numbersPublisher = [1, 2, 3, 4, 5].publisher

// Here .map returns Publisher and not a array
let doublesPublisher = numbersPublisher.map { $0 * 2 }
doublesPublisher.sink { value in
    print(value)
}

// Sequence Publisher for Range
let numbersRangePublisher = (1...10).publisher
let cancellable3 = numbersRangePublisher.sink { value in
    print(value)
}

// We can cancel the subscription after delay
DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    cancellable3.cancel()
}
