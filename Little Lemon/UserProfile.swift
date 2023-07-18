//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Christopher San Diego on 18/7/23.
//

import SwiftUI

struct UserProfile: View {
    var firstName = UserDefaults.standard.string(forKey: firstNameKey) ?? ""
    var lastName = UserDefaults.standard.string(forKey: lastNameKey) ?? ""
    var email = UserDefaults.standard.string(forKey: emailKey) ?? ""
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: isLoggedInKey)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
