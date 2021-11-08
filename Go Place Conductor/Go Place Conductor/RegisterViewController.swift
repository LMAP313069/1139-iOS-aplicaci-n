//
//  RegisterViewController.swift
//  Go Place Conductor
//
//  Created by BigSur on 4/10/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var anchorButtonScroll: NSLayoutConstraint!
    
    override func viewDidLoad() {
          super.viewDidLoad()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension RegisterViewController {
    
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}


extension RegisterViewController{
    private func registerKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func unregisterKeyboardNotification(){
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification){
     
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
     
     UIView.animate(withDuration: animationDuration) {
         
         self.anchorButtonScroll.constant = keyboardFrame.size.height
         self.view.layoutIfNeeded()
     }
    
    }
    
    @objc  func keyboardWillHide(_ notification: Notification){
     
     
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
     
     UIView.animate(withDuration: animationDuration) {
         self.anchorButtonScroll.constant = 0
         self.view.layoutIfNeeded()
     }
    
         
     }
    
    
}
