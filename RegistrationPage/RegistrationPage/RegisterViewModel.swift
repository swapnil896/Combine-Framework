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
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var allFieldsValid: Bool = false
    
    init() {
        setupPublishers()
    }
    
    private func setupPublishers() {
        $userName
            .removeDuplicates()
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .map { [weak self] name in
                guard let strongSelf = self else { return false }
                return strongSelf.checkUsernameAvailability(name)
            }
            .assign(to: &$isUserNameAvailable)
        
        $email
            .removeDuplicates()
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .map { [weak self] email in
                guard let strongSelf = self else { return false }
                return strongSelf.isEmailValid(email: email)
            }
            .assign(to: &$isEmailValid)
        
        $password
            .removeDuplicates()
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .map { [weak self] password in
                guard let strongSelf = self else { return false }
                return strongSelf.isPasswordValid(password: password)
            }
            .assign(to: &$isPasswordValid)
        
        Publishers.CombineLatest3($isEmailValid, $isPasswordValid, $isUserNameAvailable)
            .map { emailValid, passwordValid, usernameAvailable in
                emailValid && passwordValid && usernameAvailable
            }
            .assign(to: &$allFieldsValid)
    }
    
    func checkUsernameAvailability(_ userName: String) -> Bool {
        if userName == "Swapnil@123" || userName == "Swapnil" {
            return false
        }
        return true
    }
    
    func isEmailValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        if email.contains("@") && email.contains(".") {
            return true
        }
        return false
    }
    
    func isPasswordValid(password: String) -> Bool {
        guard !password.isEmpty else { return false }
        return true
    }
}
