import 'package:flutter/material.dart';

extension BuildContextExtensions<T> on BuildContext {
  bool get keyboardVisible {
    final mediaQuery = MediaQuery.of(this);
    return mediaQuery.viewInsets.bottom != 0;
  }

  ThemeData get theme => Theme.of(this);

  void pushRoute(String routeName, {Object? args}) {
    Navigator.pushNamed(this, routeName, arguments: args);
  }

  void replaceRoute(String routeName, {Object? args}) {
    Navigator.popAndPushNamed(this, routeName, arguments: args);
  }

  void pop({Object? result}) {
    Navigator.pop(this, result);
  }

  void popAllAndReplace(String route) {
    Navigator.of(this).pushNamedAndRemoveUntil(route, (route) => false);
  }

  void removeFocus() => FocusScope.of(this).unfocus();

  void nextFocus() => FocusScope.of(this).nextFocus();

  void displayDilog(Widget child) {
    showDialog(
      context: this,
      builder: (context) => child,
    );
  }

  Future displayDialog2(Widget child) {
    return showDialog(
      context: this,
      builder: (context) => child,
    );
  }

  void showSnackBar(String text, {bool queue = false}) {
    if (!queue) {
      ScaffoldMessenger.of(this).hideCurrentSnackBar();
    }
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        text,
        softWrap: true,
      ),
    ));
  }
}
