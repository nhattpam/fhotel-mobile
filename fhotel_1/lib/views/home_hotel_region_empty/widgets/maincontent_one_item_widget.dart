import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';

  class MaincontentOneltemWidget extends StatefulWidget {
  final String hotelId;
  final String image;
  final String name;
  final int rate;
  final String description;
  const MaincontentOneltemWidget({super.key, required this.hotelId ,required this.image, required this.name, required this.rate, required this.description});

  @override
  _MaincontentOneltemWidgetState createState() => _MaincontentOneltemWidgetState();
  }

  class _MaincontentOneltemWidgetState extends State<MaincontentOneltemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.hotelDetail,
          arguments: {
            'hotelId': widget.hotelId,
          },
        );
      },
      child: SizedBox(
        width: 128.h,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Container(
            height: 170.h,
            width: 128.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: widget.image,
                  height: 170.h,
                  width: double.maxFinite,
                  radius: BorderRadius.circular(
                    8.h,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      left: 8.h,
                      top: 6.h,
                      bottom: 6.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.5, 0),
                        end: Alignment(0.5, 1),
                        colors: [
                          theme.colorScheme.primary.withOpacity(0),
                          theme.colorScheme.primary
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 26.h),
                        Text(
                          widget.name,
                          style: CustomTextStyles.titleSmallBlue,
                        ),
                        SizedBox(height: 6.h),
                        // Text(
                        //   widget.description,
                        //   style: CustomTextStyles.bodySmallWhiteA700,
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 1,
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
