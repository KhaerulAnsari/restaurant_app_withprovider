import 'package:flutter/material.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';
import 'package:restaurant_app/style/widgets/custom_button.dart';
import 'package:unicons/unicons.dart';

class InfoDialog extends StatelessWidget {
  final String? message;
  final Function? onPressed;
  final String? titleButton;
  final IconData? iconDialog;
  final Color? colorIconDialog;
  const InfoDialog({
    super.key,
    this.message,
    this.onPressed,
    this.titleButton,
    this.iconDialog,
    this.colorIconDialog,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      key: key,
      title: Icon(
        iconDialog ?? UniconsLine.info_circle,
        size: 80,
        color: colorIconDialog ?? Colors.red,
      ),
      content: Text(
        message!,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 16,
            ),
        textAlign: TextAlign.center,
      ),
      actions: [
        SizedBox(
          height: 45,
          width: double.infinity,
          child: CustomButton(
            backgroundColor: TypografyStyle.mainColor,
            colorTitle: TypografyStyle.whiteColor,
            title: titleButton ?? 'Change Title',
            onTap: () {
              if (onPressed != null) {
                onPressed!();
              }
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
