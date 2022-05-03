import UIKit

fileprivate enum FontName {
    static let bold = "SF Pro Display Bold"
    static let regular = "SF Pro Display Regular"
}

enum Typography {
    /// Bold 34
    static let largeTitle = UIFont(name: FontName.bold, size: 34)
    
    /// Bold 22
    static let highlightTitle = UIFont(name: FontName.bold, size: 22)
    
    /// Bold 18
    static let highlightSecondaryTitle = UIFont(name: FontName.bold, size: 18)
    
    /// Bold 14
    static let highlightTertiaryTitle = UIFont(name: FontName.bold, size: 14)
    
    /// Regular 18
    static let title = UIFont(name: FontName.regular, size: 18)
    
    /// Regular 14
    static let info = UIFont(name: FontName.regular, size: 14)
}

