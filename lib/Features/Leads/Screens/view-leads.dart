import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntrradminweb/Features/home/homepage.dart';
import '../../../core/common/alertbox.dart';
import '../../../core/common/image-Picker.dart';
import '../../../core/common/lodings.dart';
import '../../../core/common/search.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/common/textEditingControllors.dart';
import '../../../core/globelvariable.dart';
import '../../../model/leads-model.dart';
import '../Controllor/leads-controllor.dart';

class ViewLeadAlertBox extends StatefulWidget {
  final LeadsModel leads;
  const ViewLeadAlertBox({super.key, required this.leads});

  @override
  State<ViewLeadAlertBox> createState() => _ViewLeadAlertBoxState();
}

class _ViewLeadAlertBoxState extends State<ViewLeadAlertBox> {
  @override
  void initState() {
    super.initState();
        leadsFirmNameController.text = widget.leads.name;
        leadsIndustryController.text = widget.leads.industry;
        leadsContactNoController.text = widget.leads.contactNo;
        leadsEmailController.text = widget.leads.mail;
        leadsCountryController.text = widget.leads.country;
        leadsZoneController.text = widget.leads.zone;
        leadsWebsiteController.text = widget.leads.website;
        leadsAddressController.text = widget.leads.address;
        leadsCurrencyController.text = widget.leads.currency;
        leadsAboutFirmController.text = widget.leads.aboutFirm;
        leadsAffiliateController.text = widget.leads.affiliate;
        leadsPasswordController.text = widget.leads.password;
         selectedStatus = widget.leads.status;
        profileUrl = widget.leads.logo ?? '';
        // _inputsReady = true;

  }final Map<int, String> statusOptions = {
    0: 'Pending',
    1: 'Approved',
    2: 'Invoice',
    3: 'Rejected',
  };
  int selectedStatus = 0;
  PickedImage? pickedProfile ;
  String? profileUrl;
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
                    'LEADS',
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
                  // Logo Section
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
                            'Add Logo',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: width * .008,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: height * .002),
        SizedBox(
          width: width * 0.1,
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
                  // ✅ Show picked image
                  return Image.memory(
                    pickedProfile!.bytes,
                    fit: BoxFit.cover,
                  );
                } else if (widget.leads.logo != null && widget.leads.logo!.isNotEmpty) {
                  // ✅ Show Firebase image (from URL)
                  return Image.network(
                    widget.leads.logo!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/icanyonlogo.png',
                        fit: BoxFit.cover,
                      );
                    },
                  );
                } else {
                  // ✅ Show fallback default image
                  return Image.asset(
                    'assets/images/icanyonlogo.png',
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
        ),

                      ],
                    ),
                  ),

                  // Info Fields Section
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
                                Expanded(child: labelWithField('Name of Firm',controller: leadsFirmNameController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Industry',controller: leadsIndustryController)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: labelWithField('Contact No',controller: leadsContactNoController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Country',controller: leadsCountryController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Zone',controller: leadsZoneController)),

                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: labelWithField('Email',controller: leadsEmailController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Password',controller: leadsPasswordController)),
                                SizedBox(width: width * .01),
                                Expanded(child: labelWithField('Affiliate',controller: leadsAffiliateController)),

                              ],
                            ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child:
                          Column(children: [
                            labelWithField('Currency',controller: leadsCurrencyController),
                            labelWithField('Website',controller: leadsWebsiteController),

                            /// 👇 Replace this:
                            // labelWithField('Status',controller: leadsStatusControllor),

                            /// ✅ With this: STATUS DROPDOWN
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height * .005),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: width * .008,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: height * .005),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: width * .005),
                                    height: height * .05,
                                    width: width*.3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: selectedStatus,
                                        onChanged: (int? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              selectedStatus = newValue;
                                              leadsStatusControllor.text = newValue.toString();
                                            });
                                          }
                                        },
                                        items: statusOptions.entries.map((entry) {
                                          return DropdownMenuItem<int>(
                                            value: entry.key,
                                            child: Text(
                                              entry.value,
                                              style: GoogleFonts.firaSansCondensed(
                                                fontSize: width * .008,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(width: width * .01),

                        Expanded(
                          flex: 1,
                          child:
                          labelWithField('Address', maxLines: 3,controller: leadsAddressController),
                        ),
                          ],
                        ),
                            labelWithField('About the Firm', maxLines: 3,controller: leadsAboutFirmController),

                            SizedBox(height: height * .02),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Consumer(
                                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                  return InkWell(
                                    onTap: () async {
                                      if (leadsFirmNameController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Firm Name');
                                        return;
                                      }
                                      if (leadsIndustryController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Industry Type');
                                        return;
                                      }
                                      if (leadsContactNoController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Contact No');
                                        return;
                                      }
                                      if (leadsEmailController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Email Address');
                                        return;
                                      }
                                      if (leadsCountryController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Country');
                                        return;
                                      }
                                      if (leadsZoneController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Zone');
                                        return;
                                      }
                                      if (leadsCurrencyController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Currency');
                                        return;
                                      }

                                      showCustomAlertBox(
                                        context,
                                        'Do you want add this Lead?',
                                            () async {
                                          print('thottuuuuuuuuuuuuuuuuuu');
                                          showLoadings(context);
                                          String profileUrl = widget.leads.logo ?? '';
                                          print('000000000000000000000000000000000');

                                          print('pickedProfile: $pickedProfile');
                                          print('final profileUrl: $profileUrl');
                                          print('000000000000000000000000000000000');

                                          try {

                                            if (pickedProfile != null) {
                                              // User picked a new image: upload it
                                              final uploadedUrl = await ImagePickerHelper.uploadImageToFirebase(pickedProfile!);
                                              if (uploadedUrl != null) {
                                                profileUrl = uploadedUrl;
                                              } else {
                                                showCommonSnackbar(context, 'Image upload failed');
                                                hideLoading(context);
                                                return;
                                              }
                                            }


                                            print('Creating AdminModel...');
                                            final LeadsModel updateleads = widget.leads.copyWith(
                                                logo: profileUrl,
                                                name: leadsFirmNameController.text,
                                                industry: leadsIndustryController.text,
                                                contactNo: leadsContactNoController.text,
                                                mail: leadsEmailController.text,
                                                country: leadsCountryController.text,
                                                zone: leadsZoneController.text,
                                                website: leadsWebsiteController.text,
                                                currency: leadsCurrencyController.text,
                                                address: leadsAddressController.text,
                                                aboutFirm: leadsAboutFirmController.text,
                                                search: setSearchParam(
                                                  leadsFirmNameController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      leadsIndustryController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      leadsContactNoController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      leadsEmailController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      leadsCountryController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      leadsZoneController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      leadsWebsiteController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      leadsCurrencyController.text.trim().toUpperCase(),
                                                ),
                                                status: selectedStatus,
                                                password: leadsPasswordController.text,
                                                affiliate: leadsAffiliateController.text);

                                            print('Calling leads...');
                                            await ref.read(leadsControllerProvider.notifier)
                                                .updateLeads(context: context, leadsModel: updateleads);
                                            print('leads completed');

                                            hideLoading(context);
                                            Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context) => Home(initialTabIndex: 1,)),);


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
                      ]),
                    ),
                  ),
    )],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final image = await ImagePickerHelper.pickImage(); // Your helper method
    if (image != null) {
      setState(() {
        pickedProfile = image;
      });
    }
  }
  Widget labelWithField(String label, {int maxLines = 1,TextEditingController? controller}) {
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
              maxLines: maxLines,
              controller: controller,
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
          )        ],
      ),
    );
  }
}
