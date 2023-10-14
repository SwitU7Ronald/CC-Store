// ignore_for_file: prefer_const_constructors

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
              .box
              .roundedFull
              .clip(Clip.antiAlias)
              .make(),
          10.heightBox,
          ourButton(
              color: redColor,
              onPress: () {},
              textColor: whiteColor,
              title: "Change"),
          const Divider(),
          20.heightBox,
          customTextField(hint: nameHint, title: name, isPass: false),
          customTextField(hint: password, title: password, isPass: true),
          20.heightBox,
          SizedBox(
            width: context.screenWidth - 60,
            child: ourButton(
                color: redColor,
                onPress: () {},
                textColor: whiteColor,
                title: "Save"),
          ),
        ],
      )
          .box
          .white
          .shadowSm
          .padding(const EdgeInsets.all(16))
          .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
          .rounded
          .make(),
    ));
  }
}
