//
//  SignUpViewModel.swift
//  MVVMDemo
//
//  Created by Malashukla on 11/02/19.
//  Copyright © 2019 KeshavJangir. All rights reserved.
//

import UIKit

enum SignUpValidationState {
    case valid
    case invalid(String)
}

class SignUpViewModel {

    fileprivate let minPasswordLength = 5
    private var SignUp = SignUpModel()
    
    var userName: String {
        return SignUp.userName
    }
    var password: String {
        return SignUp.password
    }
    var fullName: String {
        return SignUp.fullName
    }
    var email: String {
        return SignUp.email
    }
    var location: String {
        return SignUp.location
    }
}

// MARK: Public Methods
extension SignUpViewModel {
    func updateUsername(_ username: String) {
        SignUp.userName = username
    }
    func updatePassword(_ password: String) {
        SignUp.password = password
    }
    func updateFullName(_ fullname: String) {
        SignUp.fullName = fullname
    }
    func updateEmail(_ email: String) {
        SignUp.email = email
    }
    func updateLocation(_ location: String) {
        SignUp.location = location
    }
    
    func validate() -> SignUpValidationState {
        if SignUp.userName.isEmpty || SignUp.password.isEmpty || SignUp.fullName.isEmpty || SignUp.email.isEmpty || SignUp.location.isEmpty {
            return .invalid("Please fill all fields")
        }
        
        if SignUp.password.count < minPasswordLength {
            return .invalid("Password needs to be at least \(minPasswordLength) characters long.")
        }
        return .valid
    }
    
    func register(_ completion: @escaping (_ errorString: String?) -> Void) {
        
        LoginService.registerUser(SignUp.userName, password: SignUp.password, fullname: SignUp.fullName, email: SignUp.email, location: SignUp.location) { (success) in
            if success {
                print(userName,password,fullName,email,location)
                completion(nil)
            } else {
                completion("Invalid Data")
            }
        }
    }
}
