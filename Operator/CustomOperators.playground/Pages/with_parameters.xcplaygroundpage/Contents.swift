import UIKit
import Combine

print("============================================")

extension Publisher where Output == Int {
    
    func filterNumberGreaterThan(_ value: Int) -> AnyPublisher<Int, Failure> {
        return self.filter { $0 > value }
            .eraseToAnyPublisher()
    }
}

let publisher = (1...10).publisher
let filteredPublisher = publisher.filterNumberGreaterThan(5)
let cancellable = filteredPublisher.sink { value in
    print(value)
}
