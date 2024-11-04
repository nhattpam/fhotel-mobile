import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/data/models/feedback.dart';
import 'package:fhotel_1/presenters/create_feedback_presenter.dart';
import 'package:fhotel_1/views/write_review/create_feedback_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReviewScreen extends StatefulWidget {
  final String reservationId;
  final Feedbacks feedback;
  const WriteReviewScreen({Key? key, required this.reservationId, required this.feedback}) : super(key: key);

  @override
  WriteReviewScreenState createState() => WriteReviewScreenState();
}

class WriteReviewScreenState extends State<WriteReviewScreen> implements CreateFeedbackView{
  TextEditingController titleInputController = TextEditingController();

  TextEditingController reviewsInputController = TextEditingController();

  int rating = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CreateFeedbackPresenter _presenter;
@override
  void initState() {
    super.initState();
    _presenter = CreateFeedbackPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    print(widget.feedback);
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppbar(context),
      body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                decoration:
                    BoxDecoration(color: appTheme.gray10001, boxShadow: [
                  BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.16),
                      spreadRadius: 2.h,
                      blurRadius: 2.h,
                      offset: (Offset(0, -1)))
                ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16.h),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Text(
                                "Đánh giá: ",
                                style: TextStyle(color: Colors.black),
                              ),
                              Container(
                                width: 210,
                                child: RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amberAccent),
                                    onRatingUpdate: (rate) async {
                                      setState(() {
                                        rating = rate.toInt();
                                      });
                                    },
                                    itemSize: 30),
                              )
                            ],
                          ),
                          SizedBox(height: 16.h),
                          _buildReviewInput(context),
                          SizedBox(height: 18.h),
                          _buildChnphng(context)
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h)
                  ],
                ),
              ),
            ),
          )),
    ));
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
        text: "Gửi đánh giá",
        margin: EdgeInsets.only(left: 7.h),
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
              SizedBox(width: 8.h),
              AppbarIconbutton(
                imagePath: ImageConstant.imgDivider,
                margin: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 4.h,
                ),
              )
            ],
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  Widget _buildReviewInput(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Adjust height as needed
      child: CustomTextFormField(
        maxLines: 22,
        textInputType: TextInputType.multiline,
        controller: reviewsInputController,
        hintText: 'Viết đánh giá của bạn ở đây',
        hintStyle: TextStyle(
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.fromLTRB(12.h, 16.h, 12.h, 12.h),
      ),
    );
  }

  Widget _buildChnphng(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        if (reviewsInputController.text.isEmpty || rating == 0) {
          String message;
          if (reviewsInputController.text.isEmpty && rating == 0) {
            message = 'Vui lòng nhập đánh giá và đánh giá số sao!!';
          } else if (reviewsInputController.text.isEmpty) {
            message = 'Vui lòng nhập đánh giá!!';
          } else {
            message = 'Vui lòng đánh giá số sao!!';
          }
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(
              child: Text(
                message,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            btnCancelOnPress: () {},
          ).show();
        } else {
          // Check if feedback is empty to determine create or update
          if (widget.feedback.feedbackId == null || widget.feedback.feedbackId!.isEmpty) {
            // Create new feedback
            _presenter.createFeedbacks(
              widget.reservationId,
              reviewsInputController.text,
              rating,
              DateFormat('yyyy-MM-dd').format(DateTime.now()), // Ensure the method call includes parentheses to get the current date-time
            );
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              body: const Center(
                child: Text(
                  'Cảm ơn bạn đã để lại đánh giá!!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          } else {
            // Update existing feedback
            _presenter.updateFeedback((widget.feedback.feedbackId).toString(),(widget.feedback.reservationId).toString(), reviewsInputController.text, rating, (widget.feedback.createdDate).toString());
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              body: const Center(
                child: Text(
                  'Đánh giá của bạn đã được cập nhật!!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          }
        }
      },
      text: "Đánh giá",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }


  @override
  void onGetFeedbackSuccess(Feedbacks feedback) {
    // TODO: implement onGetFeedbackSuccess
    setState(() {

    });
  }

}
