import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/widgets/custom_radio_button.dart';
import 'package:flutter/material.dart';

class HomeDurationItemWidget extends StatefulWidget {
  final Function(bool) onSelectionChanged;

  const HomeDurationItemWidget({Key? key, required this.onSelectionChanged}) : super(key: key);

  @override
  _HomeDurationItemWidgetState createState() => _HomeDurationItemWidgetState();
}

class _HomeDurationItemWidgetState extends State<HomeDurationItemWidget> {
  String radioGroup = "";
  bool choose = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox(
            height: 20.h,
            width: 20.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomRadioButton(
                  value: "selected_value", // Set appropriate value
                  groupValue: radioGroup,
                  onChange: (value) {
                    setState(() {
                      radioGroup = value;
                      choose = true; // Update choose when selected
                      widget.onSelectionChanged(choose); // Notify the parent
                    });
                  },
                ),
                Text(
                  "1 đêm",
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),

        ),
        Spacer(),
        Text(
          "Trả phòng: 03/02/2022",
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

