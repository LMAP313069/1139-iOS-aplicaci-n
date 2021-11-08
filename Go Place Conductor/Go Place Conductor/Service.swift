//
//  Service.swift
//  Go Place Conductor
//
//  Created by BigSur on 8/11/21.
//

import UIKit
import Firebase

class Service {
    
    static func signUpUser(nombre: String, apellido: String, telefono: String,email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let auth = Auth.auth()
        
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!)
                return
            }
            
            uploadToDatabase(nombre: nombre, apellido: apellido, telefono: telefono, email: email, onSuccess: onSuccess)
        }
    }
    
    static func uploadToDatabase(nombre: String, apellido: String, telefono: String,email: String, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        ref.child("usuarios").child(uid!).setValue(["nombre": nombre, "apellido": apellido, "telefono": telefono,"email" : email])
        onSuccess()
    }
    
    static func getUserInfo(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("usuario no encontrado")
            return
        }
        
        ref.child("usuarios").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let nombre = dictionary["nombre"] as! String
                let apellido = dictionary["apellido"] as! String
                let telefono = dictionary["telefono"] as! String
                let email = dictionary["email"] as! String
              
                defaults.set(nombre, forKey: "userNameKey")
                defaults.set(apellido, forKey: "userApellidoKey")
                defaults.set(telefono, forKey: "userTelefonoKey")
                defaults.set(email, forKey: "userEmailKey")
                
                
                onSuccess()
            }
        }) { (error) in
            onError(error)
        }
    }
    
    static func createAlertController(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        
        return alert
    }
}
