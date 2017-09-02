//
//  EmailUtil.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/2/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import Foundation

struct EmailUtil {
    
    //method to verify the email's format [Regular Expression Magic]
    func isValidEmail(email:String) -> Bool {
        // TODO: Move into a ValidationUtil class as a static func
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
