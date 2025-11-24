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
                if !viewModel.isUserNameAvailable {
                    userNameNotAvailableText
                }
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
        }
        .padding()
    }
    
    @ViewBuilder
    var passwordField: some View {
        VStack(alignment: .leading) {
            Text("Password")
                .font(.title3)
            TextField("Enter password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
    
    @ViewBuilder
    var registerButton: some View {
        Button {
            
        } label : {
            Text("Register")
                .font(.headline)
                .frame(width: 180, height: 30)
        }
        .disabled(viewModel.allFieldsValid == false)
        .buttonStyle(.glassProminent)
    }
    
    @ViewBuilder
    var userNameNotAvailableText: some View {
        Text("User name is not available")
            .foregroundColor(.red)
            .multilineTextAlignment(.leading)
    }
}

#Preview {
    ContentView()
}
