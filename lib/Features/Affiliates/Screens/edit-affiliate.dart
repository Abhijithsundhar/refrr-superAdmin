
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntrradminweb/Features/Affiliates/Controllors/affiliate-controllor.dart';
import 'package:huntrradminweb/Features/Affiliates/Screens/affiliate-page.dart';
import 'package:huntrradminweb/core/common/textEditingControllors.dart';
import 'package:huntrradminweb/model/affiliate-model.dart';

import '../../../core/common/alertbox.dart';
import '../../../core/common/image-Picker.dart';
import '../../../core/common/lodings.dart';
import '../../../core/common/search.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/globelvariable.dart';
import '../../home/homepage.dart';

class EditAffiliateAlertBox extends StatefulWidget {
  final AffiliateModel affiliate;
  const EditAffiliateAlertBox({super.key, required this.affiliate});

  @override
  State<EditAffiliateAlertBox> createState() => _EditAffiliateAlertBoxState();
}

class _EditAffiliateAlertBoxState extends State<EditAffiliateAlertBox> {
  PickedImage? pickedProfile ;
  String? profileUrl;
  @override
  @override
  void initState() {
    super.initState();

    // Map status int to string
    final statusMap = {
      0: 'pending',
      1: 'approved',
      2: 'suspended',
    };

    affiliateStatusController.text = statusMap[widget.affiliate.status] ?? 'pending';
    affiliateLevelController.text = widget.affiliate.level;
    affiliateEmailController.text = widget.affiliate.mailId;
    affiliatePasswordController.text = widget.affiliate.password;
    affiliateUserIdController.text = widget.affiliate.userId;
    affiliateZoneController.text = widget.affiliate.zone.trim();
    affiliatePhoneNoController.text = widget.affiliate.phone;
    affiliateNameController.text = widget.affiliate.name;
    affiliateCountryController.text = widget.affiliate.country;
    affiliateLanguageController.text = widget.affiliate.language.trim();
    profileUrl = widget.affiliate.profile ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(width * 0.05), // padding around the dialog
      child: Container(
        width: width * 0.5,
        height: height * 0.85,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 247, 250, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: 200,
              leading: Padding(
                padding: EdgeInsets.only(left: width * .01),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Affiliate',
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

            // Bottom line after AppBar
            Container(
              height: height * .002,
              color: Colors.grey[300],
            ),

            // GENERAL INFORMATION TITLE
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

            // Content Section
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo Section
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
                            'Photo',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: width * .008,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: height * .002),
                        Container(
                          width: width * .1,
                          height: height * .15,
                          color: Colors.white,
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
                            child: Builder(
                              builder: (_) {
                                if (pickedProfile != null) {
                                  // ✅ Show picked image in round shape
                                  return CircleAvatar(
                                    radius: width*.03,
                                    backgroundImage: MemoryImage(pickedProfile!.bytes),
                                  );
                                } else if (widget.affiliate.profile != null && widget.affiliate.profile.isNotEmpty) {
                                  // ✅ Show Firebase image (from URL) in round shape
                                  return CircleAvatar(radius: width*.03,
                                    backgroundImage: NetworkImage(widget.affiliate.profile),
                                    onBackgroundImageError: (error, stackTrace) {
                                      // Handle error by using fallback image below
                                    },
                                    child: Container(), // Still needs a child to trigger fallback in error
                                  );
                                } else {
                                  // ✅ Show fallback default image in round shape
                                  return CircleAvatar(radius: width*.03,
                                    backgroundImage: AssetImage('assets/images/defualtprofile.png'),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Info Fields Section
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
                                // Expanded(child: labelWithField('Sl. No')),
                                // SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Name',controller: affiliateNameController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Phone NO',controller: affiliatePhoneNoController)),

                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: labelWithField('User ID',controller: affiliateUserIdController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Password',controller: affiliatePasswordController)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: labelWithField('Email',controller: affiliateEmailController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Language',controller: affiliateLanguageController,
                                  options: ['English', 'Hindi', 'Malayalam','Arabic'],)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: labelWithField('Country',controller: affiliateCountryController,
                                  options: ['India', 'UAE', 'Abu Dhabi','Qatar','Bahrain'],)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Zone',controller: affiliateZoneController,
                                    options:['Manama', 'Muharraq', 'Northern Governorate', 'Southern Governorate','Central Governorate',
                                      'Doha', 'Al Wakrah', 'Al Khor', 'Umm Salal', 'Al Rayyan','Abu Dhabi City',
                                      'Al Ain', 'Al Dhafra',])),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: labelWithField('Level',controller: affiliateLevelController,
                                  options: ['01','02','03','04','05'],)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Status',controller: affiliateStatusController,
                                  options: ['pending','approved','suspended',],)),
                              ],
                            ),

                            SizedBox(height: height * .02),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Consumer(builder: (context, ref, child) {
                                return InkWell(
                                  onTap: () async {
                                    if (affiliateNameController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter Name');
                                      return;
                                    }
                                    if (affiliatePhoneNoController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter Phone No');
                                      return;
                                    }
                                    if (affiliateUserIdController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter UserId');
                                      return;
                                    }
                                    if (affiliatePasswordController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter Password');
                                      return;
                                    }
                                    if (affiliateEmailController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter Email Id');
                                      return;
                                    }
                                    if (affiliatePhoneNoController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter Language');
                                      return;
                                    }
                                    if (affiliateCountryController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter Country');
                                      return;
                                    }
                                    if (affiliateZoneController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter Zone');
                                      return;
                                    }if (affiliateLevelController.text.isEmpty) {
                                      showCommonSnackbar(context, 'Please Enter Level');
                                      return;
                                    }
                                    showCustomAlertBox(
                                      context,
                                      'Do you want add this Affiliate?',
                                          () async {
                                        print('thottuuuuuuuuuuuuuuuuuu');
                                        showLoadings(context);
                                        String profileUrl = widget.affiliate.profile ?? '';
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
                                          int status;
                                          final text = affiliateStatusController.text.trim().toLowerCase();

                                          if (text == 'pending') {
                                            status = 0;
                                          } else if (text == 'approved') {
                                            status = 1;
                                          } else if (text == 'suspended') {
                                            status = 2;
                                          } else {
                                            status = 0; // default or fallback
                                          }
                                          print('Creating AdminModel...');
                                          final AffiliateModel updateAffiliate = widget.affiliate.copyWith(
                                              name: affiliateNameController.text,
                                              profile: profileUrl??'',
                                              phone: affiliatePhoneNoController.text,
                                              zone: affiliateZoneController.text,
                                              userId: affiliateUserIdController.text,
                                              password: affiliatePasswordController.text,
                                              mailId: affiliateEmailController.text,
                                              level: affiliateLevelController.text,
                                              status: status,
                                              country:affiliateCountryController.text,
                                              search: setSearchParam(
                                                affiliateNameController.text.trim().toUpperCase() +
                                                    ' ' +
                                                    affiliatePhoneNoController.text.trim().toUpperCase() +
                                                    ' ' +
                                                    affiliateUserIdController.text.trim().toUpperCase() +
                                                    ' ' +
                                                    affiliatePasswordController.text.trim().toUpperCase() +
                                                    ' ' +
                                                    affiliateCountryController.text.trim().toUpperCase() +
                                                    ' ' +
                                                    affiliateZoneController.text.trim().toUpperCase() +
                                                    ' ' +
                                                    affiliateEmailController.text.trim().toUpperCase() +
                                                    ' ' +
                                                    affiliateLevelController.text.trim().toUpperCase() +
                                                    ' ' +
                                                    affiliateStatusController.text.trim().toUpperCase(),
                                              ),
                                              language: affiliateLanguageController.text) ;

                                          print('Calling addAdmin...');
                                          await ref.read(affiliateControllerProvider.notifier)
                                              .updateAffiliate(context: context, affiliateModel: updateAffiliate);
                                          print('addAdmin completed');

                                          hideLoading(context);

                                          // affiliateStatusController.clear();
                                          // affiliateLevelController.clear();
                                          // affiliateEmailController.clear();
                                          // affiliatePasswordController.clear();
                                          // affiliateUserIdController.clear();
                                          // affiliateZoneController.clear();
                                          // affiliatePhoneNoController.clear();
                                          // affiliateNameController.clear();
                                          // affiliateCountryController.clear();
                                          // setState(() {
                                          //   pickedProfile = null;
                                          // });
                                          Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) => Home(initialTabIndex: 2,)),);


                                        } catch (e) {
                                          hideLoading(context);
                                          print('Error during save: $e');
                                          showCommonSnackbar(context, 'Something went wrong!');
                                        }
                                      },
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * .15,
                                      vertical: height * .015,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: width * .008,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },),
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

  Widget labelWithField(
      String label, {
        int maxLines = 1,
        TextEditingController? controller,
        List<String>? options, // 👈 new param
      }) {
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

          /// If options are provided, render Dropdown
          if (options != null)
            Container(
              height: height * .05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(horizontal: width * .005),
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                value: options.contains(controller!.text) ? controller.text : null,
                items: options
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: GoogleFonts.firaSansCondensed(
                      fontSize: width * .008,
                      color: const Color.fromRGBO(74, 77, 78, 1),
                    ),
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  controller.text = value!;
                },
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            )

          /// Else render TextField
          else
            Container(
              height:
              maxLines == 1 ? height * .05 : height * .05 * maxLines,
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
