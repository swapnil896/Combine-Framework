//
//  String+Extensions.swift
//  MoviesAppUIKit
//
//  Created by Swapnil Magar on 21/11/25.
//

import Foundation

extension String {
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}
