//
//  WishModel.swift
//  Wishlist
//
//  Created by Nicola Buompane on 27/03/25.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
