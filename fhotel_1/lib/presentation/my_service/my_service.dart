import 'package:fhotel_1/presentation/my_service/widgets/my_service_widget.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key})
      : super(
    key: key,
  );
  @override
  MyServiceState createState() => MyServiceState();
}

class MyServiceState extends State<MyService>
    with AutomaticKeepAliveClientMixin<MyService> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 30.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_buildColumnfoodone(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildColumnfoodone(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 24.h,
                  );
                },
                itemCount: 3,
                itemBuilder: (context, index) {
                  return MyServiceWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}