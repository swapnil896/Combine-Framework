//: [Previous](@previous)

import Foundation
import Combine

// Demo to show how Subjects can act as Publishers & Subscribers
@MainActor
class WeatherClient {
    
    let updates = PassthroughSubject<Int, Never>()
    
    func fetchWeather() {
        // To mock a API calling
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.updates.send(Int.random(in: 32...100))
        }
    }
}

let weatherClient = WeatherClient()

let cancellable = weatherClient.updates.sink { value in
    print(value)
}
weatherClient.fetchWeather()
