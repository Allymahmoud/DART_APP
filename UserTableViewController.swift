//
//  UserTableViewController.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/3/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit
import Firebase

class Attribute{
    var key: String?
    var value: String?
    
    init (key: String, value: String){
        self.key = key
        self.value = value
    }
    
}
enum Section: Int {
    case BasicInfo = 0
    case MainInfo
    case Balance
    case Email
    case TravelHistory
    case TransactionHistory
    
}

class UserTableViewController: UITableViewController {
    var user: DartUser = DartUser(name: "", email: "", password: "")
    var ref: DatabaseReference!
    var accessToken: AccessTokenService!
    var selectedTicket: TripInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)
        navigationItem.title = "My Account"
        


    }
    override func viewDidAppear(_ animated: Bool) {
        self.updateUserInfo()
    }
    
    
    func updateUserInfo(){
        if let user = Auth.auth().currentUser {
            self.ref.child("DARTusers").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                // Get user value
                let value = snapshot.value as? NSDictionary
                if value != nil {
                    self.user = DartUser.init(dictionary: value as! [String : AnyObject])
                    self.tableView.reloadData()
   
                }
                else{
                    print("value found nil")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }

        }
   
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let currentSection: Section = Section(rawValue: section) {
            switch currentSection {
            case .BasicInfo:
                return 1
            case .MainInfo:
                return 5
            case .Balance:
                return 1
            case .Email:
                return 1
            case .TravelHistory:
                return self.user.travelHistory.count
            case .TransactionHistory:
                return self.user.transactionHistory.count
            }
        } else {
            return 0
        }
    }
    
    //method to segue to a supplier controller upon selection of a supplier cell
    override  func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
        
        switch (indexPath.section) {
        case 0:
            print("0")
            
        case 1:
            print("1")
        case 2:
            self.performSegue(withIdentifier: "navToPaymentOptions", sender: nil)
        case 3:
            print("3")
        case 4:
            print("4")
            self.selectedTicket = self.user.travelHistory[indexPath.row]
            self.performSegue(withIdentifier: "navToTicket", sender: nil)
        case 5:
            print("5")
        default:
            print("none")
            
        }
     
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass token
        if segue.identifier == "navToTicket" {
            
            //temporary implementation to pass the title
            let ticketDisplayViewController = segue.destination as! TicketDisplayViewController
            ticketDisplayViewController.title = "Ticket Info"
            ticketDisplayViewController.tripInfo = self.selectedTicket
            ticketDisplayViewController.clientName = user.name!

            
        }

        
    }



    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var listOfUserInfo: [Attribute] = []
        listOfUserInfo.append(Attribute(key: "Date of Birth", value: self.user.dateOfBirth!))
        listOfUserInfo.append(Attribute(key: "Residence", value: self.user.residence!))
        listOfUserInfo.append(Attribute(key: "Region", value: self.user.region!))
        listOfUserInfo.append(Attribute(key: "Phone Number", value: self.user.phoneNumber!))
        listOfUserInfo.append(Attribute(key: "Country of Origin", value: self.user.countryOfOrigin!))
        
        
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameAndImage", for: indexPath) as! NameAndPictureTableViewCell
            cell.nameLabel.text = user.name
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.textLabel!.font = UIFont(name: "Helvetica", size: 13)!
            cell.detailTextLabel!.font = UIFont(name: "Helvetica", size: 13)!
            
            cell.textLabel?.text = listOfUserInfo[indexPath.row].key
            cell.detailTextLabel?.text = listOfUserInfo[indexPath.row].value
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Balance", for: indexPath)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.textLabel!.font = UIFont(name: "Helvetica", size: 13)!
            if let balance = user.balance{
                cell.textLabel?.text = String(describing: balance) + " " + "Tshs"
                
            }
            
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Balance", for: indexPath)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.textLabel!.font = UIFont(name: "Helvetica", size: 13)!
            
            cell.textLabel?.text = user.email!
            
            return cell
        case 4:
            user.travelHistory.sort { TimeUtil.returnDate(stringDate: $0.validFrom!)  > TimeUtil.returnDate(stringDate: $1.validFrom!) }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath)
            cell.textLabel!.font = UIFont(name: "Helvetica", size: 13)!
            cell.detailTextLabel!.font = UIFont(name: "Helvetica", size: 13)!
            
            cell.textLabel?.text = user.travelHistory[indexPath.row].station! + "-" + user.travelHistory[indexPath.row].destination!
            cell.detailTextLabel?.text = user.travelHistory[indexPath.row].validFrom
            
            if TimeUtil.isValidTicket(oldDateString: user.travelHistory[indexPath.row].validFrom!, timeToLive: user.travelHistory[indexPath.row].ttl!){
                cell.accessoryType = UITableViewCellAccessoryType.detailButton
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            
            return cell
            
        case 5:
            user.transactionHistory.sort { TimeUtil.returnDate(stringDate: $0.time!)  > TimeUtil.returnDate(stringDate: $1.time!) }
            /*
            if user.transactionHistory.count > 5{
                print("no of transaction before \(user.transactionHistory.count)")
                let noOfelements = user.transactionHistory.count
                user.transactionHistory.removeSubrange(5..<noOfelements)
                
            }
            print("no of transaction after \(user.transactionHistory.count)")
            */
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.textLabel!.font = UIFont(name: "Helvetica", size: 13)!
            cell.detailTextLabel!.font = UIFont(name: "Helvetica", size: 13)!
            
            if let amountAdded = user.transactionHistory[indexPath.row].amountAdded{
                cell.textLabel?.text = "Tsh. \(amountAdded)"
                cell.detailTextLabel?.text = user.transactionHistory[indexPath.row].time!
                
            }
            
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath)
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
            return "Basic Info"
        case 1:
            return "Main info"
        case 2:
            return "Balance"
        case 3:
            return "Email"
        case 4:
            return "Travel History"
        case 5:
            return "Transaction History"
            
        default:
            return "Other Section"
        }

    }
    
    
    //method to adjust the rows' heights
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        if (indexPath as NSIndexPath).section == Section.BasicInfo.rawValue{
            height = 108
            
        }
        else{
            height = 45
            
        }
        return height
        
    }
    
 
    

}
