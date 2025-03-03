import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/navigator_service.dart';

class ProgressDialogUtils {
  static bool isProgressVisible = false;

  //common menthod for showing progress dialog
  static void showProgressDialog(
      {BuildContext? context, bool isCancelable = false}) async {
    if (!isProgressVisible &&
        NavigatorService.navigatorKey.currentState?.overlay?.context != null) {
      showDialog(
          barrierDismissible: isCancelable,
          context: NavigatorService.navigatorKey.currentState!.overlay!.context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          });
      isProgressVisible = true;
    }
  }

  //common method for hiding progress dialog
  static void hideProgressDialog() {
    if (isProgressVisible) {
      NavigatorService.navigatorKey.currentState?.pop();
      isProgressVisible = false;
    }
  }
}
