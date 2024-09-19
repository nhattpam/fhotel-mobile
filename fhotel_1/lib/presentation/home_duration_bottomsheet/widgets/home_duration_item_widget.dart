import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/widgets/custom_radio_button.dart';
import 'package:flutter/material.dart';
// ignore_for_file: must_be_immutable
class HomeDurationItemWidget extends StatelessWidget {
  HomeDurationItemWidget ({Key? key})
      : super(
    key: key,
  );
  String radioGroup = "";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
          width: 20.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomRadioButton(
                value: "",
                groupValue: radioGroup,
                onChange: (value) {
                  radioGroup = value;
                },
              ),
              Container(
                height: 12.h,
                width: 12.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                    6.h,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.h),
          child: Text(
            "1 đêm",
            style: theme.textTheme.titleSmall,
          ),
        ),
        Spacer(),
        Text(
          "Trả phòng: 03/02/2022",
          style: theme.textTheme.bodyMedium,
        )
      ],
    );
  }
}