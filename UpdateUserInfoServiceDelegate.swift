//
//  UpdateUserInfoServiceDelegate.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

protocol UpdateUserInfoServiceDelegate {
    func didSuccesfullyUpdateUserInfo()
    func failedToUpdateUserInfo(message: String)
}
