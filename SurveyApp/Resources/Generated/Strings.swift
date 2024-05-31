// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum LocalizationKey {
  /// Retry
  internal static let surveyBannerErrorRetryCta = LocalizationKey.tr("Localizable", "survey_banner_error_retry_cta", fallback: "Retry")
  /// Failure!
  internal static let surveyBannerErrorTitle = LocalizationKey.tr("Localizable", "survey_banner_error_title", fallback: "Failure!")
  /// Success
  internal static let surveyBannerSuccessTitle = LocalizationKey.tr("Localizable", "survey_banner_success_title", fallback: "Success")
  /// Submit
  internal static let surveyCta = LocalizationKey.tr("Localizable", "survey_cta", fallback: "Submit")
  /// Already Submitted
  internal static let surveyCtaDisabled = LocalizationKey.tr("Localizable", "survey_cta_disabled", fallback: "Already Submitted")
  /// No questions available.
  internal static let surveyErrorNoQuestions = LocalizationKey.tr("Localizable", "survey_error_no_questions", fallback: "No questions available.")
  /// Next
  internal static let surveyNavigationNextTitle = LocalizationKey.tr("Localizable", "survey_navigation_next_title", fallback: "Next")
  /// Previous
  internal static let surveyNavigationPreviousTitle = LocalizationKey.tr("Localizable", "survey_navigation_previous_title", fallback: "Previous")
  /// Question %1$@/%2$@
  internal static func surveyNavigationTitle(_ p1: Any, _ p2: Any) -> String {
    return LocalizationKey.tr("Localizable", "survey_navigation_title", String(describing: p1), String(describing: p2), fallback: "Question %1$@/%2$@")
  }
  /// Type here for an answer...
  internal static let surveyPlaceholder = LocalizationKey.tr("Localizable", "survey_placeholder", fallback: "Type here for an answer...")
  /// Questions submitted: %1$@
  internal static func surveyTitle(_ p1: Any) -> String {
    return LocalizationKey.tr("Localizable", "survey_title", String(describing: p1), fallback: "Questions submitted: %1$@")
  }
  /// Start survey
  internal static let welcomeCtaTitle = LocalizationKey.tr("Localizable", "welcome_cta_title", fallback: "Start survey")
  /// Localizable.strings
  ///   SurveyApp
  /// 
  ///   Created by Gabriel Miranda on 29/5/24.
  internal static let welcomeTitle = LocalizationKey.tr("Localizable", "welcome_title", fallback: "Welcome")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension LocalizationKey {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
