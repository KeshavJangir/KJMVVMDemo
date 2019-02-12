//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Malashukla on 11/02/19.
//  Copyright © 2019 KeshavJangir. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtFieldUN: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    private let minUserNameLenght = 4
    private let minPasswordLenght = 5
    
    fileprivate var viewModel = UserViewModel()
   // var loginSuccess: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        switch viewModel.validate() {
        case .valid:
            viewModel.login() { errorMessage in
                if let errorMessage = errorMessage {
                    self.displayErrorMessage(errorMessage)
                } else {
                   // self.loginSuccess?()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        case .invalid(let error):
            displayErrorMessage(error)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFieldUN {
            textField.text = viewModel.username
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtFieldUN {
            textField.text = viewModel.protectedUsername
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFieldUN {
            txtFieldPassword.becomeFirstResponder()
        } else {
           // authenticate()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == txtFieldUN {
            viewModel.updateUsername(newString)
        } else if textField == txtFieldPassword {
            viewModel.updatePassword(newString)
        }
        return true
    }
    
}

// MARK: Private Methods
private extension ViewController {
    func displayErrorMessage(_ errorMessage: String) {
        let alertController = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
