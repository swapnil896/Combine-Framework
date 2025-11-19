import UIKit
import Combine

enum SampleError: Error {
    case excludeThreeError
    case characterError
}

//======================================= tryMap & catch =======================================
// Observe that in catch we can't just simply print the error, we need to return a Publisher

let numbersPublisher = [1, 2, 3, 4, 5].publisher
let excludeThreePublisher = numbersPublisher
    .tryMap { number in
        if number == 3 {
            throw SampleError.excludeThreeError
        }
        
        return number
    } .catch { error in
        print(error)
        return Just(0)
    }

let cancellable = excludeThreePublisher.sink { value in
    print(value)
}

/*-----------------------------------
 OUTPUT :-
 1
 2
 excludeThreeError
 0
 -----------------------------------*/

//======================================= replaceError (with single value) =============================
// Eg: 1
let numbersPublisher2 = [1, 2, 3, 4, 5].publisher

let transformedPublisher = numbersPublisher2
    .tryMap { number in
        if number == 3 {
            throw SampleError.excludeThreeError
        }
        
        return number * 2
    }
    .replaceError(with: -1)

let cancellable2 = transformedPublisher.sink { value in
    print(value)
}

/*-----------------------------------
 OUTPUT :-
 2
 4
 -1
-----------------------------------*/

// Eg: 2
let charactersPublisher = ["A", "B", "C", "D"].publisher

let lowercasedPublisher = charactersPublisher
    .tryMap { character in
        if character == "C" {
            throw SampleError.characterError
        }
        
        return character.lowercased()
    }
    .replaceError(with: "NULL")

let cancellable3 = lowercasedPublisher.sink { value in
    print(value)
}

/*-----------------------------------
 OUTPUT :-
 a
 b
 NULL
-----------------------------------*/

//======================================= replaceError (with another Publisher) ===========================

let numbersPublisher3 = [1, 2, 3, 4].publisher

let fallbackPublisher = Just(-1)

let transformedPublisher2 = numbersPublisher3
    .tryMap { number in
        if number == 3 {
            throw SampleError.excludeThreeError
        }
        return Just(number * 2)
    }
    .replaceError(with: fallbackPublisher)

let cancellable4 = transformedPublisher2.sink { publisher in
    let _ = publisher.sink { value in
        print(value)
    }
}

/*-----------------------------------
 OUTPUT :-
 2
 4
 -1
-----------------------------------*/


//======================================= retry ======================================================

let numsPublisher = PassthroughSubject<Int, Error>()
let retriedPublisher = numsPublisher
    .tryMap { num in
        if num == 3 {
            throw SampleError.excludeThreeError
        }
        return num
    }
    .retry(2)

let cancellable5 = retriedPublisher.sink { completion in
    switch completion {
    case .finished:
        print("Publisher finished")
    case .failure(let error):
        print("Error occurred : \(error)")
    }
} receiveValue: { value in
    print(value)
}


numsPublisher.send(1)
numsPublisher.send(2)
numsPublisher.send(3) // failed 1st time
numsPublisher.send(4)
numsPublisher.send(5)
numsPublisher.send(3) // failed 2nd time
numsPublisher.send(6)
numsPublisher.send(7)
numsPublisher.send(3) // failed 3rd time, now no further execution
numsPublisher.send(9)

/*-----------------------------------
 OUTPUT :-
 1
 2
 4
 5
 6
 7
 Error occurred : excludeThreeError
-----------------------------------*/
