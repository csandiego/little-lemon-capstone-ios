//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Christopher San Diego on 18/7/23.
//

import SwiftUI

let firstNameKey = "FIRST_NAME"
let lastNameKey = "LAST_NAME"
let emailKey = "EMAIL"
let isLoggedInKey = "IS_LOGGED_IN"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: firstNameKey)
                        UserDefaults.standard.set(lastName, forKey: lastNameKey)
                        UserDefaults.standard.set(email, forKey: emailKey)
                        UserDefaults.standard.set(true, forKey: isLoggedInKey)
                        isLoggedIn = true
                    }
                }
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: isLoggedInKey) == true {
                    isLoggedIn = true
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
