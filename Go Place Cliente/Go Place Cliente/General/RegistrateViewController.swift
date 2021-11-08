//
//  RegistrateViewController.swift
//  Go Place Cliente
//
//  Created by BigSur on 5/10/21.
//

import UIKit
import Firebase
import FirebaseAuth


class RegistrateViewController: UIViewController{
    
    @IBOutlet var email: UITextField!
    @IBOutlet var nombre: UITextField!
    @IBOutlet var apellido: UITextField!
    @IBOutlet var telefono: UITextField!
    @IBOutlet var password: UITextField!
    

    @IBAction func registerUser(_ sender: Any) {
        
        
        
        let defaults = UserDefaults.standard
        
        Service.signUpUser(nombre: nombre.text!, apellido: apellido.text!, telefono: telefono.text!,email: email.text!, password: password.text!, onSuccess: {
            defaults.set(true, forKey: "isUserSignedIn")
            self.performSegue(withIdentifier: "userRegisterInSegue", sender: nil)
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var anchorBottomScroll: NSLayoutConstraint!
    
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
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

extension RegistrateViewController{
    
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
