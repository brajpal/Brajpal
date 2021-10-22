//
//  ViewControllers.swift
//  Sorted
//
//  Created by Brajpal Singh on 13/01/21.
//

import Foundation
import UIKit


class AllViewControllers: NSObject {
    
    private static let sharedOjbect = AllViewControllers()
    
    class func sharedInst() -> AllViewControllers {
        return sharedOjbect
    }
    
    //MARK: Method for get View Controller
    
    fileprivate func getViewControler(_ storyBoard: StoryboardType, indentifier: String) -> UIViewController {
        let storyB = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        return storyB.instantiateViewController(withIdentifier: indentifier)
    }
    
    func getShowProduct() -> ShowProductViewController {
        return self.getViewControler(.Main, indentifier: ShowProductViewController.className) as! ShowProductViewController
    }
 
    func getCreateProduct() -> CreateProductViewController {
        return self.getViewControler(.Main, indentifier: CreateProductViewController.className) as! CreateProductViewController
    }
    
}

extension UIViewController{
    func callAlertView(message:String) {
              let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
              let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alertController.addAction(defaultAction)
              self.present(alertController, animated: true, completion: nil)
    }
}
