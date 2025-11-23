import Foundation
import Combine

extension Publisher where Output == Int {
    
    func filterEvenNumbers() -> AnyPublisher<Int, Failure> {
        return self.filter { $0 % 2 == 0 }
            .eraseToAnyPublisher()
    }
}

let publisher = [1, 2, 3, 4, 5].publisher
let evenPublisher = publisher.filterEvenNumbers()
let cancellable = evenPublisher.sink { value in
    print(value)
}

