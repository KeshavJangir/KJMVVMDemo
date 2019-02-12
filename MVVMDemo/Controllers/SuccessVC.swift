//
//  SuccessVC.swift
//  MVVMDemo
//
//  Created by Malashukla on 11/02/19.
//  Copyright © 2019 KeshavJangir. All rights reserved.
//

import UIKit

class SuccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogoutTapped(_ sender: UIButton) {
        LoginService.logout {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
