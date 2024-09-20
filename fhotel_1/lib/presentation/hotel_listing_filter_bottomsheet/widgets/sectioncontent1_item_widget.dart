import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
class SectioncontentiItemWidget extends StatelessWidget {
  const SectioncontentiItemWidget({Key? key})
      : super(
    key: key,
  ) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.h,
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 6.h,
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
        "1 sao",
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}