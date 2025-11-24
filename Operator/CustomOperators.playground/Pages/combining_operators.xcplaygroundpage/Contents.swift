import Foundation
import Combine

print("============================================")

extension Publisher {
    
    func mapAndFilter<T>(_ transform: @escaping (Output) -> T, _ isIncluded: @escaping (T) -> Bool ) -> AnyPublisher<T, Failure> {
        return self
            .map { transform($0) }
            .filter { isIncluded($0) }
            .eraseToAnyPublisher()
    }
}

let publisher = (1...10).publisher
let transformedPublisher = publisher.mapAndFilter { $0 * 3 } _: { $0 % 2 == 0 }
let cancellable = transformedPublisher.sink { value in
    print(value)
}

