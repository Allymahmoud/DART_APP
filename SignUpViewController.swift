//
//  SignUpViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, SignUpServiceDelegate {
    
    var signUpService: SignUpService!
    
    var ref: DatabaseReference!
    var newUser: DartUser!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verifyPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)
        signUpService = SignUpService()
        signUpService.SignUpServiceDelegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func didSignUpSuccessfully() {
        self.navTologin()
    }
    func failedToSignUp(message: String) {
        self.present(AlertUtil.errorAlert(title: "Could Not SignUp", message: message), animated: true, completion: nil)
    }
    func somethingWentWrong(message: String) {
        self.present(AlertUtil.errorAlert(title: "Something Went Wrong", message: message), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUp(_ sender: Any) {
        if !name.hasText || !email.hasText || !password.hasText || !verifyPassword.hasText{
            self.present(AlertUtil.errorAlert(title: "Could Not SignUp", message: "No field can be empty"), animated: true, completion: nil)
            
        }
            
        else if !isValidEmail(email: self.email.text!){
            self.present(AlertUtil.errorAlert(title: "Could Not SignUp", message: "Incorrect email format"), animated: true, completion: nil)
        }
            
        else if (password.text?.characters.count)! < 4{
            self.present(AlertUtil.errorAlert(title: "Could Not SignUp", message: "password length must be greater than four"), animated: true, completion: nil)
        }
        else if password.text != verifyPassword.text{
            self.present(AlertUtil.errorAlert(title: "Could Not SignUp", message: "passwords must match"), animated: true, completion: nil)
            
        }
        else{
            let newUser = DartUser(name: name.text!, email: email.text!, password: password.text!)
            signUpService.signUp(newUser: newUser)
            
        }
    }
    
    func navTologin(){
        let loginViewController = LoginViewController.storyboardInstance()
        self.present(loginViewController, animated: true, completion: nil)
        
    }
    
    func isValidEmail(email:String) -> Bool {
        // TODO: Move into a ValidationUtil class as a static func
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    

}
