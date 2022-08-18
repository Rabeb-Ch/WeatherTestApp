//
//  UIViewController + Extension.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 17/08/2022.
//

import Foundation
import UIKit


extension UIViewController {
    public func showAlertWith(msg:String){
        
        let alertController = UIAlertController(title: K.Titles.alertTitle, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: K.Titles.okBtnTitle, style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
