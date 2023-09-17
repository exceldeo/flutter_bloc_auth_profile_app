import 'package:flutter/material.dart';
import 'package:my_profile_app/core/components/text/custom_text.dart';
import 'package:my_profile_app/core/constants/app/color_constants.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';

class DatePickerField extends StatefulWidget {
  DatePickerField({Key? key, this.initialDate, this.selectedDate})
      : super(key: key);

  final DateTime? initialDate;
  void Function(DateTime?)? selectedDate;

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
    widget.selectedDate!(selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.selectedDate!(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.07),
      child: Row(
        children: [
          Expanded(
            child: CustomText("Birth Date",
                textStyle: context.textTheme.bodySmall?.copyWith(
                  color: ColorConstants.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                )),
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: context.dynamicWidth(0.5),
              height: context.dynamicHeight(0.06),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: ColorConstants.white.withOpacity(0.3),
                ),
              ),
              child: Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                style: TextStyle(color: ColorConstants.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
