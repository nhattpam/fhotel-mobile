import 'package:fhotel_1/presentation/hotel_listing_filter_bottomsheet/widgets/sectioncontent1_item_widget.dart';
import 'package:fhotel_1/presentation/hotel_listing_filter_bottomsheet/widgets/sectioncontent2_item_widget.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class HotellistingFilterBottomsheet extends StatelessWidget {
  HotellistingFilterBottomsheet({Key? key})
      : super(
          key: key,
        );

  TextEditingController labeltwelveController = TextEditingController();
  TextEditingController labeloneController = TextEditingController();
  bool minphhyphng = false;
  String loihnhni = "";
  bool khcone = false;
  bool ninghone = false;
  bool khunghdng = false;
  bool nhnghhomestay = false;
  bool nhnghone = false;
  bool cnhone = false;
  bool bitthone = false;
  bool khchsnone = false;
  bool nhringone = false;
  bool nhkhchgianh = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.gray10001,
            borderRadius: BorderRadiusStyle.customBorderTL8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSheetheader(context),
              _buildSection(context),
              SizedBox(height: 8.h),
              _buildColumntitlefilt(context),
              SizedBox(height: 8.h),
              _buildSectionone(context),
              SizedBox(height: 8.h),
              _buildSectiontwo(context),
              SizedBox(height: 8.h),
              _buildSectionthree(context),
              SizedBox(height: 8.h),
              _buildSectionfour(context),
              SizedBox(height: 8.h),
              _buildButtonbar(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetheader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 4.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 150.h),
              child: Text(
                "Lọc",
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
          ),
        ],
      ),
    );
  }

  Widget _buildLabeltwelve(BuildContext context) {
    return CustomTextFormField(
      controller: labeltwelveController,
      hintText: "Nhập giá",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      suffix: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Text(
          "đ",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 14.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 40.h,
      ),
      contentPadding: EdgeInsets.fromLTRB(16.h, 8.h, 10.h, 8.h),
    );
  }

  Widget _buildLabelone(BuildContext context) {
    return CustomTextFormField(
      controller: labeloneController,
      hintText: "Nhập giá",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      textInputAction: TextInputAction.done,
      suffix: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Text(
          "d",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 14.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 40.h,
      ),
      contentPadding: EdgeInsets.fromLTRB(16.h, 8.h, 10.h, 8.h),
    );
  }

  Widget _buildSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Giá phòng mỗi đêm",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Từ",
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 4.h),
                      _buildLabeltwelve(context)
                    ],
                  ),
                ),
                SizedBox(width: 6.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đến",
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 4.h),
                      _buildLabelone(context)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumntitlefilt(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hạng sao",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 32.h,
            width: 294.h,
            child: ListView.separated(
                padding: EdgeInsets.only(right: 34.h),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 8.h,
                  );
                },
                itemCount: 5,
                itemBuilder: (context, index) {
                  return SectioncontentiItemWidget();
                }),
          )
        ],
      ),
    );
  }

  Widget _buildSectionone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Chính sách đặt phòng",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.maxFinite,
            child: CustomCheckboxButton(
                text: "Miễn phí hủy phòng",
                value: minphhyphng,
                padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                onChange: (value) {
                  minphhyphng = value;
                }),
          )
        ],
      ),
    );
  }

  Widget _buildSectiontwo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tiện ích",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.maxFinite,
            child: Wrap(
              runSpacing: 8.h,
              spacing: 8.h,
              children: List<Widget>.generate(
                  10, (index) => Sectioncontent2ItemWidget()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionthree(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loại hình nơi nghi ưu tiên",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 22.h),
          SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                CustomRadioButton(
                  text: "Tất cả",
                  value: "Tất cả",
                  groupValue: loihnhni,
                  onChange: (value) {
                    loihnhni = value;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: CustomRadioButton(
                    text: "Thanh toán khi nhận phòng",
                    value: "Thanh toán khi nhận phòng",
                    groupValue: loihnhni,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    onChange: (value) {
                      loihnhni = value;
                    },
                  ),
                ),
                CustomRadioButton(
                  text: "Phù hợp gia đình",
                  value: "Phù hợp gia đình",
                  groupValue: loihnhni,
                  padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                  onChange: (value) {
                    loihnhni = value;
                  },
                ),
                CustomRadioButton(
                  text: "Biệt thự",
                  value: "Biệt thự",
                  groupValue: loihnhni,
                  padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                  onChange: (value) {
                    loihnhni = value;
                  },
                ),
                CustomRadioButton(
                  text: "Promo",
                  value: "Promo",
                  groupValue: loihnhni,
                  padding: EdgeInsets.fromLTRB(10.h, 10.h, 30.h, 10.h),
                  onChange: (value) {
                    loihnhni = value;
                  },
                ),
                CustomRadioButton(
                  text: "Căn hộ",
                  value: "Căn hộ",
                  groupValue: loihnhni,
                  padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                  onChange: (value) {
                    loihnhni = value;
                  },
                ),
                CustomRadioButton(
                  text: "Chọn nhiều nhất",
                  value: "Chọn nhiều nhất",
                  groupValue: loihnhni,
                  padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                  onChange: (value) {
                    loihnhni = value;
                  },
                ),
                CustomRadioButton(
                  text: "Nhà nghi",
                  value: "Nhà nghi",
                  groupValue: loihnhni,
                  padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                  onChange: (value) {
                    loihnhni = value;
                  },
                ),
                CustomRadioButton(
                  text: "Ưu đãi đặc biệt",
                  value: "Ưu đãi đặc biệt",
                  groupValue: loihnhni,
                  padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                  onChange: (value) {
                    loihnhni = value;
                  },
                ),
                CustomRadioButton(
                  text: "Khu nghỉ dưỡng",
                  value: "Khu nghi dưỡng",
                  groupValue: loihnhni,
                  padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                  onChange: (value) {
                    loihnhni = value;
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionfour(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loại hình nơi nghi",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Khác",
                    value: khcone,
                    padding: EdgeInsets.fromLTRB(10.h, 10.h, 30.h, 10.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      khcone = value;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                      text: "Nhà nghi",
                      value: nhnghone,
                      padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                      decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                      onChange: (value) {
                        nhnghone = value;
                      }),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Khu nghỉ dưỡng",
                    value: khunghdng,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      khunghdng = value;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Nhà nghỉ Homestay",
                    value: nhnghhomestay,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      nhnghhomestay = value;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Nhà nghỉ B&B",
                    value: nhnghone,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      nhnghone = value;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Căn hộ",
                    value: cnhone,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      cnhone = value;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Biệt thự",
                    value: bitthone,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      bitthone = value;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Khách sạn",
                    value: khchsnone,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      khchsnone = value;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Nhà riêng",
                    value: nhringone,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      nhringone = value;
                    },
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomCheckboxButton(
                    text: "Nhà khách gia đình",
                    value: nhkhchgianh,
                    padding: EdgeInsets.fromLTRB(10.h, 8.h, 30.h, 8.h),
                    decoration: CustomCheckBoxStyleHelper.fillwhiteA,
                    onChange: (value) {
                      nhkhchgianh = value;
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildXabIc(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        height: 40.h,
        text: "Xóa bộ lọc",
        buttonStyle: CustomButtonStyles.outlinePrimary,
        buttonTextStyle: CustomTextStyles.bodyLargePrimary,
      ),
    );
  }

  Widget _buildPdng(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text: "Ấp dụng",
      ),
    );
  }

  Widget _buildButtonbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 8.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          _buildXabIc(context),
        ],
      ),
    );
  }
}
