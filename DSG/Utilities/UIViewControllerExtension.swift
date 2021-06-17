//
//  UIViewControllerExtension.swift
//  DSG
//
//  Created by Prateek Juneja on 17/06/21.
//

import UIKit
import MBProgressHUD

extension UIViewController {
   func showIndicator(withTitle title: String, and description:String) {
    DispatchQueue.main.async {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = title
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = description
        Indicator.show(animated: true)
      }
   }
    
   func hideIndicator() {
    DispatchQueue.main.async {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
   }

}
