//
//  HomeViewController.swift
//  Go Place Conductor
//
//  Created by BigSur on 8/11/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet  var welcomeInLabel: UILabel!
    @IBOutlet  var cerrarSesion: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        Service.getUserInfo(onSuccess: {
            self.welcomeInLabel.text = "Bienvenido \(defaults.string(forKey: "userNameKey")!)"
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
    }
   
    
    @IBAction func cerrarSesionUser(_ sender: Any) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError {
            self.present(Service.createAlertController(title: "Error", message: signOutError.localizedDescription), animated: true, completion: nil)
        }
    }
}
