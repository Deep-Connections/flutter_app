import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  /// Navigates to the specified [page] by pushing it onto the navigation stack.
  ///
  /// This allows for back navigation to the previous page.
  ///
  /// Example usage:
  /// ```dart
  /// context.navigate(NewPageWidget());
  /// ```
  ///
  /// - Parameters:
  ///   - page: The widget to navigate to.
  void navigate(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));
  }

  /// Replaces the current page with the specified [page].
  ///
  /// This method changes the current route by replacing the entire screen
  /// with the new [page]. The replaced route does not remain in the navigation
  /// stack, so the user cannot navigate back to it.
  ///
  /// Example usage:
  /// ```dart
  /// context.navigateAndReplace(NewPageWidget());
  /// ```
  ///
  /// - Parameters:
  ///   - page: The widget to navigate to, replacing the current one.
  void navigateAndReplace(Widget page) {
    Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  /// Navigates to the specified [page] and removes all previous routes from
  /// the navigation stack.
  ///
  /// Use this method to navigate to a new page when you want to clear the
  /// navigation history and reset the navigation stack. This is useful in
  /// scenarios such as logging in, where you want to navigate to the home
  /// screen and remove the possibility of navigating back to the login screen.
  ///
  /// Example usage:
  /// ```dart
  /// context.navigateAndClearStack(HomeScreenWidget());
  /// ```
  ///
  /// - Parameters:
  ///   - page: The widget to set as the root of the navigation stack.
  void navigateAndClearStack(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }
}
