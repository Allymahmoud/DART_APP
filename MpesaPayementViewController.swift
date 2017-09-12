//
//  MpesaPayementViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class MpesaPayementViewController: UIViewController, RequestUserInfoDelegate, UpdateUserInfoServiceDelegate, UITextFieldDelegate{
    

    @IBOutlet weak var topMessage: UILabel!
    @IBOutlet weak var AmountSelected: UILabel!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var confirmationCode: UITextField!
    
    var requestUserInfo: RequestUserInfo!
    var updateUserInfoService: UpdateUserInfoService!
    var user: DartUser = DartUser(name:"", email: "", password: "")
    var amount: Double = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestUserInfo = RequestUserInfo()
        self.requestUserInfo.requestUserInfoDelegate = self
        
        self.updateUserInfoService = UpdateUserInfoService()
        self.updateUserInfoService.updateUserInfoServiceDelegate = self
        self.configureUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.requestUserInfo.requestUserInfo()
    }
    
    
    func configureUI(){
        self.topMessage.text = "Send M-PESA Tsh." + String(describing:self.amount) + " to Pay Bill Business number 222XXX. Submit the Confirmation Code below."
        self.AmountSelected.text = String(describing:self.amount)
        
        if let userPhoneNo = user.phoneNumber {
            if userPhoneNo.characters.count >= 9{
                self.phoneNumber.text = userPhoneNo.substring(from:userPhoneNo.index(userPhoneNo.endIndex, offsetBy: -9))
                
            }
            
            
        }

    }
    
    func didRecieveUserInfo(user: DartUser) {
        self.user = user
    }
    func failedToRecieveUserInfo(message: String) {
        self.present(AlertUtil.errorAlert(title: "Could Not Update User Info", message: message), animated: true, completion: nil)
    }
    
    func didSuccesfullyUpdateUserInfo() {
        print("successfuly updated balance and transaction")
        
        let alertVC = UIAlertController(title: "Success", message: "You have successfully added Tsh. \(self.amount)", preferredStyle: .alert)
        let alertActionOkay = UIAlertAction(title: "Dismiss", style: .default) {
            (_) in
            
           self.popBack(4)
        }
        alertVC.addAction(alertActionOkay)
        self.present(alertVC, animated: true, completion: nil)
    }
    func failedToUpdateUserInfo(message: String) {
        self.present(AlertUtil.errorAlert(title: "Ooops! Something Went Wrong", message: message), animated: true, completion: nil)
    }
    
    /// pop back n viewcontroller
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    

    @IBAction func completeTransaction(_ sender: Any) {
        if !phoneNumber.hasText && !confirmationCode.hasText{
            self.present(AlertUtil.errorAlert(title: "Could not complete transaction", message: "phone number field or confirmation code field cannot be empty"), animated: true, completion: nil)
        }
        else{
            if phoneNumber.text! == "757916904" && confirmationCode.text == "AllyMahmoud"{
                self.updateUserInfoService.updateUserBalance(balance: self.amount + self.user.balance!)
                let transaction = Transaction(agent: "Mpesa", phoneNumber: ("+255"+phoneNumber.text!), initialBalance: self.user.balance!, amountAdded: self.amount)
                self.updateUserInfoService.updateUserTransactionHistory(transaction: transaction)
                
            
            }
            else{
                self.present(AlertUtil.errorAlert(title: "Could Not Complete Transaction", message: "Phone number or confirmation code is invalid"), animated: true, completion: nil)
                
            }
                
        }
            
        
    }
    
    //function to dismiss the keyboard when done editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.phoneNumber.resignFirstResponder()
        return true
    }
    
    
    //function to dissmiss the keyboard when a part of the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Rather use the IQ Keyboard component
        self.view.endEditing(true)
    }
    
}
