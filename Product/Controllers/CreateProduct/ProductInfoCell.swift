//
//  ProductInfoCell.swift
//  Product
//
//  Created by Brijesh Chaudhary on 21/10/21.
//

import UIKit

protocol ProductInfoDelegate: AnyObject {
    func takePicture()
    func addNewProduct(name : String,description : String,regularprice : String , salePrice : String)
    func updateProduct(name : String,description : String,regularprice : String , salePrice : String)
    func deleteProduct()
    func alertMessage(msg : String)
}

class ProductInfoCell: UITableViewCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productNameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var regularPriceTxt: UITextField!
    @IBOutlet weak var salePriceTxt: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    
    weak var delegate: ProductInfoDelegate?
    public var pImage: UIImage? = nil
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        productImg?.isUserInteractionEnabled = true
        productImg?.addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        productImg.layer.masksToBounds = true
        productImg.layer.borderWidth = 1.5
        productImg.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        guard let ddelegate = delegate else { return }
        ddelegate.takePicture()
    }
    
  func setStaticData(data : ProductModel){
      if let price = data.salePrice {
          salePriceTxt.text = "\(String(describing: price))"
      }
      
      if let price = data.regularPrice {
          regularPriceTxt.text = "\(String(describing: price))"
      }
      
      if let description = data.description {
          descriptionTxt.text = description
      }
      
      if let name = data.name {
          productNameTxt.text = name
      }
    
      if let url = data.imageUrl {
          productImg.image = self.load(fileName: url)
      }
      
  }
    
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
    
    // MARK: - Button Actions
    
    @IBAction func didTappedAddProductBtn( _sender : UIButton){
        guard let ddelegate = delegate else { return }
    
        if (self.productImg.image == nil){
            ddelegate.alertMessage(msg: "Please take a Product picture first")
        }
        else if self.productNameTxt?.text == ""
        {
            ddelegate.alertMessage(msg: "Please enter Product name first")
         }
        else if self.descriptionTxt?.text == ""
        {
            ddelegate.alertMessage(msg: "Please enter Product description first")
         }
        else if self.regularPriceTxt?.text == ""
        {
            ddelegate.alertMessage(msg: "Please enter Product Regular price first")
         }
        else if self.salePriceTxt?.text == ""
        {
            ddelegate.alertMessage(msg: "Please enter Product Sale price first")
         }
        else {
         ddelegate.addNewProduct(name: self.productNameTxt.text!, description: self.descriptionTxt.text!, regularprice: self.regularPriceTxt.text!, salePrice: self.salePriceTxt.text!)
        }
    }
    
    @IBAction func didTappedupdateProductBtn( _sender : UIButton){
        guard let ddelegate = delegate else { return }
    
        if (self.productImg.image == nil){
            ddelegate.alertMessage(msg: "Please take a Product picture first")
        }
        else if self.productNameTxt?.text == ""
        {
            ddelegate.alertMessage(msg: "Please enter Product name first")
         }
        else if self.descriptionTxt?.text == ""
        {
            ddelegate.alertMessage(msg: "Please enter Product description first")
         }
        else if self.regularPriceTxt?.text == ""
        {
            ddelegate.alertMessage(msg: "Please enter Product regular price first")
         }
        else if self.salePriceTxt?.text == ""
        {
            ddelegate.alertMessage(msg: "Please enter Product Sale price first")
         }
        else {
        ddelegate.updateProduct(name: self.productNameTxt.text!, description: self.descriptionTxt.text!, regularprice: self.regularPriceTxt.text!, salePrice: self.salePriceTxt.text!)
        }
    }
    
    @IBAction func didTappedDeleteProductBtn( _sender : UIButton){
        guard let ddelegate = delegate else { return }
        ddelegate.deleteProduct()
    }
    
}
