//
//  SelectAmountViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class SelectAmountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var amountSelected: UITextField!
    var amount: Double = Double()
    var name: String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeMessage.text = "Welcome " + name

        // Do any additional setup after loading the view.
    }

    @IBAction func proceed(_ sender: Any) {
        if !amountSelected.hasText{
            
            self.present(AlertUtil.errorAlert(title: "Could Not Proceed", message: "Amount field cannot be empty. Please enter any amount from 2000 Tshs to 50,000 Tshs"), animated: true, completion: nil)
        }
        else{
            if let convertedAmount = Double(self.amountSelected.text!){
                self.amount = convertedAmount
                self.performSegue(withIdentifier: "navToMpesa", sender: nil)
            }
            else{
                self.present(AlertUtil.errorAlert(title: "Could Not Proceed", message: "Invalid amount entered"), animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass token
        //temporary implementation to pass the title
        let mpesaVC = segue.destination as! MpesaPayementViewController
        mpesaVC.title = "Pay with Mpesa"
        mpesaVC.amount = self.amount
    
    }
    //function to dismiss the keyboard when done editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.amountSelected.resignFirstResponder()
        return true
    }
    
    
    //function to dissmiss the keyboard when a part of the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Rather use the IQ Keyboard component
        self.view.endEditing(true)
    }
}
