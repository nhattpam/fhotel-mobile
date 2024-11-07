import 'dart:io';

import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/wallet.dart';
import 'package:fhotel_1/presenters/user_profile_presenter.dart';
import 'package:fhotel_1/views/register_fill_information/upload_image_view.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../../data/repository/upload_image_service.dart';
import '../../presenters/upload_image_presenter.dart';
import '../user_profile/user_profile_view.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen>
    implements UserProfileView, ImageView {
  final List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());
  String? selectedGender;
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController bankInputController = TextEditingController();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController iDNumberInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController addressInputController = TextEditingController();

  List<String> dropdownItemList = [
    "Male",
    "Female",
  ];

  late UserProfilePresenter _presenter;
  User? _customer;
  Wallet? _wallet;
  String? _error;
  late ImagePresenter _imagePresenter;
  String _imagePath = "";
  final picker = ImagePicker();
  bool _isLoading = false;
  String? _imageUrl;

  String? nameError;
  String? idNumberError;
  String? phoneNumberError;
  String? addressError;

  @override
  void initState() {
    super.initState();
    _presenter = UserProfilePresenter(this); // Initialize the presenter
    _imagePresenter = ImagePresenter(this, ImageService());

    _presenter.getCustomerById(); // Fetch customer data
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    // Cancel any subscriptions or async operations here
    nameInputController.dispose();
    iDNumberInputController.dispose();
    phoneNumberInputController.dispose();
    addressInputController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      // Check if file size is greater than 5MB (5 * 1024 * 1024 bytes)
      if (fileSize > 5 * 1024 * 1024) {
        // Display an error message if file size exceeds 5MB
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hình ảnh phải nhỏ hơn 5MB')),
        );
        return;
      }

      setState(() {
        _imagePath = pickedFile.path;
      });

      await _imagePresenter.pickImageAndUpload(file);
    }
  }

  void _unfocusAllExcept(int index) {
    for (int i = 0; i < focusNodes.length; i++) {
      if (i != index) {
        focusNodes[i].unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 24.h,
                top: 18.h,
                right: 24.h,
              ),
              child: Column(
                children: [
                  Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                      color: appTheme.gray10002,
                      borderRadius: BorderRadiusStyle.circleBorder50,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_imageUrl != null) ...[
                          ClipOval(
                            // Show this when _imageUrl is not null
                            child: Image.network(
                              _imageUrl ?? '',
                              fit: BoxFit.cover,
                              // Adjust the fit as necessary
                              height: 100.h,
                              // Set height to match the container
                              width: 100.h, // Set width to match the container
                            ),
                          ),
                          GestureDetector(
                            onTap:
                                _pickImage, // You can adjust this logic as necessary
                          )
                        ] else if (_customer?.image != null) ...[
                          (_customer?.image != null && _customer?.image != '')
                              ? Image.network(
                                  _customer?.image ?? '',
                                  fit: BoxFit.cover,
                                  // Adjust the fit as necessary
                                  height: 100.h,
                                  // Set height to match the container
                                  width:
                                      100.h, // Set width to match the container
                                )
                              : Skeleton(
                                  height: 100.h,
                                  // Set height to match the container
                                  width: 100.h,
                                ),
                          GestureDetector(
                            onTap:
                                _pickImage, // You can adjust this logic as necessary
                          )
                        ] else
                          GestureDetector(
                            onTap: _pickImage,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildFirstName(context),
                  SizedBox(height: 24.h),
                  _buildEmail(context),
                  SizedBox(height: 24.h),
                  _buildPassword(context),
                  SizedBox(height: 24.h),
                  _buildBank(context),
                  SizedBox(height: 24.h),
                  _buildIdNumber(context),
                  SizedBox(height: 24.h),
                  _buildPhone(context),
                  SizedBox(height: 24.h),
                  _buildAddress(context),
                  SizedBox(height: 30.h)
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildColumnsave(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
          onTap: () {
            Navigator.pop(context);
          },
          imagePath: ImageConstant.imgChevronLeft,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 16.h,
            bottom: 16.h,
          ),
        ),
        title: AppbarTitle(
          text: "Thay đổi thông tin",
          margin: EdgeInsets.only(left: 8.h),
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(
        //       top: 16.h,
        //       right: 16.h,
        //       bottom: 16.h,
        //     ),
        //     decoration: BoxDecoration(
        //       color: appTheme.black900.withOpacity(0.2),
        //       borderRadius: BorderRadius.circular(
        //         12.h,
        //       ),
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         AppbarImage(
        //           imagePath: ImageConstant.imgIconLeft,
        //           margin: EdgeInsets.only(
        //             left: 8.h,
        //             top: 4.h,
        //             bottom: 4.h,
        //           ),
        //         ),
        //         // SizedBox(width: 8.h),
        //         Padding(
        //           padding:
        //           EdgeInsets.only(left: 17.h),
        //           child: const Text(
        //             "|",
        //             style: TextStyle(
        //                 color: Colors.black
        //             ),
        //           ),
        //         ),
        //         AppbarIconbutton(
        //           imagePath: ImageConstant.imgDivider,
        //           margin: EdgeInsets.symmetric(
        //             horizontal: 8.h,
        //             vertical: 4.h,
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ],
        styleType: Style.bgFill);
  }

  Widget _buildFirstName(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Họ và Tên',
            style: TextStyle(color: Colors.blue),
          ),
          if (nameError != null)
            Text(
              nameError!,
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(
            height: 8.h,
          ),
          (_customer?.name != null)
              ? CustomTextFormField(
                  focusNode: focusNodes[0],
                  controller: nameInputController,
                  hintText: "${_customer?.name}",
                  // (_customer?.name != null) ? "${_customer?.name}" : "",
                  hintStyle: CustomTextStyles.bodyLargeGray600,
                  contentPadding: EdgeInsets.all(20.h),
                  onChanged: (value) {
                    final error = _presenter
                        .validateName(value); // Validate password on change
                    setState(() {
                      nameError = error; // Clear the error if validation passes
                    });
                  },
                  onTap: () {
                    _unfocusAllExcept(0); // Unfocus all except the email field
                  },
                )
              : Skeleton(width: 300.h, height: 60.h)
        ],
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(color: Colors.blue),
          ),
          SizedBox(
            height: 8.h,
          ),
          (_customer?.email != null)
              ? CustomTextFormField(
                  readOnly: true,
                  controller: emailInputController,
                  hintText: "${_customer?.email}",
                  hintStyle: CustomTextStyles.bodyLargeGray600,
                  contentPadding: EdgeInsets.all(20.h))
              : Skeleton(width: 300.h, height: 60.h),
        ],
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mật khẩu',
            style: TextStyle(color: Colors.blue),
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.userChangePassword,
                  arguments: _customer);
            },
            child: AbsorbPointer(
              child: CustomTextFormField(
                readOnly: true,
                controller: passwordInputController,
                hintText: "*******",
                hintStyle: CustomTextStyles.bodyLargeGray600,
                obscureText: true,
                contentPadding: EdgeInsets.all(20.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBank(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Số tài khoản ngân hàng',
            style: TextStyle(color: Colors.blue),
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.userChangeBank,
                  arguments: {
                    'customer': _customer,
                    'wallet': _wallet
                  });
            },
            child: AbsorbPointer(
              child: CustomTextFormField(
                readOnly: true,
                controller: bankInputController,
                hintText: "*******",
                hintStyle: CustomTextStyles.bodyLargeGray600,
                obscureText: true,
                contentPadding: EdgeInsets.all(20.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Số điện thoại',
            style: TextStyle(color: Colors.blue),
          ),
          if (phoneNumberError != null)
            Text(
              phoneNumberError!,
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(
            height: 8.h,
          ),
          (_customer?.phoneNumber != null)
              ? CustomTextFormField(
                  focusNode: focusNodes[2],
                  controller: phoneNumberInputController,
                  hintText: "${_customer?.phoneNumber}",
                  hintStyle: CustomTextStyles.bodyLargeGray600,
                  textInputType: TextInputType.phone,
                  contentPadding: EdgeInsets.all(20.h),
                  onChanged: (value) async {
                    final error = await _presenter.validatePhoneNumber(
                        value); // Validate password on change
                    setState(() {
                      phoneNumberError =
                          error; // Clear the error if validation passes
                    });
                  },
                  onTap: () {
                    _unfocusAllExcept(2); // Unfocus all except the email field
                  },
                )
              : Skeleton(width: 300.h, height: 60.h),
        ],
      ),
    );
  }

  Widget _buildIdNumber(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Căn cước công dân',
            style: TextStyle(color: Colors.blue),
          ),
          if (idNumberError != null)
            Text(
              idNumberError!,
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(
            height: 8.h,
          ),
          (_customer?.identificationNumber != null)
              ? CustomTextFormField(
                  readOnly: true,
                  focusNode: focusNodes[3],
                  controller: iDNumberInputController,
                  hintText: "${_customer?.identificationNumber}",
                  hintStyle: CustomTextStyles.bodyLargeGray600,
                  textInputType: TextInputType.number,
                  contentPadding: EdgeInsets.all(20.h),
                  onChanged: (value) {
                    final error = _presenter
                        .validateIdNumber(value); // Validate password on change
                    setState(() {
                      idNumberError =
                          error; // Clear the error if validation passes
                    });
                  },
                  onTap: () {
                    _unfocusAllExcept(3); // Unfocus all except the email field
                  },
                )
              : Skeleton(width: 300.h, height: 60.h),
        ],
      ),
    );
  }

  Widget _buildAddress(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Địa chỉ',
            style: TextStyle(color: Colors.blue),
          ),
          if (addressError != null)
            Text(
              addressError!,
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(
            height: 8.h,
          ),
          (_customer?.address != null)
              ? CustomTextFormField(
                  focusNode: focusNodes[4],
                  controller: addressInputController,
                  hintText: "${_customer?.address}",
                  hintStyle: CustomTextStyles.bodyLargeGray600,
                  contentPadding: EdgeInsets.all(20.h),
                  onChanged: (value) {
                    final error = _presenter
                        .validateAddress(value); // Validate password on change
                    setState(() {
                      addressError =
                          error; // Clear the error if validation passes
                    });
                  },
                  onTap: () {
                    _unfocusAllExcept(4); // Unfocus all except the email field
                  },
                )
              : Skeleton(width: 300.h, height: 60.h),
        ],
      ),
    );
  }

  Widget _buildColumnsave(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true; // Optional: show a loading indicator
              });
              final name = nameInputController.text;
              final idNumber = iDNumberInputController.text;
              final phoneNumber = phoneNumberInputController.text;
              final address = addressInputController.text;

              if (name.isEmpty) {
                setState(() {
                  nameError = 'Không được để trống tên';
                });
              }

              if (phoneNumber.isEmpty) {
                setState(() {
                  phoneNumberError = 'Không được để trống số điện thoại';
                });
              }
              if (address.isEmpty) {
                setState(() {
                  addressError = 'Không được để trống địa chỉ';
                });
              }

              if (nameError == null &&
                  idNumberError == null &&
                  phoneNumberError == null &&
                  addressError == null) {
                // await _presenter.updateCustomer(_customer!.userId.toString(),_customer!.email.toString(), _customer!.password.toString(), firstName, lastName, address, genderValue, idNumber, phoneNumber, _imageUrl.toString(), _customer!.createdDate.toString());
                if (_imageUrl == '' || _imageUrl == null) {
                  await _presenter.updateCustomer(
                      _customer!.userId.toString(),
                      _customer!.email.toString(),
                      _customer!.password.toString(),
                      name,
                      address,
                      idNumber,
                      phoneNumber,
                      _customer!.image.toString(),
                      true);
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.success,
                    body: const Center(
                      child: Text(
                        'Thay đổi thông tin thành công',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    // title: 'Warning',
                    // desc:   'This is also Ignored',
                    btnOkOnPress: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.homePage);
                    },
                  ).show();
                } else {
                  await _presenter.updateCustomer(
                      _customer!.userId.toString(),
                      _customer!.email.toString(),
                      _customer!.password.toString(),
                      name,
                      address,
                      idNumber,
                      phoneNumber,
                      _imageUrl.toString(),
                      true);
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.success,
                    body: const Center(
                      child: Text(
                        'Thay đổi thông tin thành công!!!',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    // title: 'Warning',
                    // desc:   'This is also Ignored',
                    btnOkOnPress: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.homePage);
                    },
                  ).show();
                }
                setState(() {
                  _isLoading = false; // Stop the loading indicator
                });
              }
            },
            text: "Lưu thay đổi",
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.fillBlue,
            buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
          )
        ],
      ),
    );
  }

  @override
  void showValidationError(String field, String message) {
    setState(() {
      if (field == 'name') {
        nameError = message;
      } else if (field == 'idNumber') {
        idNumberError = message;
      } else if (field == 'phoneNumber') {
        phoneNumberError = message;
      } else if (field == 'address') {
        addressError = message;
      }
    });
  }

  // Show loading indicator
  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  // Hide loading indicator
  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onGetCustomerSuccess(User customer) {
    setState(() {
      _customer = customer;
      _error = null;
    });
  }

  @override
  void onGetCustomerError(String error) {
    setState(() {
      _error = error;
      _customer = null;
    });
  }

  @override
  void onImageUploadSuccess(String imageUrl) {
    setState(() {
      _imageUrl = imageUrl;
    });
  }

  @override
  void onImageUploadError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  }

  @override
  void onGetWalletSuccess(Wallet wallet) {
    setState(() {
      _wallet = wallet;
    });
  }
}
