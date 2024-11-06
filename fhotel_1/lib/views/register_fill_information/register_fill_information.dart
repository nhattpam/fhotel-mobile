import 'dart:io';

import 'package:email_otp/email_otp.dart';
import 'package:fhotel_1/views/register_fill_information/register_fill_information_view.dart';
import 'package:fhotel_1/views/register_fill_information/upload_image_view.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../../data/repository/upload_image_service.dart';
import '../../presenters/register_presenter.dart';
import '../../presenters/upload_image_presenter.dart';

// ignore_for_file: must_be_immutable
class RegisterFillInformation extends StatefulWidget {
  @override
  RegisterFillInformationState createState() => RegisterFillInformationState();
}

class RegisterFillInformationState extends State<RegisterFillInformation>
    implements RegisterFillInformationView, ImageView {
  final List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());
  String? selectedGender;
  TextEditingController firstNameInputController = TextEditingController();
  TextEditingController lastNameInputController = TextEditingController();
  TextEditingController iDNumberInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController addressInputController = TextEditingController();

  late RegisterPresenter _registerpresenter;
  late ImagePresenter _imagePresenter;
  String _imagePath = "";
  final picker = ImagePicker();
  bool _isLoading = false;
  String? _imageUrl;

  late String email;
  late String password;

  String? firstNameError;
  String? lastNameError;
  String? idNumberError;
  String? phoneNumberError;
  String? addressError;

  @override
  void initState() {
    super.initState();
    _registerpresenter = RegisterPresenter(this);
    _imagePresenter = ImagePresenter(this, ImageService());
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    // Cancel any subscriptions or async operations here
    firstNameInputController.dispose();
    lastNameInputController.dispose();
    iDNumberInputController.dispose();
    phoneNumberInputController.dispose();
    addressInputController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the arguments passed safely in didChangeDependencies
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = args['email'];
    password = args['password'];
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
          SnackBar(content: Text('Hình ảnh phải nhỏ hơn 5 MB')),
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
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          height: SizeUtils.height,
          // decoration: BoxDecoration(
          //   color: appTheme.whiteA700,
          //   image: DecorationImage(
          //     image: AssetImage(
          //       ImageConstant.imgLoginScreen,
          //     ),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child: Container(
            padding: EdgeInsets.all(30.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hãy điền thông tin của bạn",
                    style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Tạo tài khoản để trải nghiệm những dịch vụ của chúng tôi!!",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(height: 20.h),
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
                        if (_imageUrl != null)
                          ClipOval(
                            // Use ClipOval to ensure the image stays circular
                            child: Image.network(
                              _imageUrl!,
                              fit: BoxFit.cover,
                              // Adjust the fit as necessary
                              height: 100.h,
                              // Set height to match the container
                              width: 100.h, // Set width to match the container
                            ),
                          ),
                        if (_imageUrl == null)
                          GestureDetector(
                            onTap: _pickImage,
                          )
                      ],
                    ),
                  ),
                  SizedBox(height: 28.h),
                  _buildFirstNameInput(context),
                  SizedBox(height: 28.h),
                  _buildIDNumberInput(context),
                  SizedBox(height: 28.h),
                  _buildPhoneNumberInput(context),
                  SizedBox(height: 28.h),
                  _buildAddressInput(context),
                  SizedBox(height: 28.h),
                  _buildSignInButton(context),
                  SizedBox(height: 8.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstNameInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tên",
          style: TextStyle(color: Colors.blue),
        ),
        if (firstNameError != null)
          Text(
            firstNameError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[0],
            fillColor: appTheme.blue50,
            controller: firstNameInputController,
            hintText: "Tên",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter
                  .validateName(value); // Validate password on change
              setState(() {
                firstNameError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(0); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIDNumberInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Căn cước công dân",
          style: TextStyle(color: Colors.blue),
        ),
        if (idNumberError != null)
          Text(
            idNumberError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[2],
            fillColor: appTheme.blue50,
            controller: iDNumberInputController,
            hintText: "Căn cước công dân",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.number,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _registerpresenter
                  .validateIdNumber(value); // Validate password on change
              setState(() {
                idNumberError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(2); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Số điện thoại",
          style: TextStyle(color: Colors.blue),
        ),
        if (phoneNumberError != null)
          Text(
            phoneNumberError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[3],
            fillColor: appTheme.blue50,
            controller: phoneNumberInputController,
            hintText: "Số điện thoại",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.phone,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _registerpresenter
                  .validatePhoneNumber(value); // Validate password on change
              setState(() {
                phoneNumberError =
                    error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(3); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddressInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Địa chỉ",
          style: TextStyle(color: Colors.blue),
        ),
        if (addressError != null)
          Text(
            addressError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[4],
            fillColor: appTheme.blue50,
            controller: addressInputController,
            hintText: "Địa chỉ",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter
                  .validateAddress(value); // Validate password on change
              setState(() {
                addressError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(4); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        final name = firstNameInputController.text;
        final idNumber = iDNumberInputController.text;
        final phoneNumber = phoneNumberInputController.text;
        final address = addressInputController.text;
        if (name.isEmpty) {
          setState(() {
            firstNameError = 'Không được để trống tên';
          });
        }
        if (idNumber.isEmpty) {
          setState(() {
            idNumberError = 'Không được để trống Căn cước công dân';
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
        if (firstNameError == null &&
            lastNameError == null &&
            idNumberError == null &&
            phoneNumberError == null &&
            addressError == null) {
          User user = User(
              email: email,
              password: password,
              name: name,
              address: address,
              identificationNumber: idNumber,
              phoneNumber: phoneNumber,
              image: _imageUrl.toString(),
              isActive: false);
          await _registerpresenter.registerUser(email, password, name, address, idNumber, phoneNumber, _imageUrl.toString());

          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            body: const Center(
              child: Text(
                'Vui lòng kiểm tra OTP đã được gửi về số điện thoại của bạn!!!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            btnOkOnPress: () async {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.otpScreen,
                arguments: {
                  'user': user,
                 },
              );
            },
          ).show();
        }
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Đăng ký",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  @override
  void showValidationError(String field, String message) {
    setState(() {
      if (field == 'firstName') {
        firstNameError = message;
      } else if (field == 'lastName') {
        lastNameError = message;
      } else if (field == 'idNumber') {
        idNumberError = message;
      } else if (field == 'phoneNumber') {
        phoneNumberError = message;
      } else if (field == 'address') {
        addressError = message;
      }
    });
  }

  // Show success message or navigate to another screen on successful registration
  @override
  void onRegisterSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Registration successful!'),
    ));
  }

  // Show error message if registration fails
  @override
  void onRegisterError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Registration failed: $error'),
    ));
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
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
}
