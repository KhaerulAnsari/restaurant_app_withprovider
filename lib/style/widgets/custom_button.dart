import 'package:flutter/material.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final double height;
  final double width;
  final bool isIcon;
  final VoidCallback? onTap;
  final double? fontSize;
  final Color? colorTitle;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isTap;
  final bool isBorder;
  const CustomButton({
    super.key,
    this.title,
    this.imageUrl,
    this.height = 50,
    this.width = double.infinity,
    this.isIcon = false,
    this.onTap,
    this.colorTitle,
    this.fontSize,
    this.backgroundColor,
    this.borderColor,
    this.isTap = false,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: isBorder ? 2.0 : 0.0,
          ),
          backgroundColor: backgroundColor ?? TypografyStyle.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIcon)
              Image.asset(
                'assets/ic_google.png',
                width: 18,
                height: 18,
              ),
            const SizedBox(
              width: 5,
            ),
            isTap
                ? Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: TypografyStyle.whiteColor,
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        title ?? 'Change Text',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: colorTitle,
                            ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
