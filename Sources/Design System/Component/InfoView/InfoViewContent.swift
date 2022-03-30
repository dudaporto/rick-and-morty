import UIKit

struct InfoViewContent {
    let image: UIImage?
    let title: String
    let description: String?
    let primaryButtonTitle: String?
    let secondaryButtonTitle: String?
}

extension InfoViewContent {
    static let genericError = InfoViewContent(image: nil,
                                              title: GlobalLocalizable.GenericError.title,
                                              description: GlobalLocalizable.GenericError.message,
                                              primaryButtonTitle: GlobalLocalizable.GenericError.tryAgain,
                                              secondaryButtonTitle: GlobalLocalizable.GenericError.notNow)
}
