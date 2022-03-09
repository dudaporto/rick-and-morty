//
//  UIView.swift
//  RickAndMorty
//
//  Created by Maria Porto on 08/03/22.
//

import UIKit

extension UIView {
    func border(
        color: UIColor? = nil,
        width: CGFloat = 0,
        opacity: CGFloat = 1,
        radius: CGFloat = 0
    ) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = color?.withAlphaComponent(opacity).cgColor
    }
    
    func fitToParent(with insets: UIEdgeInsets = .zero) {
        guard let parent = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left),
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        ])
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
