import UIKit
import Combine

enum NumberError: Error {
    case operationFailed
}

let numbersPublisher = [1, 2, 3, 4, 5].publisher

/*  -------- One way of Error handling -------------------
let doubledPublisher = numbersPublisher.tryMap { number in
    if number == 4 {
        throw NumberError.operationFailed
    }
    
    return number * 2
}.catch { error in
    if let error = error as? NumberError {
        print(error)
    }
    
    return Just(0)
}

let cancellable = doubledPublisher.sink { completion in
    switch completion {
    case .finished:
        print("Finished")
    case .failure(let error):
        print("Error : \(error)")
    }
} receiveValue: { value in
    print(value)
}
*/

/*  -------- Other way of Error handling ------------------- */
let doubledPublisher = numbersPublisher.tryMap { number in
    if number == 4 {
        throw NumberError.operationFailed
    }
    
    return number * 2
}.mapError { error in
    return NumberError.operationFailed
}

let cancellable = doubledPublisher.sink { completion in
    switch completion {
    case .finished:
        print("Finished")
    case .failure(let error):
        print(error)
    }
} receiveValue: { value in
    print(value)
}

