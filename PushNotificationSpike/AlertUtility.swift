//
//  AlertUtility.swift
//  Chilis
//
//  Created by Aaron Wolin on 11/10/15.
//  Copyright (c) 2015 Credera. All rights reserved.
//

import Foundation
import UIKit

class AlertUtility {
    
    class func showAlert(title: String?, message: String?, forViewController viewController: UIViewController?) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            viewController?.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    class func showAlertWithAction(title: String?, message: String?, actionTitle: String, action: (UIAlertAction!) -> Void, forViewController viewController: UIViewController?) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: action))
            viewController?.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    class func showAlertYesNo(title: String?, message: String?, actionTitle: String, action: (UIAlertAction!) -> Void, forViewController viewController: UIViewController?, withDelegate delegate: UIAlertViewDelegate) {
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: action))
            viewController?.presentViewController(alert, animated: true, completion: nil)
        })
    }
}