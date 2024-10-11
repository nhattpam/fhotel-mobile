import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class ServiceDetailItemWidget extends StatelessWidget {
  const ServiceDetailItemWidget({Key? key})
      : super(
    key: key,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.h,
      height: 48.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Text(
        "10",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: CustomTextStyles.bodyLargeGray600,
      ),
    );
  }
}