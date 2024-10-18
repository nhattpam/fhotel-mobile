import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class HomeDestinationDefaultBottomsheet extends StatefulWidget {
  HomeDestinationDefaultBottomsheet({Key? key}) : super(key: key);

  @override
  _HomeDestinationDefaultBottomsheetState createState() =>
      _HomeDestinationDefaultBottomsheetState();
}

class _HomeDestinationDefaultBottomsheetState
    extends State<HomeDestinationDefaultBottomsheet> {
  TextEditingController searchController = TextEditingController();
  late SessionManager sessionManager;
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    sessionManager = SessionManager();
    sessionManager.init(); // Initialize session manager
    _loadSearchHistory(); // Load existing search history
  }

  void _loadSearchHistory() {
    setState(() {
      // Load search history from session manager
      searchHistory = sessionManager.getSearchHistory();
    });
  }

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
                onSubmitted: (value) {
                  setState(() {
                    if (!searchHistory.contains(value)) {
                      // Only add if the value is not already in the history
                      searchHistory.add(value);
                      // Save the updated search history to session
                      sessionManager.setSearchHistory(searchHistory);
                    }
                  });
                  Navigator.pop(context, value); // Close the sheet with the selected value
                },
              ),
              SizedBox(height: 10.h),
              _buildColumniconwrapp(context),
              SizedBox(height: 480.h),
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
          ),
        ],
      ),
    );
  }

  Widget _buildColumniconwrapp(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 6.h,
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Tìm kiếm gần đây",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Column(
            children: searchHistory.map((searchTerm) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Set the selected search term in the search field
                        searchController.text = searchTerm;

                        // Save the selected search term to the session
                        if (!searchHistory.contains(searchTerm)) {
                          searchHistory.add(searchTerm);
                          sessionManager.setSearchHistory(searchHistory); // Update session with new history
                        }
                      });
                      // Close the bottom sheet with the selected search term
                      Navigator.pop(context, searchTerm);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: appTheme.whiteA700,
                      ),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgIconWrapperGray600,
                                height: 24.h,
                                width: 24.h,
                                color: appTheme.black900.withOpacity(0.5),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 6.h),
                                  child: Text(
                                    searchTerm, // Display search term
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // Remove the search term from the list
                                searchHistory.remove(searchTerm);
                                // Update the session with the new search history
                                sessionManager.setSearchHistory(searchHistory);
                              });
                            },
                            child: Icon(
                              Icons.close, // "X" icon
                              color: Colors.red,
                              size: 24.h, // Customize the size if necessary
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Divider(), // Adds the Divider below each search term
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
