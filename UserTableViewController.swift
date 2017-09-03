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
    var user: DartUser!
    var ref: DatabaseReference!
    var accessToken: AccessTokenService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(fromURL: Constants.API.BaseUrl)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(_ animated: Bool) {
        <#code#>
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                return 4
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var listOfUserInfo: [Attribute] = []
        listOfUserInfo.append(Attribute(key: "Date of Birth", value: self.user.dateOfBirth!))
        listOfUserInfo.append(Attribute(key: "Residence", value: self.user.residence!))
        listOfUserInfo.append(Attribute(key: "Region", value: self.user.region!))
        listOfUserInfo.append(Attribute(key: "Phone Number", value: self.user.phoneNumber!))
        
        
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameAndImage", for: indexPath) as! NameAndPictureTableViewCell
            cell.nameLabel.text = user.name
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath)
            cell.textLabel?.text = listOfUserInfo[indexPath.row].key
            cell.detailTextLabel?.text = listOfUserInfo[indexPath.row].value
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Balance", for: indexPath)
            cell.textLabel?.text = String(describing: user.balance)
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Balance", for: indexPath)
            cell.textLabel?.text = user.email!
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath)
            cell.textLabel?.text = user.travelHistory[indexPath.row].station! + "-" + user.travelHistory[indexPath.row].destination!
            cell.detailTextLabel?.text = user.transactionHistory[indexPath.row].time
            
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath)
            cell.textLabel?.text = user.transactionHistory[indexPath.row].time
            cell.detailTextLabel?.text = user.transactionHistory[indexPath.row].phoneNumber
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath)
            cell.textLabel?.text = "Other"
            
            return cell
        }
            
        
            
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
