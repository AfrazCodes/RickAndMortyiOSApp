//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/23/22.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
