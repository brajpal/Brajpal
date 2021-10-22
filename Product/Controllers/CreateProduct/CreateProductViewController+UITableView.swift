//
//  CreateProductViewController+UITableView.swift
//  Product
//
//  Created by Brijesh Chaudhary on 21/10/21.
//

import UIKit

extension CreateProductViewController : UITableViewDataSource,ProductInfoDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let productTVC = tableView.dequeueReusableCell(withIdentifier: ProductInfoCell.className, for: indexPath) as! ProductInfoCell
         productTVC.delegate = self
        if products.count > 0 {
            self.imagePath = self.products[selectIndex].imageUrl!
            productTVC.setStaticData(data: self.products[selectIndex])
            productTVC.saveBtn.isHidden = true
        }
        else{
            productTVC.updateBtn.isHidden = true
            productTVC.deleteBtn.isHidden = true
        }
        productTVC.productNameTxt.delegate = self
        productTVC.descriptionTxt.delegate = self
        productTVC.regularPriceTxt.delegate = self
        productTVC.salePriceTxt.delegate = self
             
         return productTVC
    }
  
    func takePicture(){
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
                           
               actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                               self.camera()
                           }))
                           
               actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                               self.photoLibrary()
                           }))
                           
               actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                           
                self.present(actionSheet, animated: true, completion: nil)
    }
    
    func camera(){
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
               let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
           imagePicker.sourceType = UIImagePickerController.SourceType.camera;
               imagePicker.allowsEditing = false
               self.present(imagePicker, animated: true, completion: nil)
           }
           else{
               let alertController = UIAlertController(title: "Error!", message: "Camera not available!", preferredStyle: .alert)
               // Create the actions
           let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                   UIAlertAction in
               }
               alertController.addAction(okAction)
               self.present(alertController, animated: true, completion: nil)
           }
       }
     
     func photoLibrary(){
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                  let imagePicker = UIImagePickerController()
                  imagePicker.delegate = self
               imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                  imagePicker.allowsEditing = true
                  self.present(imagePicker, animated: true, completion: nil)
              }
        }
    
    internal func imagePickerController(_ picker: UIImagePickerController,
                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        let indexPath = IndexPath(item: 0, section: 0)
        guard let cell = self.productTV.cellForRow(at: indexPath) as? ProductInfoCell else { return }
        self.imagePath = self.save(image: unwrapImage)!
        cell.productImg.image = unwrapImage
        picker.dismiss(animated: true, completion: nil);
     }
    
    func alertMessage(msg : String){
        self.callAlertView(message: msg)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
     }
                     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
      }
    // MARK: - Private Function
    
    private func save(image: UIImage) -> String? {
        let fileName = self.randomString(length: 8)
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
           try? imageData.write(to: fileURL, options: .atomic)
           return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

extension CreateProductViewController: UITableViewDelegate {
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 600.0
   }
    
  
    
}

