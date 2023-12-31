import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/profile_screen/components/details_card.dart';
import 'package:emart_app/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileScreen());

    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
              stream: FirestoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs[0];

                  return SafeArea(
                      child: Column(
                    children: [
                      //edit profile button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.edit, color: whiteColor))
                            .onTap(() {
                          Get.to(() => const EditProfileScreen());
                        }),
                      ),

                      //users details section

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Image.asset(imgProfile2,
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                color: whiteColor,
                              )),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child:
                                  logout.text.fontFamily(semibold).white.make(),
                            )
                          ],
                        ),
                      ),

                      20.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(
                              count: "00",
                              title: "In your Cart",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: "32",
                              title: "In your Wishlist",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: "675",
                              title: "your Orders",
                              width: context.screenWidth / 3.4),
                        ],
                      ),

                      //buttons section

                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(color: lightGrey);
                        },
                        itemCount: profileButtonsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            ),
                            title: profileButtonsList[index]
                                .text
                                .fontFamily(bold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        },
                      )
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make()
                          .box
                          .color(redColor)
                          .make(),
                    ],
                  ));
                }
              })),
    );
  }
}
