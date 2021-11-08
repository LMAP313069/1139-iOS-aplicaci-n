//
//  RecuperarPassViewController.swift
//  Go Place Cliente
//
//  Created by BigSur on 8/11/21.
//

import UIKit
import Firebase

class RecuperarPassViewController: UIViewController {
    
    
    @IBOutlet weak var RecuperarEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func enviarPass(_ sender: Any) {
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: RecuperarEmail.text!) { (error) in
            if let error = error {
                let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let alert = Service.createAlertController(title: "Mensaje", message: "Se ha enviado un correo electrónico para restablecer la contraseña!")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
