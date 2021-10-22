//
//  ShowProductViewController+UITableView.swift
//  Product
//
//  Created by Brajpal Singh on 20/10/21.
//

import UIKit

extension ShowProductViewController : UITableViewDataSource,showProductDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let showProductTVC = tableView.dequeueReusableCell(withIdentifier: ShowProductTVC.className, for: indexPath) as! ShowProductTVC
        showProductTVC.setStaticData(data: products[indexPath.row])
        showProductTVC.delegate = self
         return showProductTVC
    }
  
    func showImageOnFullScreen(image : UIImage){
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
 
}

extension ShowProductViewController: UITableViewDelegate {
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createViewC = AllViewControllers.sharedInst().getCreateProduct()
        createViewC.products = self.products
        createViewC.selectIndex = indexPath.row
        self.navigationController?.pushViewController(createViewC, animated: true)
    }
    
}
