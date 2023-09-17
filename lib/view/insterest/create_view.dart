import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_profile_app/core/components/textFormField/text_form_field_style_two.dart';
import 'package:my_profile_app/core/constants/app/color_constants.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';
import 'package:my_profile_app/core/extensions/num_extensions.dart';

class CreateInsterestsView extends StatefulWidget {
  const CreateInsterestsView({super.key});

  @override
  State<CreateInsterestsView> createState() => _CreateInsterestsViewState();
}

class _CreateInsterestsViewState extends State<CreateInsterestsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBarStyleTwo(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidth(0.05)),
                height: context.dynamicHeight(0.9),
                width: context.dynamicWidth(1),
                child: const _FormAddInterest(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBarStyleTwo extends StatelessWidget {
  const CustomAppBarStyleTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            child: MaterialButton(
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 17,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Save",
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: Colors.blue)))
        ],
      ),
    );
  }
}

class _FormAddInterest extends StatefulWidget {
  const _FormAddInterest();

  @override
  State<_FormAddInterest> createState() => _FormAddInterestState();
}

class _FormAddInterestState extends State<_FormAddInterest> {
  final TextEditingController _textEditingController = TextEditingController();

  final List<String> _interests = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tell everyone about yourself",
          style: context.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.gold.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "What Interest you?",
          style: context.textTheme.headlineMedium?.copyWith(
            color: ColorConstants.white.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        10.ph,
        SizedBox(
          width: context.dynamicWidth(0.9),
          height: context.dynamicHeight(0.06),
          child: TextFormField(
              textAlign: TextAlign.left,
              controller: _textEditingController,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (value) {
                setState(() {
                  _interests.add(value);
                  _textEditingController.clear();
                });
              },
              decoration: InputDecoration(
                fillColor: ColorConstants.glassMorphismWhite,
                hintText: "Add Interest",
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
        ),
        10.ph,
        _ListOfInterest(
          interests: _interests,
          onDelete: (value) {
            setState(() {
              _interests.remove(value);
            });
          },
        ),
      ],
    );
  }
}

class _ListOfInterest extends StatelessWidget {
  const _ListOfInterest({super.key, required this.interests, this.onDelete});

  final List<String> interests;
  final void Function(String)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: interests
          .map((e) => Container(
                margin: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidth(0.01),
                    vertical: context.dynamicHeight(0.01)),
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidth(0.02)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: ColorConstants.white.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      e,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: ColorConstants.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          onDelete?.call(e);
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorConstants.white.withOpacity(0.8),
                          size: 15,
                        ))
                  ],
                ),
              ))
          .toList(),
    );
  }
}
