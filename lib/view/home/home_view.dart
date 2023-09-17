import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile_app/core/base/profile/bloc/profile_bloc.dart';
import 'package:my_profile_app/core/base/profile/model/profile_model.dart';
import 'package:my_profile_app/core/components/appbar/appbar.dart';
import 'package:my_profile_app/core/components/button/button.dart';
import 'package:my_profile_app/core/components/datepicker/datepickerField.dart';
import 'package:my_profile_app/core/components/dropdown/dropdown_field.dart';
import 'package:my_profile_app/core/components/layout/card/card.dart';
import 'package:my_profile_app/core/components/text/custom_text.dart';
import 'package:my_profile_app/core/components/textFormField/text_form_field_style_two.dart';
import 'package:my_profile_app/core/constants/app/color_constants.dart';
import 'package:my_profile_app/core/constants/app/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:my_profile_app/core/constants/enums/network_enums.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';
import 'package:my_profile_app/core/extensions/num_extensions.dart';
import 'package:my_profile_app/core/init/cache/cache_manager.dart';
import 'package:my_profile_app/core/utils/validate_operations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late String username = '@${StringConstants.appName}';

  @override
  void initState() {
    super.initState();
    getCache();
  }

// get cache
  Future<void> getCache() async {
    final cacheValue = await CacheManager.getString(NetworkEnums.username.path);
    username = '@$cacheValue';
    setState(() {
      username = username;
    });
  }

  late bool isFormAboutOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(isHome: true),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderCardName(username: username),
            10.ph,
            isFormAboutOpen
                ? _AboutFormSection(
                    onTap: (
                      ProfileModel data,
                    ) async {
                      context.read<ProfileBloc>().add(ProfileCreated(
                            data.name,
                            data.birthday,
                            data.height,
                            data.weight,
                            data.interests,
                          ));
                      setState(() {
                        isFormAboutOpen = false;
                      });
                    },
                  )
                : _AboutSection(
                    name: 'John Doe',
                    birthDate: '01.01.1990',
                    height: '1.80',
                    weight: '80',
                    onTap: () {
                      setState(() {
                        isFormAboutOpen = true;
                      });
                    },
                  ),
            10.ph,
            const _InterestSection(
              interests: [
                'Football',
                'Basketball',
                'Volleyball',
                'Tennis',
                'Swimming',
                'Running',
                'Cycling',
                'Gym',
              ],
            ),
            10.ph,
            _LogoutButton(
              onTap: () {
                CacheManager.clearAll();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        )));
  }
}

//section header card
class _HeaderCardName extends StatelessWidget {
  const _HeaderCardName({this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      color: ColorConstants.glassMorphismWhite.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomText(
            username ?? '',
            textStyle: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection(
      {this.name,
      this.birthDate,
      this.height,
      this.weight,
      required this.onTap});

  final String? name;
  final String? birthDate;
  final String? height;
  final String? weight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      color: ColorConstants.primaryDark,
      child: name != '' && birthDate != '' && height != '' && weight != ''
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'About',
                      textStyle: context.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: onTap,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      'Name:',
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.pw,
                    CustomText(
                      name ?? '',
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                8.ph,
                Row(
                  children: [
                    CustomText(
                      'Birth Date:',
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.pw,
                    CustomText(
                      birthDate ?? '',
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                8.ph,
                Row(
                  children: [
                    CustomText(
                      'Height:',
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.pw,
                    CustomText(
                      '$height cm',
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                8.ph,
                Row(
                  children: [
                    CustomText(
                      'Weight:',
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    5.pw,
                    CustomText(
                      '$weight kg',
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : CustomText(
              'No data',
              textStyle: context.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}

class _AboutFormSection extends StatefulWidget {
  const _AboutFormSection({required this.onTap});

  final Function(ProfileModel) onTap;

  @override
  State<_AboutFormSection> createState() => __AboutFormSectionState();
}

class __AboutFormSectionState extends State<_AboutFormSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? get validate => _formKey.currentState?.validate();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CardLayout(
        color: ColorConstants.primaryDark,
        minHeight: 50,
        child: Form(
          key: _formKey,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'About',
                  textStyle: context.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  child: Text(
                    "Save & Update",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: ColorConstants.gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (validate!) {
                      widget.onTap(ProfileModel(
                        nameController.text,
                        birthDateController.text,
                        int.parse(heightController.text),
                        int.parse(weightController.text),
                        [],
                      ));
                    }
                  },
                ),
              ],
            ),
            TextFormFieldWidgetStyleTwo(
              controller: nameController,
              hintText: "Enter name",
              keyboardType: TextInputType.name,
              onSaved: (value) {
                nameController.text = value!;
              },
              title: "Display Name:",
              validator: (value) => ValidateOperations.normalValidation(value),
            ),
            8.ph,
            DropdownMenuField(
              data: [
                {"label": "Male", "value": "male"},
                {"label": "Female", "value": "female"},
              ],
              initialSelection: "male",
              onSelected: (value) {
                genderController.text = value!;
              },
            ),
            8.ph,
            DatePickerField(
              initialDate: DateTime.now(),
              selectedDate: (DateTime? date) {
                birthDateController.text = date.toString();
              },
            ),
            8.ph,
            TextFormFieldWidgetStyleTwo(
              controller: heightController,
              hintText: "Enter Height",
              keyboardType: TextInputType.number,
              onSaved: (value) {
                heightController.text = value!;
              },
              title: "Height:",
              validator: (value) => ValidateOperations.normalValidation(value),
            ),
            8.ph,
            TextFormFieldWidgetStyleTwo(
              controller: weightController,
              hintText: "Enter Weight",
              keyboardType: TextInputType.number,
              onSaved: (value) {
                weightController.text = value!;
              },
              title: "Weight:",
              validator: (value) => ValidateOperations.normalValidation(value),
            ),
          ]),
        ));
  }
}

class _InterestSection extends StatelessWidget {
  const _InterestSection({this.interests});

  final List<String>? interests;

  @override
  Widget build(BuildContext context) {
    return CardLayout(
        color: ColorConstants.primaryDark,
        minHeight: 50,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'Interests',
                  textStyle: context.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/interests/create');
                  },
                ),
              ],
            ),
            Wrap(
              children: [
                for (var interest in interests!)
                  Container(
                    margin: const EdgeInsets.only(right: 5, bottom: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: ColorConstants.primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      interest,
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ));
  }
}

class _LogoutButton extends StatefulWidget {
  const _LogoutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<_LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidth(0.04)),
      child: CustomButton(
        buttonText: StringConstants.logoutButtonText,
        onTap: widget.onTap,
      ),
    );
  }
}
