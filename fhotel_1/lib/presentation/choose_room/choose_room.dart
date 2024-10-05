import 'package:fhotel_1/presentation/choose_room/widgets/list_item_widget.dart';
import 'package:fhotel_1/presentation/choose_room/widgets/list_title_room_item_widget.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../hotel_edit_search/hotel_edit_search.dart';

class ChooseRoomFullScreen extends StatelessWidget {
  const ChooseRoomFullScreen({Key? key})
      : super(
          key: key,
        );
  void _showEditSearchModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const EditSearchBottomsheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContent(context),
                Container(
                    color: appTheme.gray10001,
                    child: _buildFiltereditems(context)),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Superior 2 Twin Beds City View",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      _buildListtitleroomit(context)
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Superior 2 Twin Beds City View",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      _buildList(context),
                      SizedBox(height: 46.h)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgChevronLeft,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 16.h,
            bottom: 16.h,
          ),
        ),
        title: AppbarTitle(
          text: "Khách sạn Pullman Vũng Tàu",
          margin: EdgeInsets.only(left: 8.h),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 16.h,
              right: 16.h,
              bottom: 16.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.black900.withOpacity(0.2),
              borderRadius: BorderRadius.circular(
                12.h,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppbarImage(
                  imagePath: ImageConstant.imgIconLeft,
                  margin: EdgeInsets.only(
                    left: 8.h,
                    top: 4.h,
                    bottom: 4.h,
                  ),
                ),
                // SizedBox(width: 8.h),
                Padding(
                  padding: EdgeInsets.only(left: 17.h),
                  child: const Text(
                    "|",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                AppbarIconbutton(
                  imagePath: ImageConstant.imgDivider,
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 4.h,
                  ),
                ),
              ],
            ),
          )
        ],
        styleType: Style.bgFill);
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 8.h),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border(
          top: BorderSide(
            color: appTheme.whiteA700.withOpacity(0.15),
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapperGray60024x24,
            height: 24.h,
            width: 24.h,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                "02/02/2022",
                style: CustomTextStyles.bodyMediumwhiteA700,
              ),
            ),
          ),
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapper9,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 20.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "2",
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapper10,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 20.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "2",
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapper11,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 20.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "3",
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: CustomIconButton(
              onTap: (){
                _showEditSearchModalBottomSheet(context);
              },
              height: 24.h,
              width: 24.h,
              padding: EdgeInsets.all(4.h),
              child: CustomImageView(
                color: Colors.white,
                imagePath: ImageConstant.imgArrowDownWhiteA700,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFiltereditems(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 8.h,
            spacing: 8.h,
            children: List<Widget>.generate(
              2,
              (index) => ChipTheme(
                data: ChipTheme.of(context).copyWith(
                  backgroundColor: Colors.white,
                  selectedColor: Colors.blue,
                  disabledColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.grey, // Border color
                      width: 1, // Border width
                    ),
                    borderRadius: BorderRadius.circular(50), // Rounded corners
                  ),
                ),
                child: const Chip(
                  label: Text(
                    "Wifi miễn phí",
                    textAlign: TextAlign.center,
                  ),
                  // selected: false,
                  // onSelected: (bool selected) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListtitleroomit(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 12.h,
        );
      },
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListtitleroomitItemWidget();
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 12.h,
        );
      },
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListItemWidget();
      },
    );
  }
}
