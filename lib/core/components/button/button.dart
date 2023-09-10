import 'package:my_profile_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../constants/app/color_constants.dart';
import '../text/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isDisabled = false,
  });

  final String buttonText;
  final VoidCallback onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.05)),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor:
                isDisabled ? Colors.grey : ColorConstants.secondary,
            fixedSize: Size(
              context.dynamicWidth(1),
              context.dynamicHeight(0.06),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            )),
        child: CustomText(
          buttonText,
          textStyle: context.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
