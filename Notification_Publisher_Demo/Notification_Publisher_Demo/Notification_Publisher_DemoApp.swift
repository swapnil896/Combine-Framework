//
//  Notification_Publisher_DemoApp.swift
//  Notification_Publisher_Demo
//
//  Created by Swapnil Magar on 15/11/25.
//

import SwiftUI
import Combine

@main
struct Notification_Publisher_DemoApp: App {
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .sink { _ in
                let currentOrientation = UIDevice.current.orientation
                print(currentOrientation)
            }.store(in: &cancellables)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
