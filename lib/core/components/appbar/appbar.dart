import 'package:my_profile_app/core/components/text/custom_text.dart';
import 'package:my_profile_app/core/constants/app/color_constants.dart';
import 'package:my_profile_app/core/constants/app/string_constants.dart';
import 'package:my_profile_app/core/constants/enums/network_enums.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';
import 'package:my_profile_app/core/init/cache/cache_manager.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    this.isHome = false,
  }) : super(key: key);

  final bool isHome;

  @override
  State<AppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String titleApp = '@${StringConstants.appName}';

  @override
  void initState() {
    super.initState();
    getCache();
  }

// get cache
  Future<void> getCache() async {
    final cacheValue = await CacheManager.getString(NetworkEnums.username.path);
    titleApp = '@$cacheValue';
    setState(() {
      titleApp = titleApp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.primary,
      elevation: 1,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            titleApp,
            textStyle: context.textTheme.titleMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
