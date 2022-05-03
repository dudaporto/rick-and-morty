// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {

  internal enum CharacterList {
    /// What character are you looking for?
    internal static let searchBarPlaceholder = Strings.tr("Localizable", "characterList.searchBarPlaceholder")
    /// See more characters
    internal static let seeMoreCharacters = Strings.tr("Localizable", "characterList.seeMoreCharacters")
    /// Search for Rick & Morty character by name and using filters
    internal static let subtitle = Strings.tr("Localizable", "characterList.subtitle")
    /// Characters
    internal static let title = Strings.tr("Localizable", "characterList.title")
    internal enum CharacterCell {
      /// Last known location
      internal static let lastKnownLocation = Strings.tr("Localizable", "characterList.characterCell.lastKnownLocation")
    }
    internal enum NotFound {
      /// Enter a new name or try again
      internal static let searchErrorSubtitle = Strings.tr("Localizable", "characterList.notFound.searchErrorSubtitle")
      /// Oops! No results were found for ”%@”
      internal static func searchErrorTitle(_ p1: Any) -> String {
        return Strings.tr("Localizable", "characterList.notFound.searchErrorTitle", String(describing: p1))
      }
    }
  }

  internal enum CharacterProfile {
    /// About
    internal static let aboutSectionTitle = Strings.tr("Localizable", "characterProfile.aboutSectionTitle")
    /// Episodes
    internal static let episodesSectionTitle = Strings.tr("Localizable", "characterProfile.episodesSectionTitle")
  }

  internal enum Global {
    internal enum GenericError {
      /// Sorry, we had a system failure! Try again.
      internal static let message = Strings.tr("Localizable", "global.genericError.message")
      /// Oops! Something went wrong
      internal static let title = Strings.tr("Localizable", "global.genericError.title")
      /// Try again
      internal static let tryAgain = Strings.tr("Localizable", "global.genericError.tryAgain")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
