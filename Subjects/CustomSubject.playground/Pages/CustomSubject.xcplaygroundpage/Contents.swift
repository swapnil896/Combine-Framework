import UIKit
import Combine

class EvenNumbersSubject<Failure: Error>: Subject {
    
    typealias Output = Int
    
    private let wrapped: PassthroughSubject<Int, Failure>
    
    init(initialValue: Int) {
        self.wrapped = PassthroughSubject()
        let evenInitialValue = initialValue % 2 == 0 ? initialValue : initialValue + 1
        send(initialValue)
    }
    
    func send(subscription: any Subscription) {
        wrapped.send(subscription: subscription)
    }
    
    func send(_ value: Int) {
        if value % 2 == 0 {
            wrapped.send(value)
        }
    }
    
    func send(completion: Subscribers.Completion<Failure>) {
        wrapped.send(completion: completion)
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Int == S.Input {
        wrapped.receive(subscriber: subscriber)
    }
}

let evenSubject = EvenNumbersSubject<Never>(initialValue: 4)
let cancellable = evenSubject.sink { value in
    print(value)
}

evenSubject.send(12)
evenSubject.send(13)
evenSubject.send(20)

