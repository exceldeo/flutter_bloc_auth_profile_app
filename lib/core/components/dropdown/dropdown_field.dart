import 'package:flutter/material.dart';
import 'package:my_profile_app/core/components/text/custom_text.dart';
import 'package:my_profile_app/core/constants/app/color_constants.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';

class DropdownMenuField extends StatefulWidget {
  const DropdownMenuField(
      {super.key, required this.data, this.initialSelection, this.onSelected});
  final List<Map<String, String>> data;
  final String? initialSelection;
  final void Function(String?)? onSelected;

  @override
  State<DropdownMenuField> createState() => _DropdownMenuFieldState();
}

class _DropdownMenuFieldState extends State<DropdownMenuField> {
  String selectedValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValue = (widget.initialSelection ?? widget.data[0]['value'])!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.07),
      child: Row(
        children: [
          Expanded(
            child: CustomText("Gender",
                textStyle: context.textTheme.bodySmall?.copyWith(
                  color: ColorConstants.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: context.dynamicWidth(0.5),
            height: context.dynamicHeight(0.06),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: ColorConstants.white.withOpacity(0.3),
              ),
            ),
            alignment: Alignment.centerRight,
            child: DropdownButton(
              // Initial Value
              value: selectedValue,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: widget.data.map((Map<String, String> items) {
                return DropdownMenuItem(
                  value: items["value"],
                  child: Text(items["label"] ?? items["value"]!,
                      style: context.textTheme.bodySmall?.copyWith(
                          color: ColorConstants.black.withOpacity(0.8))),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                widget.onSelected!(newValue);
                setState(() {
                  selectedValue = newValue!;
                });
              },
              underline: Container(),
            ),
          )
        ],
      ),
    );
  }
}
