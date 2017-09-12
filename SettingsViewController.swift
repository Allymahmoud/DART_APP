//
//  SettingsViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 8/31/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, LogoutServiceDelegate {
    
    var accessTokenService: AccessTokenService = AccessTokenService()
    var logoutService: LogoutService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
        
        // Do any additional setup after loading the view.
        self.logoutService = LogoutService()
        self.logoutService.logoutServiceDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        self.logoutService.logout()
            
    }
    
    func didLogoutSuccessfully() {
        /*print("didsuccessfully logout")
        self.navTologin()
 */
        accessTokenService.deleteAccessToken()
        self.dismiss(animated: true, completion: nil)
    }
    func failedToLogout(message: String) {
        /*print("failed to logout")
        self.navTologin()
 */
        self.present(AlertUtil.errorAlert(title: "Could Not Logout", message: message), animated: true, completion: nil)
    }
    
    func navTologin(){
        let loginViewController = LoginViewController.storyboardInstance()
        self.present(loginViewController, animated: true, completion: nil)
        
    }


    

}
