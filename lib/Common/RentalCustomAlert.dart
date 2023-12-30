// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';

class RentalCustomAlert {
  static Future<void> showSuccessAlert(BuildContext context, String title, String textMessage) async {
    await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.success,
        title: title,
        text: textMessage,
      ),
    );
  }

  static Future<void> showMessageWithTitleAndText(BuildContext context, String title, String textMessage) async {
    await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.question,
        title: "A question?",
        text: "Show a question message with an icon",
      ),
    );
  }

  static Future<void> showErrorAlert(BuildContext context) async {
    await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: "Oops...",
        text: "There is a problem :(",
      ),
    );
  }

  static Future<void> showErrorsAlert(BuildContext context, String title, String textMessage) async {
    await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        title: title,
        text: textMessage,
      ),
    );
  }

  static Future<void> showThreeButtonDialog(BuildContext context, String title, String textMessage) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
      barrierDismissible: false,
      context: context,
      artDialogArgs: ArtDialogArgs(
        showCancelBtn: true,
        denyButtonText: "Don't save",
        title: "Do you want to save the changes?",
        confirmButtonText: "Save",
      ),
    );

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      await ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Saved!",
        ),
      );
      return;
    }

    if (response.isTapDenyButton) {
      await ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.info,
          title: "Changes are not saved!",
        ),
      );
      return;
    }
  }

  static Future<void> showConfirmDialog(BuildContext context, String title, String textMessage) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
      barrierDismissible: false,
      context: context,
      artDialogArgs: ArtDialogArgs(
        denyButtonText: "Cancel",
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        confirmButtonText: "Yes, delete it",
        type: ArtSweetAlertType.warning,
      ),
    );

    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      await ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Deleted!",
        ),
      );
      return;
    }
  }
}
