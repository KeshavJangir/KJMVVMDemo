//
//  SignUpVC.swift
//  MVVMDemo
//
//  Created by Malashukla on 11/02/19.
//  Copyright © 2019 KeshavJangir. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldFullName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldLocation: UITextField!
    
    private let minPasswordLenght = 5
    fileprivate var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        switch viewModel.validate() {
        case .valid:
            viewModel.register() { errorMessage in
                if let errorMessage = errorMessage {
                    self.displayErrorMessage(errorMessage)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        case .invalid(let error):
            displayErrorMessage(error)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == txtFieldUsername {
            viewModel.updateUsername(newString)
        } else if textField == txtFieldPassword {
            viewModel.updatePassword(newString)
        }else if textField == txtFieldFullName {
            viewModel.updateFullName(newString)
        }else if textField == txtFieldEmail {
            viewModel.updateEmail(newString)
        }else if textField == txtFieldLocation {
            viewModel.updateLocation(newString)
        }
        return true
    }

}


// MARK: Private Methods
private extension SignUpVC {
    func displayErrorMessage(_ errorMessage: String) {
        let alertController = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
