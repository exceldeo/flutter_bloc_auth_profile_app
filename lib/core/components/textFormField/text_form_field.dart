import 'package:my_profile_app/core/components/text/custom_text.dart';
import 'package:my_profile_app/core/constants/app/color_constants.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/typedefs.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.validator,
      this.title,
      this.isPassword = false,
      this.onSaved,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.suffixIcon});

  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final VoidCallback? onChanged;
  final ValidatorFunction validator;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          widget.title ?? "",
          textStyle: context.textTheme.titleMedium,
        ),
        TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onSaved: widget.onSaved,
            onChanged: (value) {
              widget.onChanged?.call();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorConstants.glassMorphismWhite,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.montserrat().copyWith(
                color: ColorConstants.white.withOpacity(0.3),
                fontWeight: FontWeight.w700,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 255, 141, 133)),
              ),
              suffixIcon: widget.suffixIcon,
            ),
            cursorColor: ColorConstants.teal,
            obscureText: widget.isPassword ?? false,
            style: GoogleFonts.montserrat().copyWith(
              color: ColorConstants.white,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }
}
