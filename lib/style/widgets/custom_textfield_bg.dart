import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';

class CustomTextFieldBg extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? textEditingController;
  final bool? obscureText;
  final double? widthIcon;
  final double? heightIcon;
  final Widget? widget;
  final Color? titleColor;
  final Color? borderColor;
  final Function? onChanged;
  final bool? enabled;
  final int? maxlines;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final Function? validator;

  const CustomTextFieldBg({
    super.key,
    this.title,
    this.hintText,
    this.onChanged,
    this.textEditingController,
    this.obscureText,
    this.widthIcon,
    this.heightIcon,
    this.widget,
    this.titleColor,
    this.borderColor,
    this.enabled,
    this.maxlines,
    this.suffixIcon,
    this.textInputType,
    this.textInputFormatter,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title ?? '',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: title != null ? 16 : 0,
              ),
        ),

        title != null
            ? const SizedBox(
                height: 6,
              )
            : const SizedBox(),

        // TextField
        TextFormField(
          cursorColor: TypografyStyle.whiteColor,
          keyboardType: textInputType ?? TextInputType.text,
          inputFormatters: textInputFormatter ?? [],
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }

            null;
          },
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            }

            return null;
          },
          maxLines: maxlines ?? 1,
          enabled: enabled ?? true,
          controller: textEditingController,
          obscureText: obscureText ?? false,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: borderColor != null
                    ? TypografyStyle.greyColor
                    : Colors.black,
              ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: TypografyStyle.mainColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: TypografyStyle.mainColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: TypografyStyle.mainColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: TypografyStyle.greyColor,
                ),
            suffixIcon: widget ?? const SizedBox(),
          ),
        ),
      ],
    );
  }
}
