//
//  Enum+StoryboardType.swift
//  Sorted
//
//  Created by Brajpal Singh Pro on 14/06/21.
//

import Foundation
import UIKit


enum StoryboardType: String {
    
    case LaunchScreen
    case Main
   
    var storyboardName: String {
        return rawValue
    }
}
