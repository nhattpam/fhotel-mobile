import 'dart:io';

import 'package:fhotel_1/views/register_fill_information/register_fill_information_view.dart';
import 'package:fhotel_1/views/register_fill_information/upload_image_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_export.dart';
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
  String? selectedGender;
  TextEditingController firstNameInputController = TextEditingController();
  TextEditingController lastNameInputController = TextEditingController();
  TextEditingController iDNumberInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController addressInputController = TextEditingController();

  List<String> dropdownItemList = [
    "Male",
    "Female",
  ];

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
      setState(() {
        _imagePath = pickedFile.path;
      });

      await _imagePresenter.pickImageAndUpload(File(_imagePath));
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
                      "Fill Your Information",
                      style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Create an account so you can book hotel!",
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
                            ClipOval( // Use ClipOval to ensure the image stays circular
                              child: Image.network(
                                _imageUrl!,
                                fit: BoxFit.cover, // Adjust the fit as necessary
                                height: 100.h, // Set height to match the container
                                width: 100.h,  // Set width to match the container
                              ),
                            ),
                          if(_imageUrl == null)
                          GestureDetector(
                            onTap: _pickImage,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    _buildFirstNameInput(context),
                    SizedBox(height: 28.h),
                    _buildLastNameInput(context),
                    SizedBox(height: 28.h),
                    _buildIDNumberInput(context),
                    SizedBox(height: 28.h),
                    _buildPhoneNumberInput(context),
                    SizedBox(height: 28.h),
                    _buildAddressInput(context),
                    SizedBox(height: 28.h),
                    Container(
                      child: CustomDropDown(
                        // validator: validateGender,
                        hintText: "Gender",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        items: dropdownItemList,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                    _buildSignInButton(context),
                
                    ///If Login by Facebook or Apple
                    // SizedBox(height: 64.h),
                    // Text(
                    //   "Or continue with",
                    //   style: theme.textTheme.titleSmall,
                    // ),
                    // SizedBox(height: 20.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     CustomIconButton(
                    //       height: 44.h,
                    //       width: 60.h,
                    //       padding: EdgeInsets.all(10.h),
                    //       child: CustomImageView(
                    //         imagePath: ImageConstant.imgIcSharpFacebook,
                    //       ),
                    //     ),
                    //     SizedBox(width: 10.h),
                    //     CustomIconButton(
                    //       height: 44.h,
                    //       width: 60.h,
                    //       padding: EdgeInsets.all(10.h),
                    //       child: CustomImageView(
                    //         imagePath: ImageConstant.imgIcBaselineApple,
                    //       ),
                    //     )
                    //   ],
                    // ),
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
            fillColor: appTheme.blue50,
            controller: firstNameInputController,
            hintText: "First Name",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter.validateFirstName(value); // Validate password on change
              setState(() {
                firstNameError = error; // Clear the error if validation passes
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLastNameInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lastNameError != null)
          Text(
            lastNameError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            fillColor: appTheme.blue50,
            controller: lastNameInputController,
            hintText: "Last Name",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter.validateLastName(value); // Validate password on change
              setState(() {
                lastNameError = error; // Clear the error if validation passes
              });
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
            fillColor: appTheme.blue50,
            controller: iDNumberInputController,
            hintText: "Identification Number",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.number,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter.validateIdNumber(value); // Validate password on change
              setState(() {
                idNumberError = error; // Clear the error if validation passes
              });
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
            fillColor: appTheme.blue50,
            controller: phoneNumberInputController,
            hintText: "Phone Number",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.phone,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter.validatePhoneNumber(value); // Validate password on change
              setState(() {
                phoneNumberError = error; // Clear the error if validation passes
              });
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
            fillColor: appTheme.blue50,
            controller: addressInputController,
            hintText: "Address",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter.validateAddress(value); // Validate password on change
              setState(() {
                addressError = error; // Clear the error if validation passes
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        final firstName = firstNameInputController.text;
        final lastName = lastNameInputController.text;
        final idNumber = iDNumberInputController.text;
        final phoneNumber = phoneNumberInputController.text;
        final address = addressInputController.text;
        bool genderValue = selectedGender == 'Male' ? true : false;
        if (firstName.isEmpty) {
          setState(() {
            firstNameError = 'FirstName cannot be empty';
          });
        }
        if (lastName.isEmpty) {
          setState(() {
            lastNameError = 'Last Name cannot be empty';
          });
        }
        if (idNumber.isEmpty) {
          setState(() {
            idNumberError = 'Identification Number cannot be empty';
          });
        }
        if (phoneNumber.isEmpty) {
          setState(() {
            phoneNumberError = 'Phone Number cannot be empty';
          });
        }
        if (address.isEmpty) {
          setState(() {
            addressError = 'Address cannot be empty';
          });
        }

        if (firstNameError == null && lastNameError == null && idNumberError == null && phoneNumberError == null && addressError == null) {
          _registerpresenter.registerUser(email, password, firstName, lastName, address, genderValue, idNumber, phoneNumber, _imageUrl.toString());

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.initialRoute,
          );
        }
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Sign up",
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
