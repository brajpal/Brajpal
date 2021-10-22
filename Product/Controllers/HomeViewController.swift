//
//  HomeViewController.swift
//  Product
//
//  Created by Brajpal Singh on 20/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var showProductBtn: UIButton!
    @IBOutlet weak var createProductBtn: UIButton!
   
    // MARK: - View Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   

    // MARK: - Button Actions
    
 @IBAction func didTappedShowProductBtn( _sender : UIButton){
     let showViewC = AllViewControllers.sharedInst().getShowProduct()
     self.navigationController?.pushViewController(showViewC, animated: true)
 }
    
 @IBAction func didTappedCreateProductBtn( _sender : UIButton){
     let createViewC = AllViewControllers.sharedInst().getCreateProduct()
     self.navigationController?.pushViewController(createViewC, animated: true)
 }

    
}
