//
//  Util.swift
//  SportsSpot
//
//  Created by AYA on 28/04/2024.
//

import Foundation
import UIKit

class Util{
    
    static func createAlert(alertTitle:String,alertMessage:String,btnTitle:String,handler:(()->Void)?)->UIAlertController{
        let alert = UIAlertController(title: alertTitle,message: alertMessage, preferredStyle: .alert)
        let okAtion = UIAlertAction(title: btnTitle, style: .default){ _ in
            handler?()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        okAtion.setValue(UIColor(red: 67/255, green: 74/255, blue: 249/255, alpha: 1.0), forKey: "titleTextColor")
        cancel.setValue(UIColor(red: 67/255, green: 74/255, blue: 249/255, alpha: 1.0), forKey: "titleTextColor")
        alert.addAction(okAtion)
        alert.addAction(cancel)
        return alert
    }
    static func createConnectionAlert()->UIAlertController{
        let alert = UIAlertController(title: "No Connection",message: "please check your connection!" , preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .default)
        okBtn.setValue(UIColor(red: 67/255, green: 74/255, blue: 249/255, alpha: 1.0), forKey: "titleTextColor")
        alert.addAction(okBtn)
        return alert
    }
}
