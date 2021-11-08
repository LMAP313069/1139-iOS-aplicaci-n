//
//  LoginViewController.swift
//  Go Place Cliente
//
//  Created by BigSur on 4/10/21.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var iniciarSesionBoton: UIButton!
    @IBOutlet var registrateBoton: UIButton!
    
    @IBAction func iniciarSesion(_ sender: Any) {
        
        
    
        let auth = Auth.auth()
        let defaults = UserDefaults.standard
        
        auth.signIn(withEmail: email.text!, password: password.text!) { (authResult, error) in
            if error != nil {
                self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
                return
            }
            
            defaults.set(true, forKey: "isUserSignedIn")
            self.performSegue(withIdentifier: "userSesionInSegue", sender: nil)
        }
        
    }
    
    
    @IBAction func recoverPass(_ sender: Any) {
        self.performSegue(withIdentifier: "forgotPassSegue", sender: nil)
    }
    
    
    @IBOutlet weak var anchorBottomScroll: NSLayoutConstraint!
    @IBAction func tapTocloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
           //Este se ejecuta una unica vez, es como el oncreate del controller
           super.viewDidLoad()
       }
       
       //Se ejecutan por varias veces
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.registrerKeyboardEvents()
       }
       
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.unregisterKeyboardEvents()
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
       }
    
 
}

extension LoginViewController{
    
    private func registrerKeyboardEvents() {
          
          NotificationCenter.default.addObserver(self,
                                                 selector: #selector(self.keyboardWillShow(_:)),
                                                 name: UIResponder.keyboardWillShowNotification,
                                                 object: nil)
          
          NotificationCenter.default.addObserver(self,
                                                 selector: #selector(self.keyboardWillHide(_:)),
                                                 name: UIResponder.keyboardWillHideNotification,
                                                 object: nil)
      }
      
      private func unregisterKeyboardEvents() {
          
          NotificationCenter.default.removeObserver(self)
      }
      
      @objc func keyboardWillShow(_ notification: Notification) {
          
          let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
          let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
          
          UIView.animate(withDuration: animationDuration) {
              self.anchorBottomScroll.constant = keyboardFrame.size.height
              self.view.layoutIfNeeded()
          }
      }
      
      @objc func keyboardWillHide(_ notification: Notification) {
          
          let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
          
          UIView.animate(withDuration: animationDuration) {
              self.anchorBottomScroll.constant = 0
              self.view.layoutIfNeeded()
          }
      }
    
}

