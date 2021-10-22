//
//  DBHelper.swift
//  Product
//
//  Created by BRAJPAL Chaudhary on 21/10/21.
//

import Foundation
import SQLite3
import UIKit

class DBHelper{
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    
    init() {
        self.db = createDb()
        self.createTable()
    }
    
    func createDb() -> OpaquePointer {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        print(fileURL)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return db!
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db!
        }
    }
    
 func createTable()  {
            let query = "CREATE TABLE IF NOT EXISTS product(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, description TEXT, rPrice INTEGER, sPrice INTEGER, imageUrl TEXT);"
            var statement : OpaquePointer? = nil
            
            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Table creation success")
                }else {
                    print("Table creation fail")
                }
            } else {
                print("Prepration fail")
            }
        }
    
    func insert(id:Int, name:String, description:String,regularPrice : Int, salePrice : Int,imageUrl : String)
    {
        let products = read()
        for p in products
        {
            if p.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO product (Id, name, description ,rPrice , sPrice , imageUrl) VALUES (NULL, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (description as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(regularPrice))
            sqlite3_bind_int(insertStatement, 4, Int32(salePrice))

            sqlite3_bind_text(insertStatement, 5, (imageUrl as NSString).utf8String, -1, nil)
            
//            let imageData = image.pngData()! as NSData
//            sqlite3_bind_blob(insertStatement, 5, [UInt8](imageData), -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [ProductModel] {
        let queryStatementString = "SELECT * FROM product;"
        var queryStatement: OpaquePointer? = nil
        var psns : [ProductModel] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                let regularPrice = sqlite3_column_int(queryStatement, 3)
                let salePrice = sqlite3_column_int(queryStatement, 4)
                
                let imageUrl = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
//                let lenght:Int = Int(sqlite3_column_bytes(queryStatement, 5));
//                let imgdata : NSData = NSData(bytes: sqlite3_column_blob(queryStatement, 0), length: lenght)
//
//                let decoded_img : UIImage = UIImage(data: imgdata as Data)!
                
                psns.append(ProductModel(id: Int(id), name: name, description: description, regularPrice: Int(regularPrice), salePrice: Int(salePrice), imageUrl: imageUrl))
                print("Query Result:")
                print("\(id) | \(name)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM product WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
     func update(id:Int, name:String, description:String,regularPrice : Int, salePrice : Int,imageUrl : String) {
            let query = "UPDATE product SET name = '\(name)', description = '\(description)', rPrice = \(regularPrice), sPrice = '\(salePrice)', imageUrl = '\(imageUrl)' WHERE id = \(id);"
            var statement : OpaquePointer? = nil
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data updated success")
                }else {
                    print("Data is not updated in table")
                }
            }
        }
    
}
