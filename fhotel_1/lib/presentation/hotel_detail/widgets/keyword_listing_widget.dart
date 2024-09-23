import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class KeywordlistingItemWidget extends StatelessWidget {
  const KeywordlistingItemWidget({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122.h,
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.circleBorder16,
        border: Border.all(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1.h,
        ),
      ),
      child: const Chip(
        label: Text("Phòng sạch"),
        // selected: false,
        // onSelected: (bool selected) {},
      ),
    );
  }
}
