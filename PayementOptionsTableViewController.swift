//
//  PayementOptionsTableViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

enum PaymentSection: Int {
    case Balance = 0
    case RechargeOptions
}

class PayementOptionsTableViewController: UITableViewController, RequestUserInfoDelegate{
    
    var user: DartUser = DartUser(name: "", email: "", password: "")
    var requestUserInfo: RequestUserInfo!
    var paymentOptionsList = ["Mpesa", "Tigo Pesa", "Airtel Money", "Halotel Pesa", "TTCL Pesa", "Credit or Debit Card", "MaxMalipo"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        requestUserInfo = RequestUserInfo()
        requestUserInfo.requestUserInfoDelegate = self

      
    }
    override func viewDidAppear(_ animated: Bool) {
        self.requestUserInfo.requestUserInfo()
    }

   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let currentSection: PaymentSection = PaymentSection(rawValue: section) {
            switch currentSection {
            case .Balance:
                return 1
            case .RechargeOptions:
                return self.paymentOptionsList.count
            }
        } else {
            return 0
        }
    }
    func didRecieveUserInfo(user: DartUser) {
        self.user = user
        tableView.reloadData()
    }
    func failedToRecieveUserInfo(message: String) {
        self.present(AlertUtil.errorAlert(title: "Could Not Fetch User Info", message: message), animated: true, completion: nil)
    }
    
    //method to segue to a supplier controller upon selection of a supplier cell
    override  func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
        
        switch (indexPath.section) {
        case 0:
            print("0")
        case 1:
            print("1")
            
            self.performSegue(withIdentifier: "navToAmount", sender: nil)
            
        default:
            print("none")
            
        }
        
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "balance", for: indexPath)
            if let balance = user.balance{
                cell.textLabel?.text = String(describing: balance) + " Tshs"
                
            }
            
            return cell
            
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "payementOption", for: indexPath)
            as! PaymentOptionTableViewCell
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            //cell.textLabel!.font = UIFont(name: "Helvetica", size: 13)!
            
            cell.optionImage.image = UIImage(named: self.paymentOptionsList[indexPath.row]+".png")
            cell.optionName.text = self.paymentOptionsList[indexPath.row]
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "balance", for: indexPath)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.textLabel!.font = UIFont(name: "Helvetica", size: 13)!
            
            cell.textLabel?.text = "Other"
            
            return cell
        }
        
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0:
            return "Balance"
        case 1:
            return "Recharge Options"
            
        default:
            return "Other Section"
        }
        
    }
    
    //method to adjust the rows' heights
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        if (indexPath as NSIndexPath).section == PaymentSection.Balance.rawValue{
            height = 60
            
        }
        else{
            height = 50
            
        }
        return height
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navToAmount" {
            
            //temporary implementation to pass the title
            let selectAmountVC = segue.destination as! SelectAmountViewController
            selectAmountVC.title = "Select Amount"
            selectAmountVC.name =  self.user.name!
            
            
            
        }
    }

    
}
