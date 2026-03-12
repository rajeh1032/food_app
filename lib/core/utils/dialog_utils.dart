import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

/// Utility class for showing dialogs and loading indicators
class DialogUtils {
  DialogUtils._(); // Private constructor

  /// Show loading dialog
  static void showLoading({
    required BuildContext context,
    String message = 'Loading...',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: AppColors.white,
          content: Row(
            children: [
              CircularProgressIndicator(color: AppColors.primaryColor),
              SizedBox(width: 16.w),
              Expanded(child: Text(message, style: AppStyles.bodyMedium)),
            ],
          ),
        ),
      ),
    );
  }

  /// Hide loading dialog
  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// Show message dialog
  static void showMessage({
    required BuildContext context,
    required String message,
    String title = 'Message',
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];

    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            negAction?.call();
          },
          child: Text(negActionName),
        ),
      );
    }

    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            posAction?.call();
          },
          child: Text(posActionName),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(title, style: AppStyles.headlineSmall),
        content: Text(message, style: AppStyles.bodyMedium),
        actions: actions,
      ),
    );
  }

  /// Show error dialog
  static void showError({
    required BuildContext context,
    required String message,
    String title = 'Error',
    String actionName = 'OK',
  }) {
    showMessage(
      context: context,
      message: message,
      title: title,
      posActionName: actionName,
    );
  }

  /// Show success dialog
  static void showSuccess({
    required BuildContext context,
    required String message,
    String title = 'Success',
    String actionName = 'OK',
    VoidCallback? onDismiss,
  }) {
    showMessage(
      context: context,
      message: message,
      title: title,
      posActionName: actionName,
      posAction: onDismiss,
    );
  }

  /// Show confirmation dialog
  static void showConfirmation({
    required BuildContext context,
    required String message,
    String title = 'Confirm',
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    showMessage(
      context: context,
      message: message,
      title: title,
      posActionName: confirmText,
      posAction: onConfirm,
      negActionName: cancelText,
      negAction: onCancel,
    );
  }
}
