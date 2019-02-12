//
//  UserViewModel.swift
//  MVVMDemo
//
//  Created by Malashukla on 11/02/19.
//  Copyright © 2019 KeshavJangir. All rights reserved.
//

import Foundation

enum UserValidationState {
    case valid
    case invalid(String)
}

class UserViewModel {
    private let minUsernameLength = 4
    private let minPasswordLength = 5
    private var user = User()
    
    var username: String {
        return user.username
    }
    
    var password: String {
        return user.password
    }
    var protectedUsername: String {
        let characters = username
        
        if characters.count >= minUsernameLength {
            var displayName = [Character]()
            for (index, character) in characters.enumerated() {
                if index > characters.count - minUsernameLength {
                    displayName.append(character)
                } else {
                    displayName.append("*")
                }
            }
            return String(displayName)
        }
        
        return username
    }
}

// MARK: Public Methods
extension UserViewModel {
    func updateUsername(_ username: String) {
        user.username = username
    }
    
    func updatePassword(_ password: String) {
        user.password = password
    }
    
    func validate() -> UserValidationState {
        if user.username.isEmpty || user.password.isEmpty {
            return .invalid("Username and password are required.")
        }
        
        if user.username.count < minUsernameLength {
            return .invalid("Username needs to be at least \(minUsernameLength) characters long.")
        }
        
        if user.password.count < minPasswordLength {
            return .invalid("Password needs to be at least \(minPasswordLength) characters long.")
        }
        return .valid
    }
    
    func login(_ completion: @escaping (_ errorString: String?) -> Void) {
        LoginService.loginWithUsername(user.username, password: user.password) { success in
            if success {
                completion(nil)
            } else {
                completion("Invalid credentials.")
            }
        }
    }
}
