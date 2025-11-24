//
//  RegisterViewModel.swift
//  RegistrationPage
//
//  Created by Swapnil Magar on 23/11/25.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    
    @Published var isUserNameAvailable: Bool = true
    @Published var allFieldsValid: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupPublishers()
    }
    
    private func setupPublishers() {
        $userName
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] userName in
                guard let strongSelf = self else { return }
                strongSelf.isUserNameAvailable = strongSelf.checkUsernameAvailability(userName)
                strongSelf.allFieldsValid = strongSelf.isUserNameAvailable ? true : false
            }.store(in: &cancellables)
    }
    
    func checkUsernameAvailability(_ userName: String) -> Bool {
        if userName == "Swapnil@123" || userName == "Swapnil" {
            return false
        }
        return true
    }
}
