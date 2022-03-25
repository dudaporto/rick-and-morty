//
//  Typography.swift
//  RickAndMorty
//
//  Created by Maria Porto on 08/03/22.
//
//

import UIKit

fileprivate enum FontName {
    static let bold = "SF Pro Display Bold"
    static let regular = "SF Pro Display Regular"
}

enum Typography {
    /// Bold 16
    static let highlightTitle = UIFont(name: FontName.bold, size: 18)
    
    /// Bold 12
    static let highlightSecondaryTitle = UIFont(name: FontName.bold, size: 14)
    
    /// Regular 16
    static let title = UIFont(name: FontName.regular, size: 18)
    
    /// Regular 12
    static let info = UIFont(name: FontName.regular, size: 14)
}

