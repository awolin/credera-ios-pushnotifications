//
//  AppDelegate.swift
//  PushNotificationSpike
//
//  Created by Aaron Wolin on 11/10/15.
//  Copyright © 2015 Credera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        /*
        * Push notifications
        */
        
        let userNotificationTypes: UIUserNotificationType = [.Badge, .Alert, .Sound]
        let notificationSettings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    // MARK: - Push notifications
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        // Perform an action in-app when a notification is received
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
        
        // Check if the user has disabled opt in via notifications, and if they have already registered a device token
        // If so, send the opt out flag
        let optInSettings = PushRegistrationService.sharedInstance.isUserOptionedIn(application)
        if !optInSettings {
            let deviceTokenString: String? = NSUserDefaults.standardUserDefaults().stringForKey("PushDeviceTokenString")
            
            if deviceTokenString != nil {
                let accountId: String? = NSUserDefaults.standardUserDefaults().stringForKey("AccountId")
                
                PushRegistrationService.sharedInstance.registerDevice(deviceTokenString!, optIn: false, accountId: accountId)
            }
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // We will only be here if the user has not manually disabled notifications and the device successfully registers
        let deviceTokenString = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"))
        
        NSUserDefaults.standardUserDefaults().setValue(deviceTokenString, forKey:"PushDeviceTokenString")
        NSUserDefaults.standardUserDefaults().synchronize();
        
        // Copy the device ID to the clipboard and show an alert. Useful for debugging
        copyUIDToClipboard(deviceTokenString)
        
        let accountId: String? = NSUserDefaults.standardUserDefaults().stringForKey("AccountId")
        
        PushRegistrationService.sharedInstance.registerDevice(deviceTokenString, optIn: true, accountId: accountId)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("Error registering push notification: %@", error.description)
    }
    
    private func copyUIDToClipboard(uid: String) {
        
        // Copy the UID to the clipboard
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.string = uid
        
        AlertUtility.showAlert("Push Notification Device ID", message: String(format: "\"%@\" copied to clipboard", uid), forViewController: self.window?.rootViewController)
    }

}

