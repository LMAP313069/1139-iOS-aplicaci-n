//
//  RecoverViewController.swift
//  Go Place Cliente
//
//  Created by BigSur on 5/10/21.
//

import UIKit
import Firebase

class RecoverViewController: UIViewController {
    

    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func ressetPass(_ sender: Any) {
        
        
    }
    
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}
