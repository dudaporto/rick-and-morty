//
//  UIStackView.swift
//  RickAndMorty
//
//  Created by Maria Porto on 08/03/22.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
