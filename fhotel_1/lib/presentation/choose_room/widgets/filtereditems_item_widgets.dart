import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class FiltereditemsItemWidget extends StatelessWidget {
  const FiltereditemsItemWidget({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.all(6.h),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Wifi miễn phí",
        style: TextStyle(
          color: theme.colorScheme.onPrimary,
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
      selected: false,
      backgroundColor: appTheme.whiteA700,
      selectedColor: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          16.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
