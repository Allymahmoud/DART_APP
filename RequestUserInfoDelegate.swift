//
//  RequestUserInfoDelegate.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

protocol RequestUserInfoDelegate {
    func didRecieveUserInfo(user: DartUser)
    func failedToRecieveUserInfo(message: String)
}
