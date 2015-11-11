//
//  PushRegistrationService.swift
//  PushNotificationSpike
//
//  Created by Aaron Wolin on 11/10/15.
//  Copyright © 2015 Credera. All rights reserved.
//

import Foundation
import UIKit

class PushRegistrationService {
    
    var deviceToken: String?
    var pushOptIn: Bool
    
    
    class var sharedInstance: PushRegistrationService {
        struct Singleton {
            static let instance = PushRegistrationService()
        }
        
        return Singleton.instance
    }
    
    init() {
        self.deviceToken = nil
        self.pushOptIn = true
    }
    
    func isUserOptionedIn(application: UIApplication) -> Bool {
        var optIn = true;
        
        if NSUserDefaults.standardUserDefaults().boolForKey("PushOptIn") {
            // Existing optIn key detected, try to get current optIn via preferences
            optIn = application.isRegisteredForRemoteNotifications()
        }
        else
        {
            // No key saved; first time launching so optIn during push registration
            optIn = true
        }
        
        NSUserDefaults.standardUserDefaults().setBool(optIn, forKey:"PushOptIn")
        NSUserDefaults.standardUserDefaults().synchronize();
        
        return optIn
    }
    
    func registerDevice(deviceTokenString: String, optIn: Bool, accountId : String?) {
        self.deviceToken = deviceTokenString
        self.pushOptIn = optIn
        
        NSUserDefaults.standardUserDefaults().setBool(optIn, forKey:"PushOptIn")
        NSUserDefaults.standardUserDefaults().synchronize();
        
        var params: Dictionary<String, AnyObject> = [
            "deviceUniqueId": deviceTokenString,
            "deviceType": "iOS"]
        
        if accountId != nil {
            params.updateValue(accountId!, forKey: "AccountId")
        }
        
        print(deviceTokenString)
        
        // Register the device with a 3rd party service
    }
    
    func registerExistingDeviceWithAccountId(accountId: String?) {
        if deviceToken != nil && accountId != nil {
            self.registerDevice(self.deviceToken!, optIn: self.pushOptIn, accountId: accountId)
        }
    }
}