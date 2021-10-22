//
//  ShowProductViewController.swift
//  Product
//
//  Created by Brajpal Singh on 20/10/21.
//

import UIKit

class ShowProductViewController: UIViewController {

    var db:DBHelper = DBHelper()
    
    var products:[ProductModel] = []
    
    // MARK: - IBOutlets
    @IBOutlet weak var productTV: UITableView!
    
    // MARK: - View Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableCell()
        // Do any additional setup after loading the view.
    }
    
 override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     self.insertProducts()
     self.productTV.reloadData()
 }
    
    func insertProducts(){
        products = db.read()
    }
    
    // MARK: - Private Function
    
    fileprivate func registerTableCell() {
        self.productTV.registerMultiple(nibs: [ShowProductTVC.className])
    }
 
    // MARK: - Button Actions
    

}
