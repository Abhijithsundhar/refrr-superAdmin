
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntrradminweb/core/common/textEditingControllors.dart';
import '../../../core/common/alertbox.dart';
import '../../../core/common/image-Picker.dart';
import '../../../core/common/lodings.dart';
import '../../../core/common/search.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/globelvariable.dart';
import '../../../model/agent_model.dart';
import '../../Affiliates/Controllors/industry-controllor.dart';
import '../../home/homepage.dart';
import '../Controllors/agent-controllor.dart';

class AddAgentAlertBox extends StatefulWidget {
  const AddAgentAlertBox({super.key});

  @override
  State<AddAgentAlertBox> createState() => _AddAgentAlertBoxState();
}

class _AddAgentAlertBoxState extends State<AddAgentAlertBox> {
  List<String> selectedIndustries = [];
  Future<List<String>?> _showIndustrySelectionDialog(
      BuildContext context, List<String> options) {
    List<String> tempSelected = List.from(selectedIndustries);

    return showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Industries'),
              content: SizedBox(
                width: width * 0.4,
                height: height * 0.4,
                child: ListView(
                  children: options.map((industry) {
                    final isSelected = tempSelected.contains(industry);
                    return CheckboxListTile(
                      title: Text(industry),
                      value: isSelected,
                      onChanged: (value) {
                        setDialogState(() {
                          if (value == true) {
                            if (tempSelected.length < 3) {
                              tempSelected.add(industry);
                            } else {
                              showCommonSnackbar(context, 'Only 3 industries can be selected');
                            }
                          } else {
                            tempSelected.remove(industry);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // Cancel
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, tempSelected); // Return selected
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }  @override
  void initState() {
    super.initState();
    agentsStatusController.text = '';
    agentsLevelController.text = '';
    agentsEmailController.text = '';
    agentsPasswordController.text = '';
    agentsUserIdController.text = '';
    agentsZoneController.text = '';
    agentsPhoneNoController.text = '';
    agentsNameController.text = '';
    agentsCountryController.text = '';
    agentsLanguageController.text = '';
    pickedProfile = null;
  }
  PickedImage? pickedProfile;
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
                    'Agent',
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
                            child: pickedProfile != null?
                            CircleAvatar(
                                radius: width*.04,
                                backgroundColor: Color.fromRGBO(247, 247, 250, 1),
                                child: Image.memory(pickedProfile!.bytes,fit: BoxFit.fill,))
                            :CircleAvatar(
                                radius: width*.04,
                                backgroundColor: Color.fromRGBO(247, 247, 250, 1),
                                child: Image.asset('assets/images/defualtprofile.png',fit: BoxFit.fill,)),
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
                            // Row 1
                            Row(
                              children: [
                                Expanded(child: labelWithField('Name', controller: agentsNameController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Phone NO', controller: agentsPhoneNoController)),
                              ],
                            ),

                            // Row 2
                            Row(
                              children: [
                                Expanded(child: labelWithField('User ID', controller: agentsUserIdController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Password', controller: agentsPasswordController)),
                              ],
                            ),

                            // Row 3
                            Row(
                              children: [
                                Expanded(child: labelWithField('Email', controller: agentsEmailController)),
                                SizedBox(width: width * .01),
                                Expanded(
                                  child: labelWithField(
                                    'Language',
                                    controller: agentsLanguageController,
                                    options: [
                                      'English', 'Arabic (عربي)', 'Hindi (हिन्दी)',
                                      'Malayalam (മലയാളം)', 'Russian (Русский)', 'Japanese (日本語)',
                                      'Chinese (中国人)', 'Kannada (ಕನ್ನಡ)', 'Tamil (தமிழ்)', 'Telugu (తెలుగు)',
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Row 4
                            Row(
                              children: [
                                Expanded(
                                  child: labelWithField(
                                    'Country',
                                    controller: agentsCountryController,
                                    options: ['India', 'UAE', 'Abu Dhabi', 'Qatar', 'Bahrain'],
                                  ),
                                ),
                                SizedBox(width: width * .01),
                                Expanded(
                                  child: labelWithField(
                                    'Zone',
                                    controller: agentsZoneController,
                                    options: [
                                      'Manama', 'Muharraq', 'Northern Governorate', 'Southern Governorate', 'Central Governorate',
                                      'Doha', 'Al Wakrah', 'Al Khor', 'Umm Salal', 'Al Rayyan',
                                      'Abu Dhabi City', 'Al Ain', 'Al Dhafra',
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Row 5 - Qualification & Experience
                            Row(
                              children: [
                                Expanded(child: labelWithField('Qualification', controller: agentsQualificationController,
                                  options: [
                                    'SSLC',
                                    'Higher Secondary',
                                    'Diploma',
                                    'ITI (Industrial Training Institute)',
                                    'Polytechnic Diploma',
                                    'Bachelors Degree',
                                    'Masters Degree',
                                    'M.Phil',
                                    'Ph.D / Doctorate',
                                    'Professional Certification',
                                    'Other',
                                  ],
                                )),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Experience', controller: agentsExperienceController,
                                    options: [
                                      'Less than 1 year',
                                      '1 year',
                                      '2 years',
                                      '3 years',
                                      '4 years',
                                      '5 years',
                                      '6 years',
                                      '7 years',
                                      '8 years',
                                      '8+ years',
                                    ],
                                )),
                              ],
                            ),

                            // Row 6 - Industry & Level
                            Row(
                              children: [
                                Expanded(
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      final industriesAsync = ref.watch(industryStreamProvider(""));

                                      return industriesAsync.when(
                                        data: (industryList) {
                                          final allIndustries = industryList.map((e) => e.industryName).toList();

                                          return GestureDetector(
                                            onTap: () async {
                                              final selected = await _showIndustrySelectionDialog(context, allIndustries);
                                              if (selected != null) {
                                                setState(() {
                                                  selectedIndustries = selected;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: height * .05,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: width * .005),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      selectedIndustries.isNotEmpty
                                                          ? selectedIndustries.join(', ')
                                                          : 'Select Industries (max 3)',
                                                      style: GoogleFonts.firaSansCondensed(
                                                        fontSize: width * .008,
                                                        color: Colors.black,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        loading: () => const CircularProgressIndicator(),
                                        error: (e, _) => Text('Failed to load industries'),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: width * .01),

                                Expanded(
                                  child: labelWithField(
                                    'Level',
                                    controller: agentsLevelController,
                                    options: ['01', '02', '03', '04', '05'],
                                  ),
                                ),
                              ],
                            ),
                            // Row 7 - More Info (full width)
                            labelWithField('More Info', controller: agentsMoreInfoController, maxLines: 4,
                            ),

                            SizedBox(height: height * .02),

                            /// Save Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: Consumer(builder: (context, ref, child) {
                                return InkWell(
                                    onTap: () async {
                                      if (agentsNameController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Name');
                                        return;
                                      }
                                      if (agentsPhoneNoController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Phone No');
                                        return;
                                      }
                                      if (agentsUserIdController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter UserId');
                                        return;
                                      }
                                      if (agentsPasswordController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Password');
                                        return;
                                      }
                                      if (agentsEmailController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Email Id');
                                        return;
                                      }
                                      if (agentsPhoneNoController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Language');
                                        return;
                                      }
                                      if (agentsCountryController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Country');
                                        return;
                                      }
                                      if (agentsZoneController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Zone');
                                        return;
                                      }if (agentsLevelController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Level');
                                        return;
                                      }
                                      showCustomAlertBox(
                                        context,
                                        'Do you want add this Agent?',
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
                                            final AgentModel agents = AgentModel(
                                                subAgents: [],
                                                name: agentsNameController.text,
                                                profile: profileUrl??'',
                                                phone: agentsPhoneNoController.text,
                                                zone: agentsZoneController.text,
                                                userId: agentsUserIdController.text,
                                                password: agentsPasswordController.text,
                                                mailId: agentsEmailController.text,
                                                level: agentsLevelController.text,
                                                status: 0,
                                                country:agentsCountryController.text,
                                                delete: false,
                                                createTime: DateTime.now(),
                                                search: setSearchParam(
                                                  agentsNameController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsPhoneNoController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsUserIdController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsPasswordController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsCountryController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsZoneController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsEmailController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsLevelController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsQualificationController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsExperienceController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      agentsStatusController.text.trim().toUpperCase(),
                                                ),
                                                addedBy: '',
                                                withdrawalRequest: [],
                                                balance: [],
                                                totalCredits: [],
                                                totalWithdrawals: [],
                                                totalBalance: 0,
                                                totalCredit: 0,
                                                totalWithrew: 0,
                                                language: agentsLanguageController.text,
                                                qualification: agentsQualificationController.text,
                                                experience: agentsExperienceController.text,
                                                moreInfo: agentsMoreInfoController.text,
                                                industry: selectedIndustries,
                                                leadScore: 0) ;

                                            print('Calling addAdmin...');
                                            await ref.read(agentControllerProvider.notifier)
                                                .addAgent(context: context, agentModel: agents);
                                            print('addAdmin completed');

                                            hideLoading(context);

                                            /// clear all controllers
                                            agentsStatusController.clear();
                                            agentsLevelController.clear();
                                            agentsEmailController.clear();
                                            agentsPasswordController.clear();
                                            agentsUserIdController.clear();
                                            agentsZoneController.clear();
                                            agentsPhoneNoController.clear();
                                            agentsNameController.clear();
                                            agentsCountryController.clear();
                                            agentsLanguageController.clear();
                                            agentsQualificationController.clear();
                                            agentsExperienceController.clear();
                                            agentsIndustryController.clear();
                                            agentsMoreInfoController.clear();

                                            setState(() {
                                              pickedProfile = null;
                                              selectedIndustries = [];
                                            });
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
                value: controller!.text.isNotEmpty ? controller.text : null,
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
                  controller!.text = value!;
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
