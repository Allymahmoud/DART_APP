//
//  LoginViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate, AccessTokenServiceDelegate, LoginServiceDelegate {
    
    

    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var accessTokenService: AccessTokenService!
    var loginService: LoginService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        

        // Do any additional setup after loading the view.
        accessTokenService = AccessTokenService()
        accessTokenService.accessTokenServiceDelegate = self
        
        loginService = LoginService()
        loginService.loginServiceDelegate = self
        accessTokenService.isTokenValid()
        //self.bgImage.addBlurEffect()
    }

    
    static func storyboardInstance() -> UINavigationController {
        let storyboard = UIStoryboard(name: String(describing: LoginViewController.self), bundle: nil)
        let loginViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        return loginViewController
    }

    func navTomain(){
        let mainViewController = MainViewController.storyboardInstance()
        self.present(mainViewController, animated: true, completion: nil)
        
    }
    
    func accessTokenIsValid() {
        navTomain()
        self.loadingIndicator.stopAnimating()
    }
    
    func accessTokenIsInvalid(message: String) {
        // Do nothing
        self.loadingIndicator.stopAnimating()
    }
    
    func didLoginSuccessfully(loggedInUser: DartUser) {
        print(loggedInUser.name!)
        self.loadingIndicator.stopAnimating()
        navTomain()
    }
    
    func emailNotVerified(user: Firebase.User) {
        let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(String(describing: self.email.text)).", preferredStyle: .alert)
        let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
            (_) in
            user.sendEmailVerification(completion: nil)
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertVC.addAction(alertActionOkay)
        alertVC.addAction(alertActionCancel)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    func failedToLogin(message: String) {
        print("failed to login")
        self.loadingIndicator.stopAnimating()
        
        // TODO: Displaying an error message to the user
        self.present(AlertUtil.errorAlert(title: "Could not login", message: message), animated: true, completion: nil)
        
    }

    
    @IBAction func login(_ sender: Any) {
        if !email.hasText || !password.hasText {
            self.present(AlertUtil.errorAlert(title: "Could Not Login", message: "Text fields cannot be empty"), animated: true, completion: nil)
        }
        else if !isValidEmail(email: self.email.text!){
            self.present(AlertUtil.errorAlert(title: "Could Not Login", message: "Incorrect email format"), animated: true, completion: nil)
        }

            
        else{
            self.loadingIndicator.startAnimating()
            let loginRequest = LoginRequest(email: self.email.text!, password: self.password.text!)
            loginService.login(loginRequest: loginRequest)
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        self.performSegue(withIdentifier: "navToSignUp", sender: nil)
    }
    
    @IBAction func passwordReset(_ sender: Any) {
    }
    
    
    //method to verify the email's format [Regular Expression Magic]
    func isValidEmail(email:String) -> Bool {
        // TODO: Move into a ValidationUtil class as a static func
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    //function to dismiss the keyboard when done editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.email.resignFirstResponder()
        return true
    }
    
    
    //function to dissmiss the keyboard when a part of the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Rather use the IQ Keyboard component
        self.view.endEditing(true)
    }

}
extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

