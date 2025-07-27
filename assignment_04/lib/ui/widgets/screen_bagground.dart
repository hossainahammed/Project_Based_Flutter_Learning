import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/asset_paths.dart';

class ScreenBagground extends StatelessWidget {
  const ScreenBagground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // SvgPicture.asset(
        //   AssetPaths.backgroundSvg,
        //   fit: BoxFit.cover,
        //   height: double.maxFinite,
        //   width: double.maxFinite,
        // ),
        SizedBox.expand(
          child: SvgPicture.asset(
            AssetPaths.backgroundSvg,
            fit: BoxFit.cover,
          ),
        ),

        SafeArea(child: child),
      ],
    );
  }
}
