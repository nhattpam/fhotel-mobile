import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
// ignore_for_file: must_be_immutable
class CarouselItemWidget extends StatelessWidget {
  CarouselItemWidget ({Key? key})
: super(
key: key,
);
List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
@override
Widget build(BuildContext context) {
return Container (
height: 1092.h,
child: Stack(
alignment: Alignment.bottomCenter,
children: [
CustomImageView(
imagePath: ImageConstant.imgImage156x360,
height: 156.h,
width: double.maxFinite,
alignment: Alignment.topCenter,
),
CustomImageView(
imagePath: ImageConstant.imgTopGradient,
height: 56.h,
width: double.maxFinite,
alignment: Alignment. topCenter,
),
Align(
alignment: Alignment.topCenter,
child: Container (
height: 80.h,
width: double.maxFinite,
margin: EdgeInsets.only(top: 76.h),
  ),
  ),
  Container (
  width: double.maxFinite,
  decoration: BoxDecoration(
  color: appTheme.gray10001,
  borderRadius: BorderRadiusStyle.customBorderTL16,
  ),
  child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  Container(
  width: double.maxFinite,
  padding: EdgeInsets.symmetric(
  horizontal: 16.h,
  vertical: 10.h,
  ),
  decoration: BoxDecoration(
  color: appTheme.whiteA700,
  ),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  SizedBox(height: 2.h),
  Text (
  "Khách sạn Pullman Vũng Tàu",
  style: theme.textTheme.titleMedium,
  ),
  SizedBox(height: 10.h),
  Container (
  width: double.maxFinite,
  decoration: BoxDecoration(
  color: appTheme.whiteA700,
  ),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Container (
  width: 150.h,
  padding: EdgeInsets.symmetric(
  horizontal: 8.h,
  vertical: 4.h,
  ),
  decoration: BoxDecoration(
  color: appTheme.gray100,
  borderRadius: BorderRadiusStyle.roundedBorder8,
  )
  child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Text(
  "Khách sạn",
  style:
  CustomTextStyles. bodySmallOnPrimary10,
  ),
  SizedBox(width: 4.h),
  Expanded (
  child: Row(
  children: [
  CustomImageView(
  imagePath: ImageConstant.imgStar,
  height: 14.h,
  width: 16.h,
  ),
  CustomImageView(
  imagePath: ImageConstant.imgStar,
  height: 14.h,
  width: 16.h,
  ),
  CustomImageView
  imagePath: ImageConstant.imgStar,
  height: 14.h,
  width: 16.h,
  ),
  CustomImageView(
  imagePath: ImageConstant.imgStar,
  height: 14.h,
  width: 16.h,
  CustomImageView(
  imagePath: ImageConstant.imgStar,
  height: 14.h,
  width: 16.h,