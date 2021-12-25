//
//  ViewController.swift
//  RV_CoreData
//
//  Created by Maha saad on 20/05/1443 AH.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var personNames : [Names] = []
  
    
 
    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let save = (UIApplication.shared.delegate as! AppDelegate).saveContext

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("show alert", for: .normal)
        button.center = view.center
        button.setTitleColor(.white, for: .normal)
        button.addTarget(save, action: #selector(showAlert), for: .touchUpInside)

    }
    
    @objc private func showAlert(){
        let alert = UIAlertController(title: "SING IN ", message: "PLEASE SIN IN ", preferredStyle: .alert)
        alert.addTextField { Field in
            Field.placeholder = "Email Address"
            Field.returnKeyType = .next
            Field.keyboardType = .emailAddress
            
        }
        alert.addTextField { Field in
            Field.placeholder = "Password"
            Field.returnKeyType = .continue
            Field.isSecureTextEntry = true
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 2 else {return}
            let emailField = fields[0]
            let passwordFiel = fields[1]
            
            guard let email = emailField.text, !email.isEmpty,
                  let password = passwordFiel.text , !password.isEmpty
            else {
                print("INVEILDE")
                return
            }
            
            print("YOUR EMAIL :  \(email)" )
            print("YOUR PASSWORD :\(password) ")

           
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func saveData (){
        let newThing = Names(context: content)
        newThing.name = "value3"
        save()
    }
  

    func fetchData(){
        let requst:NSFetchRequest<Names> = Names.fetchRequest()
        do{
            personNames = try content.fetch(requst)
            
        }catch{
            print(error)
        }
 
        
    }
    
  

}

