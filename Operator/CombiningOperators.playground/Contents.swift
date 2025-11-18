import UIKit
import Combine

//===========================================================================================================================
// combineLatest

// combineLatest works in combining different streams in Combine

let publisher1 = CurrentValueSubject<Int, Never>(1)
//let publisher2 = CurrentValueSubject<Int, Never>(2)
//let publisher2 = CurrentValueSubject<String, Never>("Hello")
let publisher2 = CurrentValueSubject<[Int], Never>([1, 2, 3])

let combinedPublisher = publisher1.combineLatest(publisher2)

let cancellable = combinedPublisher.sink { value1, value2 in
    print("first : \(value1), second : \(value2)")
}

publisher1.send(3)
publisher2.send([4, 5, 6])
print("==============================")


//===========================================================================================================================
// Zip

// zip operator combines elements pairwise, it takes 2 or more publishers and pairs up their emitted values based on the order of emission

//------------------------------------------------------
// eg : 1
let publisher3 = [1, 2, 3].publisher
let publisher4 = ["A", "B", "C"].publisher

let zippedPublishers = publisher3.zip(publisher4)
let zipCancellable = zippedPublishers.sink { tuple in
    print("\(tuple.0) \(tuple.1)")
}
print("---------------------------------")

//------------------------------------------------------
// eg : 2
let publisher5 = [1, 2, 3, 4].publisher
let publisher6 = ["A", "B", "C"].publisher

let zippedPublisher2 = publisher5.zip(publisher6)
let zip2Cancellable = zippedPublisher2.sink { value in
    print("\(value.0) \(value.1)")
}
print("---------------------------------")

//------------------------------------------------------
// eg : 3
let publisher7 = ["John", "Mary", "Steven"].publisher
let zippedPublishers3 = Publishers.Zip3(publisher3, publisher4, publisher7)

let zip3Cancellable = zippedPublishers3.sink { value in
    print("\(value.0) \(value.1) \(value.2)")
}
print("==============================")

//===========================================================================================================================

// switchToLatest

let outerPublisher = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
let innerPublisher1 = CurrentValueSubject<Int, Never>(1)
let innerPublisher2 = CurrentValueSubject<Int, Never>(2)

let switchToLatestCancellable = outerPublisher
    .switchToLatest()
    .sink { value in
        print(value)
    }

outerPublisher.send(AnyPublisher(innerPublisher1))
innerPublisher1.send(10)

outerPublisher.send(AnyPublisher(innerPublisher2))
innerPublisher2.send(20)

// The above switchToLatest cancellable will not be called as the OuterPublisher is allocated to innerPublisher2 now and not innerPublisher1
innerPublisher1.send(100)

print("==============================")
