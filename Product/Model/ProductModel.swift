//
//  ProductModel.swift
//  Product
//
//  Created by Brijesh Chaudhary on 21/10/21.
//

import Foundation
import UIKit

class ProductModel {
    var id : Int?
    var name : String?
    var description : String?
    var regularPrice : Int?
    var salePrice : Int?
    var imageUrl : String?
    
    init(id:Int, name:String,description:String,regularPrice:Int,salePrice:Int,imageUrl:String)
    {
        self.id = id
        self.name = name
        self.description = description
        self.regularPrice = regularPrice
        self.salePrice = salePrice
        self.imageUrl = imageUrl
    }
 
}
