//
//  ShowProductTVC.swift
//  Product
//
//  Created by Brajpal Singh on 21/10/21.
//

import UIKit

protocol showProductDelegate: AnyObject {
    func showImageOnFullScreen(image : UIImage)
}

class ShowProductTVC: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var salePriceLbl: UILabel!
    
    weak var delegate: showProductDelegate?
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
           tapGR.delegate = self
        tapGR.numberOfTapsRequired = 1
        productImg?.addGestureRecognizer(tapGR)
    }
    
    @objc func imageTapped(_ gesture: UITapGestureRecognizer)
    {
        let imageView = gesture.view as! UIImageView
        guard let ddelegate = delegate else { return }
        ddelegate.showImageOnFullScreen(image : imageView.image!)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setStaticData(data : ProductModel){
        productNameLbl.text = data.name
     
        if let price = data.salePrice {
            salePriceLbl.text = String(format: "%@ " + "%@", "\u{20B9}", "\(String(describing: price))")
        }
        
        if let url = data.imageUrl {
            DispatchQueue.main.async {
                self.productImg.image = self.load(fileName: url)
            }
        }
        
        productImg.layer.masksToBounds = true
        productImg.layer.borderWidth = 1.5
        productImg.layer.borderColor = UIColor.black.cgColor
        
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
    
}
