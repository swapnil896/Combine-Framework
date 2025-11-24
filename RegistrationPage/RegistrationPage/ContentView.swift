//
//  ContentView.swift
//  RegistrationPage
//
//  Created by Swapnil Magar on 23/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                emailField
                userNameField
                passwordField
                registerButton
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("Register")
        }
        
    }
    
    @ViewBuilder
    var userNameField: some View {
        VStack(alignment: .leading) {
            Text("User name")
                .font(.title3)
            TextField("Enter user name", text: $viewModel.userName)
                .textFieldStyle(.roundedBorder)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(usernameBorderColor, lineWidth: 1)
                }
        }
        .padding()
    }
    
    @ViewBuilder
    var emailField: some View {
        VStack(alignment: .leading) {
            Text("Email ID")
                .font(.title3)
            TextField("Enter Email ID", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(emailBorderColor, lineWidth: 1)
                }
        }
        .padding()
    }
    
    @ViewBuilder
    var passwordField: some View {
        VStack(alignment: .leading) {
            Text("Password")
                .font(.title3)
            SecureField("Enter password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(passwordBorderColor, lineWidth: 1)
                }
        }
        .padding()
    }
    
    @ViewBuilder
    var registerButton: some View {
        Button {
            // handle registration
        } label : {
            Text("Register")
                .font(.headline)
                .frame(width: 180, height: 30)
        }
        .disabled(!viewModel.allFieldsValid)
        .buttonStyle(.borderedProminent)
        .padding()
    }
    
    @ViewBuilder
    var userNameNotAvailableText: some View {
        Text("User name is not available")
            .foregroundColor(.red)
            .multilineTextAlignment(.leading)
    }
    
    var emailBorderColor: Color {
        if viewModel.email.isEmpty {
            return .gray
        }
        return viewModel.isEmailValid ? .green : .red
    }
    
    var passwordBorderColor: Color {
        if viewModel.password.isEmpty {
            return .gray
        }
        return viewModel.isPasswordValid ? .green : .red
    }
    
    var usernameBorderColor: Color {
        if viewModel.userName.isEmpty {
            return .gray
        }
        return viewModel.isUserNameAvailable ? .green : .red
    }
}

#Preview {
    ContentView()
}
