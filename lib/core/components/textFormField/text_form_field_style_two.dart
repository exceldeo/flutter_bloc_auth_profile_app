import 'package:my_profile_app/core/components/text/custom_text.dart';
import 'package:my_profile_app/core/constants/app/color_constants.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/typedefs.dart';

class TextFormFieldWidgetStyleTwo extends StatefulWidget {
  const TextFormFieldWidgetStyleTwo({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.title,
    this.onSaved,
    this.keyboardType = TextInputType.text,
  });

  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final ValidatorFunction validator;
  final TextInputType? keyboardType;

  @override
  State<TextFormFieldWidgetStyleTwo> createState() =>
      _TextFormFieldWidgetStyleTwoState();
}

class _TextFormFieldWidgetStyleTwoState
    extends State<TextFormFieldWidgetStyleTwo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.07),
      child: Row(
        children: [
          widget.title == null
              ? const SizedBox()
              : Expanded(
                  child: CustomText(widget.title ?? "",
                      textStyle: context.textTheme.bodySmall?.copyWith(
                        color: ColorConstants.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      )),
                ),
          SizedBox(
            width: widget.title == null
                ? context.dynamicWidth(0.9)
                : context.dynamicWidth(0.5),
            height: context.dynamicHeight(0.06),
            child: TextFormField(
                textAlign: TextAlign.right,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                validator: widget.validator,
                onSaved: widget.onSaved,
                decoration: InputDecoration(
                  fillColor: ColorConstants.glassMorphismWhite,
                  hintText: widget.hintText,
                  hintStyle: context.textTheme.bodySmall?.copyWith(
                    color: ColorConstants.white.withOpacity(0.3),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: ColorConstants.white,
                      width: 4,
                    ),
                  ),
                ),
                cursorColor: ColorConstants.teal,
                style: GoogleFonts.montserrat().copyWith(
                  color: ColorConstants.white,
                  fontWeight: FontWeight.w700,
                )),
          )
        ],
      ),
    );
  }
}
