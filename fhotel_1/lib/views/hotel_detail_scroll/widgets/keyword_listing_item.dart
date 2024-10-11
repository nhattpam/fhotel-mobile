import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class KeywordlistinglItemWidget extends StatelessWidget {
  const KeywordlistinglItemWidget({Key? key})
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
      child: Text(
        "Phòng sạch (16)",
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
