import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntrradminweb/Features/home/homepage.dart';
import 'package:huntrradminweb/model/admin-model.dart';
import '../../../core/common/alertbox.dart';
import '../../../core/common/image-Picker.dart';
import '../../../core/common/lodings.dart';
import '../../../core/common/search.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/common/textEditingControllors.dart';
import '../../../core/globelvariable.dart';
import '../controllor/admin-controllor.dart';
import 'admin-page.dart';

class AddAdminAlertBox extends StatefulWidget {
  const AddAdminAlertBox({super.key});

  @override
  State<AddAdminAlertBox> createState() => _AddAdminAlertBoxState();
}

class _AddAdminAlertBoxState extends State<AddAdminAlertBox> {
  bool _inputsReady = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        // slNoController = TextEditingController();
        adminZoneController = TextEditingController();
        adminCountryController = TextEditingController();
        adminPhoneController = TextEditingController();
        adminEmailController = TextEditingController();
        adminPasswordController = TextEditingController();
        adminUserIdController = TextEditingController();
        adminNameController = TextEditingController();
        _inputsReady = true;
      });
    });
  }
  PickedImage? pickedProfile;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(width * 0.05),
      child: Container(
        width: width * 0.5,
        height: height * 0.65,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 247, 250, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: !_inputsReady
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: 200,
              leading: Padding(
                padding: EdgeInsets.only(left: width * .01),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Admin',
                    style: GoogleFonts.firaSansCondensed(
                      fontSize: width * .01,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: width * .01),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: width * .015,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: height * .002,
              color: Colors.grey[300],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * .13,
                bottom: height * .015,
              ),
              child: Container(
                width: width * .4,
                height: height * .05,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'GENERAL INFORMATION',
                    style: GoogleFonts.firaSansCondensed(
                      fontSize: width * .008,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * .01,
                      left: width * .01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * .002),
                          child: Text(
                            'Add Photo',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: width * .008,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: height * .002),
        SizedBox(
          width: width * .1,
          child: InkWell(
            onTap: () async {
              final picked = await ImagePickerHelper.pickImage();
              if (picked != null) {
                setState(() {
                  pickedProfile = picked;
                });
              } else {
                print("No image selected.");
              }
            },
            child: pickedProfile != null
                ? CircleAvatar(
              radius: width * .04,
              backgroundImage: MemoryImage(pickedProfile!.bytes),
            )
                : const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/defualtprofile.png'),
            ),
          ),
        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * .03),
                    child: SizedBox(
                      width: width * .35,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Expanded(
                                //   child: labelWithField('Sl. No',
                                //       controller: slNoController),
                                // ),
                                // SizedBox(width: width * .01),
                                Expanded(
                                  child: labelWithField('Name',
                                      controller: adminNameController),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: labelWithField('User ID',
                                      controller: adminUserIdController),
                                ),
                                SizedBox(width: width * .01),
                                Expanded(
                                  child: labelWithField('Password',
                                      controller:
                                      adminPasswordController),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: labelWithField('Email',
                                      controller: adminEmailController),
                                ),
                                SizedBox(width: width * .01),
                                Expanded(
                                  child: labelWithField('Phone NO',
                                      controller: adminPhoneController),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: labelWithField('Country',
                                      controller: adminCountryController),
                                ),
                                SizedBox(width: width * .01),
                                Expanded(
                                  child: labelWithField('Zone',
                                      controller: adminZoneController),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .02),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Consumer(
                                builder: (BuildContext context,
                                    WidgetRef ref, Widget? child) {
                                  return InkWell(
                                      onTap: () async {
                                        if (adminNameController.text.isEmpty) {
                                          showCommonSnackbar(context, 'Please Enter Name');
                                          return;
                                        }
                                        if (adminUserIdController.text.isEmpty) {
                                          showCommonSnackbar(context, 'Please Enter UserId');
                                          return;
                                        }
                                        if (adminPasswordController.text.isEmpty) {
                                          showCommonSnackbar(context, 'Please Enter Password');
                                          return;
                                        }
                                        if (adminEmailController.text.isEmpty) {
                                          showCommonSnackbar(context, 'Please Enter Email Address');
                                          return;
                                        }
                                        if (adminPhoneController.text.isEmpty) {
                                          showCommonSnackbar(context, 'Please Enter Phone No');
                                          return;
                                        }
                                        if (adminCountryController.text.isEmpty) {
                                          showCommonSnackbar(context, 'Please Enter Country');
                                          return;
                                        }
                                        if (adminZoneController.text.isEmpty) {
                                          showCommonSnackbar(context, 'Please Enter Zone');
                                          return;
                                        }

                                        showCustomAlertBox(
                                          context,
                                          'Do you want add this Admin?',
                                              () async {
                                            print('thottuuuuuuuuuuuuuuuuuu');
                                            showLoadings(context);
                                            String profileUrl = '';

                                            try {
                                              if (pickedProfile != null) {
                                                final uploadedUrl = await ImagePickerHelper.uploadImageToFirebase(pickedProfile!);
                                                if (uploadedUrl != null) {
                                                  profileUrl = uploadedUrl;
                                                } else {
                                                  showCommonSnackbar(context, 'Image upload failed');
                                                  hideLoading(context); // ✅ Ensure this is called
                                                  return;
                                                }
                                              }

                                              print('Creating AdminModel...');
                                              final AdminModel admin = AdminModel(
                                                name: adminNameController.text,
                                                phone: adminPhoneController.text,
                                                profile: profileUrl,
                                                zone: adminZoneController.text,
                                                userId: adminUserIdController.text,
                                                password: adminPasswordController.text,
                                                mailId: adminEmailController.text,
                                                delete: false,
                                                createTime: DateTime.now(),
                                                search: setSearchParam(
                                                  adminNameController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      adminPhoneController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      adminZoneController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      adminUserIdController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      adminEmailController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      adminPasswordController.text.trim().toUpperCase(),
                                                ),
                                              );

                                              print('Calling addAdmin...');
                                              await ref.read(adminControllerProvider.notifier)
                                                  .addAdmin(context: context, adminModel: admin);
                                              print('addAdmin completed');

                                              hideLoading(context);

                                              // slNoController.clear();
                                              adminZoneController.clear();
                                              adminCountryController.clear();
                                              adminPhoneController.clear();
                                              adminEmailController.clear();
                                              adminPasswordController.clear();
                                              adminUserIdController.clear();
                                              adminNameController.clear();
                                              setState(() {
                                                pickedProfile = null;
                                              });
                                              Navigator.pushReplacement(context,
                                                MaterialPageRoute(builder: (context) => Home(initialTabIndex: 4,)),);


                                            } catch (e) {
                                              hideLoading(context);
                                              print('Error during save: $e');
                                              showCommonSnackbar(context, 'Something went wrong!');
                                            }
                                          },
                                        );
                                      },

                                    borderRadius:
                                    BorderRadius.circular(6),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * .15,
                                        vertical: height * .015,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                        BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: GoogleFonts
                                            .firaSansCondensed(
                                          fontSize: width * .008,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: height * .02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget labelWithField(String label,
      {int maxLines = 1, TextEditingController? controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * .005),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.firaSansCondensed(
              fontSize: width * .008,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height * .005),
          Container(
            height: maxLines == 1 ? height * .05 : height * .05 * maxLines,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(horizontal: width * .005),
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              textAlignVertical: maxLines == 1
                  ? TextAlignVertical.center
                  : TextAlignVertical.top,
              style: GoogleFonts.firaSansCondensed(
                fontSize: width * .008,
                color: const Color.fromRGBO(74, 77, 78, 1),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
