//
//  CreateProductViewController.swift
//  Product
//
//  Created by Brajpal Singh on 20/10/21.
//

import UIKit

class CreateProductViewController: UIViewController {
     
    let db = DBHelper()
    var products = [ProductModel]()
    var selectIndex = Int()
    var imagePath : String = ""
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var productTV: UITableView!
    
    
    // MARK: - View Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableCell()
        // Do any additional setup after loading the view.
    }
       
    // MARK: - Private Function
    
    private func load(fileName: String) -> UIImage? {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
    fileprivate func registerTableCell() {
        self.productTV.registerMultiple(nibs: [ProductInfoCell.className])
    }
 
    // MARK: - Button Actions

    func addNewProduct(name : String,description : String,regularprice : String , salePrice : String){
        db.insert(id: 0, name: name, description: description, regularPrice: Int(regularprice)!, salePrice: Int(salePrice)!, imageUrl: imagePath)
        let showViewC = AllViewControllers.sharedInst().getShowProduct()
        self.navigationController?.pushViewController(showViewC, animated: true)
    }
    
    func updateProduct(name : String,description : String,regularprice : String , salePrice : String){
        let data = products[selectIndex]
        if let idStr = data.id {
            db.update(id: Int(idStr), name: name, description: description, regularPrice: Int(regularprice)!, salePrice: Int(salePrice)!, imageUrl: imagePath)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func deleteProduct() {
        let data = products[selectIndex]
        if let idStr = data.id {
            db.deleteByID(id: Int(idStr))
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}



