import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class HomeDestinationDefaultBottomsheet extends StatefulWidget {
  final List<String> searchHistory; // Accept search history from the parent

  HomeDestinationDefaultBottomsheet({Key? key, required this.searchHistory})
      : super(key: key);

  @override
  _HomeDestinationDefaultBottomsheetState createState() =>
      _HomeDestinationDefaultBottomsheetState();
}

class _HomeDestinationDefaultBottomsheetState
    extends State<HomeDestinationDefaultBottomsheet> {

  TextEditingController searchController = TextEditingController();
  List<String> searchHistory = [];

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
              CustomSearchView(
                controller: searchController,
                hintText: "Tìm khách sạn, điểm đến",
                contentPadding: EdgeInsets.fromLTRB(32.h, 16.h, 12.h, 16.h),
                onSubmitted: (value){
                  setState(() {
                    searchHistory.add(value); // Add the search query to history
                  });
                  Navigator.pop(context, value);
                },
              ),
              _buildSearchHistory(),
              SizedBox(height: 480.h)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetheader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 6.h,
      ),
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Chọn khách sạn, điểm đến",
            style: theme.textTheme.titleMedium,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 36.h),
            onTap: () {
              // Close the bottom sheet when the image is tapped
              Navigator.pop(context, searchController.text);
            },
          )
        ],
      ),
    );
  }

  Widget _buildSearchHistory() {
    return Column(
      children: widget.searchHistory.map((searchTerm) {
        return ListTile(
          title: Text(searchTerm),
          onTap: () {
            Navigator.pop(context, searchTerm); // Select a search from history
          },
        );
      }).toList(),
    );
  }

}
