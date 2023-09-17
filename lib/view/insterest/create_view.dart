import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_profile_app/core/components/layout/card/card.dart';
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
          "What do you do for work?",
          style: context.textTheme.headlineSmall?.copyWith(
            color: ColorConstants.white.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        30.ph,
        Container(
          width: context.dynamicWidth(0.9),
          height: context.dynamicHeight(0.07),
          decoration: BoxDecoration(
            color: ColorConstants.glassMorphismWhite.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
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
                contentPadding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidth(0.02),
                    vertical: context.dynamicHeight(0.025)),
                hintText: "eg. Musician",
                hintStyle: context.textTheme.bodyLarge?.copyWith(
                  color: ColorConstants.white.withOpacity(0.1),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: ColorConstants.white,
                    width: 4,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  // border transparent
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 4,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
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
        20.ph,
        Text(
          "Selected Profession",
          style: context.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.white.withOpacity(0.3),
            fontWeight: FontWeight.bold,
          ),
        ),
        _ListOfInterest(
          interests: _interests,
          onDelete: (value) {
            setState(() {
              _interests.remove(value);
            });
          },
        ),
        20.ph,
        Text(
          "Popular Profession",
          style: context.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.white.withOpacity(0.3),
            fontWeight: FontWeight.bold,
          ),
        ),
        _ListOfPopularInterest(
          onAdd: (value) {
            setState(() {
              _interests.add(value);
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
                    horizontal: context.dynamicWidth(0.02),
                    vertical: context.dynamicHeight(0.01)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: ColorConstants.glassMorphismWhite.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      e,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          onDelete?.call(e);
                        },
                        child: Icon(
                          Icons.close,
                          color: ColorConstants.white.withOpacity(0.8),
                          size: 22,
                        ))
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _ListOfPopularInterest extends StatelessWidget {
  const _ListOfPopularInterest({super.key, this.onAdd});

  final void Function(String)? onAdd;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _InterestCard(
          title: "Musician",
          onAdd: onAdd,
        ),
        _InterestCard(
          title: "Photographer",
          onAdd: onAdd,
        ),
        _InterestCard(
          title: "Designer",
          onAdd: onAdd,
        ),
        _InterestCard(
          title: "Developer",
          onAdd: onAdd,
        ),
      ],
    );
  }
}

class _InterestCard extends StatelessWidget {
  const _InterestCard({super.key, required this.title, this.onAdd});

  final String title;
  final void Function(String)? onAdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onAdd?.call(title);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: context.dynamicWidth(0.01),
            vertical: context.dynamicHeight(0.01)),
        padding: EdgeInsets.symmetric(
            horizontal: context.dynamicWidth(0.02),
            vertical: context.dynamicHeight(0.01)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.glassMorphismWhite.withOpacity(0.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                color: ColorConstants.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
