//
//  ContentView.swift
//  Notification_Publisher_Demo
//
//  Created by Swapnil Magar on 15/11/25.
//

import SwiftUI
import Combine

/*
    In the below code, we are demonstrating the lifecycle of Subscription. As we can see, the cancellable subscription is inside ContentViewModel. So it is alive until vm is alive and vm is alive until ContentView is alive
 */

// Handling Subscription Lifecycles
class ContentViewModel: ObservableObject {
    
    @Published var value: Int = 0
    private var cancellable: AnyCancellable?
    
    init() {
        let publisher = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .map { _ in
                self.value + 1
            }
        
        cancellable = publisher.assign(to: \.value, on: self)
    }
}


struct ContentView: View {
    
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.value)")
                .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
