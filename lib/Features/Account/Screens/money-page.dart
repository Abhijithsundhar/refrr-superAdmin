import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntrradminweb/Features/Account/Controller/offer-controller.dart';
import 'package:huntrradminweb/Features/Affiliates/Controllors/affiliate-controllor.dart';
import 'package:huntrradminweb/Features/home/homepage.dart';
import 'package:huntrradminweb/core/common/snackbar.dart';
import 'package:huntrradminweb/core/common/textEditingControllors.dart';
import 'package:huntrradminweb/model/affiliate-model.dart';
import 'package:huntrradminweb/model/balance-amount-model.dart';
import 'package:huntrradminweb/model/offer-model.dart';
import 'package:huntrradminweb/model/total-credit-model.dart';
import 'package:huntrradminweb/model/total-withdrawal-model.dart';
import 'package:huntrradminweb/model/withdrew-requst-model.dart';
import '../../../core/common/alertbox.dart';
import '../../../core/common/image-Picker.dart';
import '../../../core/common/lodings.dart';
import '../../../core/globelvariable.dart';
import 'package:intl/intl.dart';


class AddCashDetails extends ConsumerStatefulWidget {
  final AffiliateModel affiliate;
  const AddCashDetails({super.key, required this.affiliate});

  @override
  ConsumerState<AddCashDetails> createState() => _AddCashDetailsState();
}

class _AddCashDetailsState extends ConsumerState<AddCashDetails> {
  List<BalanceModel> balance = [];
  List<TotalCreditModel> totalCredits = [];
  List<TotalWithdrawalsModel> totalWithdrawals = [];
  List<dynamic> requsts = [];
  DateTime? selectedOfferEndDate;
  String? selectedMode;
  PickedImage? pickedProfile;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    affiliateNameController.text = widget.affiliate.name;
    affiliatePhoneNoController.text = widget.affiliate.phone;
    balance = List.from(widget.affiliate.balance ?? []);
    totalCredits = List.from(widget.affiliate.totalCredits ?? []);
    totalWithdrawals = List.from(widget.affiliate.totalWithdrawals ?? []);
    requsts = List.from(widget.affiliate.withdrawalRequest ?? []);

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(width * 0.05),
      child: Container(
        width: width * 0.4,
        height: height * 0.85,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 247, 250, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              iconTheme: IconThemeData(color: Colors.transparent),
              backgroundColor: const Color.fromRGBO(247, 247, 250, 1),
              elevation: 0,
              leadingWidth: 200,
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

            /// Content
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Right Section - Fields and Details
                  Padding(
                    padding: EdgeInsets.only(left: width * .03),
                    child: SizedBox(
                      width: width * .35,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start, // Align children to the top
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        widget.affiliate.profile.isEmpty?
                                        CircleAvatar(
                                          child: Image.asset('assets/images/defualtprofile.png',fit: BoxFit.fill,),
                                        ):CircleAvatar(
                                          child: Image.network(widget.affiliate.profile,fit: BoxFit.fill),
                                        ),
                                        SizedBox(width:width*.004),
                                        Padding(
                                          padding: EdgeInsets.only(top: height * 0.01),
                                          child: Text(
                                            affiliateNameController.text,
                                            style: GoogleFonts.firaSansCondensed(
                                              fontSize: width * .008,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded( // To push content to the right and handle overflow
                                      child: Column(
                                        children: [
                                          /// Balance Summary
                                          Padding(
                                            padding: EdgeInsets.only(left: width * .088),
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Available Balance :',
                                                    style: GoogleFonts.firaSansCondensed(
                                                      fontSize: width * .008,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color.fromRGBO(101, 101, 101, 1),
                                                    ),
                                                  ),
                                                  SizedBox(width: width * .003),
                                                  Container(
                                                    width: width * 0.06,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: height * 0.008,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        width: width * 0.0003,
                                                        color: Color.fromRGBO(101, 101, 101, 1),
                                                      ),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Text(
                                                      'AED ${widget.affiliate.totalBalance ?? 0}',
                                                      style: GoogleFonts.firaSansCondensed(
                                                        fontSize: width * .008,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: height * .01),
                                          /// Credit Summary
                                          Padding(
                                            padding: EdgeInsets.only(left: width * .1),
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Total Credited :',
                                                    style: GoogleFonts.firaSansCondensed(
                                                      fontSize: width * .008,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color.fromRGBO(101, 101, 101, 1),
                                                    ),
                                                  ),
                                                  SizedBox(width: width * .003),
                                                  Container(
                                                    width: width * 0.06,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: height * 0.008,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        width: width * 0.0003,
                                                        color: Color.fromRGBO(101, 101, 101, 1),
                                                      ),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Text(
                                                      'AED ${widget.affiliate.totalCredit ??0}',
                                                      style: GoogleFonts.firaSansCondensed(
                                                        fontSize: width * .008,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: height * .04),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: height*.04,),

                                /// Request Section
                                Text('Request',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: width * .01,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(height: height*.02,),
                                  ref.watch(affiliateStreamProvider(''))
                                      .when(data: (affiliateList){
                                    final allRequests = affiliateList
                                        .expand((data) => data.withdrawalRequest.where((req) => req.status == false))
                                        .toList()
                                      ..sort((a, b) => b.requstTime.compareTo(a.requstTime));

                                    if (allRequests.isEmpty) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: height * .02),
                                          child: Text(
                                            'No requests',
                                            style: GoogleFonts.firaSansCondensed(
                                              fontSize: width * 0.01,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: allRequests.length,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final sData = allRequests[index];

                                            return Padding(
                                              padding: EdgeInsets.symmetric(vertical: height * 0.005),
                                              child: Row(
                                                children: [
                                                  /// Amount
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Amount',
                                                          style: GoogleFonts.firaSansCondensed(
                                                              fontSize: width * .007)),
                                                      Container(
                                                        width: width * 0.09, // same fixed width
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(
                                                          vertical: height * 0.008,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            width: width * 0.0003,
                                                            color: Color.fromRGBO(101, 101, 101, 1),
                                                          ),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Text(
                                                          'AED ${sData.amount}',
                                                          style: GoogleFonts.firaSansCondensed(
                                                            fontSize: width * .008,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: width * .01),
                                                  /// Date
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Date',
                                                          style: GoogleFonts.firaSansCondensed(
                                                              fontSize: width * .007)),
                                                      Container(
                                                        width: width * 0.06, // same fixed width
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(
                                                          vertical: height * 0.008,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            width: width * 0.0003,
                                                            color: Color.fromRGBO(101, 101, 101, 1),
                                                          ),
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Text(DateFormat('dd-MM-yyyy').format(sData.requstTime),
                                                          style: GoogleFonts.firaSansCondensed(
                                                            fontSize: width * .008,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: width * .03),

                                                  /// accept
                                                  Column(
                                                    children: [
                                                      Text('',
                                                          style: GoogleFonts.firaSansCondensed(
                                                              fontSize: width * .007)),
                                                      InkWell(
                                                        onTap: (){
                                                          showCustomAlertBox(context,'Do you want accept this request?',
                                                                  () async {
                                                                // Step 1: Find the affiliate who owns this sData
                                                                final affiliate = affiliateList.firstWhere(
                                                                      (aff) => aff.withdrawalRequest.contains(sData),
                                                                );

                                                                totalCredits.add(
                                                                    TotalCreditModel(
                                                                        amount: double.tryParse(sData.amount.toString()) ?? 0.0,
                                                                        addedTime: DateTime.now(),
                                                                        acceptBy: sData.acceptBy,
                                                                        currency: sData.currency,
                                                                        image: sData.image,
                                                                        description: sData.description)
                                                                );
                                                                /// Step 2: Replace only the matching request with an updated one
                                                                final updatedRequests = affiliate.withdrawalRequest.map((req) {
                                                                  if (req == sData) {
                                                                    return req.copyWith(status: true);
                                                                  }
                                                                  return req;
                                                                }).toList();

                                                                /// Step 3: Update affiliate model
                                                                final updatedAffiliate = affiliate.copyWith(
                                                                    totalCredits: totalCredits,
                                                                    totalBalance: widget.affiliate.totalBalance + (int.tryParse(sData.amount.toString()) ?? 0),
                                                                    totalCredit: widget.affiliate.totalCredit + (int.tryParse(sData.amount.toString()) ?? 0),
                                                                    withdrawalRequest: updatedRequests);

                                                                /// Step 4: Call update function with the full affiliate model
                                                                await ref.read(affiliateControllerProvider.notifier)
                                                                    .updateAffiliate(context: context, affiliateModel: updatedAffiliate);
                                                                showCommonSnackbar(context, 'Request accepted successfully');


                                                                  });
                                                        },
                                                        child: Container(
                                                          width: width * 0.06, // same fixed width
                                                          alignment: Alignment.center,
                                                          padding: EdgeInsets.symmetric(
                                                            vertical: height * 0.008,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                              width: width * 0.0003,
                                                              color: Colors.green,
                                                            ),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Text(
                                                            'Accept',
                                                            style: GoogleFonts.firaSansCondensed(
                                                              fontSize: width * .008,
                                                              color: Colors.green,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: width * .01),

                                                  /// delete
                                                  Column(
                                                    children: [
                                                      Text('',
                                                          style: GoogleFonts.firaSansCondensed(
                                                              fontSize: width * .007)),
                                                      InkWell(
                                                        onTap: (){
                                                          showCustomAlertBox(context,'Do you want delete this request?',
                                                              () async {
                                                                // Step 1: Find the affiliate who owns this sData
                                                                final affiliate = affiliateList.firstWhere(
                                                                      (aff) => aff.withdrawalRequest.contains(sData),
                                                                );

                                                                 /// Step 2: Replace only the matching request with an updated one
                                                                final updatedRequests = affiliate.withdrawalRequest.map((req) {
                                                                  if (req == sData) {
                                                                    return req.copyWith(status: true);
                                                                  }
                                                                  return req;
                                                                }).toList();

                                                                 /// Step 3: Update affiliate model
                                                                final updatedAffiliate = affiliate.copyWith(withdrawalRequest: updatedRequests);

                                                                /// Step 4: Call update function with the full affiliate model
                                                                await ref.read(affiliateControllerProvider.notifier)
                                                                    .updateAffiliate(context: context, affiliateModel: updatedAffiliate);
                                                                showCommonSnackbar(context, 'Request deleted successfully');


                                                              });
                                                        },
                                                        child: Container(
                                                          width: width * 0.06, // same fixed width
                                                          alignment: Alignment.center,
                                                          padding: EdgeInsets.symmetric(
                                                            vertical: height * 0.008,
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                              width: width * 0.0003,
                                                              color: Colors.red,
                                                            ),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Text(
                                                            'Delete',
                                                            style: GoogleFonts.firaSansCondensed(
                                                              fontSize: width * .008,
                                                              color: Colors.red,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            );
                                          },
                                        );
                                  },
                                    error: (error, stackTrace) => Text(error.toString()),
                                    loading: () => Center(child: CircularProgressIndicator()),),

                                SizedBox(height: height * .04),

                                /// Add Money Section
                                Text('Add Money',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(height: height * .01),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Enter Amount',
                                            style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Color.fromRGBO(101, 101, 101, 1),
                                          fontWeight: FontWeight.w400,
                                        )),
                                        Container(
                                          width: width*.22,
                                          height: height*.05,
                                          color: Colors.white,
                                          child: TextField(
                                            controller: affiliateAddMoneyController,
                                            decoration: InputDecoration(
                                              hintText: ' ',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: width * .01),
                                    Column(
                                      children: [
                                        Text(''), 
                                        Consumer(
                                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                            return InkWell(
                                              onTap: (){
                                                if(affiliateAddMoneyController.text.isEmpty){
                                                  showCommonSnackbar(context, 'Please Enter The Amount For Add');
                                                }else{
                                                  showCustomAlertBox(
                                                      context,"Do you want to add this money to${widget.affiliate.name}'s account?",
                                                          (){
                                                            showLoadings(context);
                                                            totalCredits.add(
                                                                TotalCreditModel(
                                                                    amount: double.tryParse(affiliateAddMoneyController.text) ?? 0.0,
                                                                    addedTime: DateTime.now(),
                                                                    acceptBy: '',
                                                                    currency: 'AED',
                                                                    image: '',
                                                                    description: '')
                                                            );
                                                            // Convert to int
                                                            final AffiliateModel updateAffiliate = widget.affiliate.copyWith(
                                                                totalCredits: totalCredits,
                                                                totalBalance: widget.affiliate.totalBalance + (int.tryParse(affiliateAddMoneyController.text) ?? 0),
                                                                totalCredit: widget.affiliate.totalCredit + (int.tryParse(affiliateAddMoneyController.text) ?? 0),
                                                            );
                                                                 print(' ------------------');
                                                                 print(updateAffiliate);
                                                                 print(updateAffiliate.reference);

                                                                 print('--------------------');
                                                            try {
                                                              ref.read(affiliateControllerProvider.notifier)
                                                                  .updateAffiliate(affiliateModel: updateAffiliate, context: context);
                                                              hideLoading(context);
                                                              showCommonSnackbar(context, 'Money added successfully');
                                                                  affiliateAddMoneyController.clear();
                                                                  affiliateWithdrawalMoneyController.clear();
                                                              Navigator.pushReplacement(context,
                                                                MaterialPageRoute(builder: (context) => Home(initialTabIndex: 3)),
                                                              );
                                                            } catch (e) {
                                                              hideLoading(context);
                                                              showCommonSnackbar(context, 'Failed to update: $e');
                                                            }
                                                            print('******************');
                                                            print(updateAffiliate.name);
                                                            print(updateAffiliate.totalCredits);
                                                            print(updateAffiliate.reference);

                                                            print('*******************');

                                                          }
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: width * 0.09,
                                                height: height*.05,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: height * 0.008,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                    width: width * 0.0003,
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'Add',
                                                  style: GoogleFonts.firaSansCondensed(
                                                    fontSize: width * .008,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          },
                                          
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * .04),

                                /// Withdrawal Section
                                Text('Withdrawal',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(height: height * .01),

                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Text('Enter Amount',style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Color.fromRGBO(101, 101, 101, 1),
                                          fontWeight: FontWeight.w400,
                                        )),
                                        Container(
                                          width: width * .22,
                                          height: height * .05,
                                          color: Colors.white,
                                          child: TextField(
                                            controller: affiliateWithdrawalMoneyController,
                                            // textAlign: TextAlign.center, // Horizontal center
                                            // textAlignVertical: TextAlignVertical.center, // Vertical center
                                            decoration: InputDecoration(
                                              hintText: ' ',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: width * .01),
                                    Column(
                                      children: [
                                        Text(''),
                                        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                          return InkWell(
                                            onTap: (){
                                              if(affiliateWithdrawalMoneyController.text.isEmpty){
                                                showCommonSnackbar(context, 'Please Enter The Amount For Withdrew');
                                              }else{
                                                showCustomAlertBox(
                                                    context,"Do you want to withdrew this money from ${widget.affiliate.name}'s account?",
                                                        (){
                                                      showLoadings(context);
                                                      totalWithdrawals.add(
                                                          TotalWithdrawalsModel(
                                                              amount: double.tryParse(affiliateWithdrawalMoneyController.text) ?? 0.0,
                                                              addedTime: DateTime.now(),
                                                              acceptBy: '',
                                                              currency: 'AED',
                                                              status: 0,
                                                              image: '',
                                                              description: '')
                                                      );

                                                      final AffiliateModel updateAffiliate = widget.affiliate.copyWith(
                                                          totalWithdrawals: totalWithdrawals,
                                                          totalBalance: widget.affiliate.totalCredit - (int.tryParse(affiliateWithdrawalMoneyController.text) ?? 0),
                                                          totalWithrew: widget.affiliate.totalWithrew + (int.tryParse(affiliateWithdrawalMoneyController.text) ?? 0),
                                                      ) ;
                                                      print(' ------------------');
                                                      print(updateAffiliate);
                                                      print(updateAffiliate.reference);

                                                      print('--------------------');
                                                      try {
                                                        ref.read(affiliateControllerProvider.notifier)
                                                            .updateAffiliate(affiliateModel: updateAffiliate, context: context);
                                                        hideLoading(context);
                                                        showCommonSnackbar(context, 'Money Withdrawal successfull');
                                                        affiliateAddMoneyController.clear();
                                                        affiliateWithdrawalMoneyController.clear();
                                                        Navigator.pushReplacement(context,
                                                          MaterialPageRoute(builder: (context) => Home(initialTabIndex: 3)),
                                                        );
                                                      } catch (e) {
                                                        hideLoading(context);
                                                        showCommonSnackbar(context, 'Failed to update: $e');
                                                      }
                                                      print('******************');
                                                      print(updateAffiliate.name);
                                                      print(updateAffiliate.totalCredits);
                                                      print(updateAffiliate.reference);

                                                      print('*******************');

                                                    }
                                                );
                                              }
                                            },
                                          child: Container(
                                          width: width * 0.09,
                                          height: height*.05,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                          vertical: height * 0.008,
                                          ),
                                          decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(
                                          width: width * 0.0003,
                                          color: Colors.black,
                                          ),
                                          borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                          'Withdrawal',
                                          style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                          ),
                                          ),
                                          );
                                        },

                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: height * .04),

                                /// Add Offer
                                Text('Add Offer',
                                    style: GoogleFonts.firaSansCondensed(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(height: height * .01),

                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Name',style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Color.fromRGBO(101, 101, 101, 1),
                                          fontWeight: FontWeight.w400,
                                        )),
                                        Container(
                                          width: width * .155,
                                          height: height * .05,
                                          color: Colors.white,
                                          child: TextField(
                                            controller: offerNameController,
                                            // textAlign: TextAlign.center, // Horizontal center
                                            // textAlignVertical: TextAlignVertical.center, // Vertical center
                                            decoration: InputDecoration(
                                              hintText: ' ',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: width * .01),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Offer Amount',style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Color.fromRGBO(101, 101, 101, 1),
                                          fontWeight: FontWeight.w400,
                                        )),
                                        Container(
                                          width: width * .155,
                                          height: height * .05,
                                          color: Colors.white,
                                          child: TextField(
                                            controller: offerAmountController,
                                            // textAlign: TextAlign.center, // Horizontal center
                                            // textAlignVertical: TextAlignVertical.center, // Vertical center
                                            decoration: InputDecoration(
                                              hintText: ' ',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Currency type',style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Color.fromRGBO(101, 101, 101, 1),
                                          fontWeight: FontWeight.w400,
                                        )),

                                        Container(
                                          width: width * .155,
                                          height: height * .06,
                                          color: Colors.white,
                                          child: DropdownButtonFormField<String>(
                                            value: offerCurrencyController.text.isEmpty ? null : offerCurrencyController.text,
                                            items: ['AED', 'USD', 'INR', 'EUR', 'AUD'].map((String currency) {
                                              return DropdownMenuItem<String>(
                                                value: currency,
                                                child: Text(currency),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                offerCurrencyController.text = newValue;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Select Currency',
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    SizedBox(width: width * .01),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Description',style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Color.fromRGBO(101, 101, 101, 1),
                                          fontWeight: FontWeight.w400,
                                        )),

                                        Container(
                                          width: width * .155,
                                          height: height * .1, // increase height
                                          color: Colors.white,
                                          child: TextField(
                                            controller: offerDescriptionController,
                                            maxLines: 3, // or null for unlimited lines
                                            decoration: InputDecoration(
                                              hintText: '',
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets.all(12),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('End Date',style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Color.fromRGBO(101, 101, 101, 1),
                                          fontWeight: FontWeight.w400,
                                        )),

                                        Container(
                                          width: width * .155,
                                          height: height * .05,
                                          color: Colors.white,
                                          child: TextField(
                                            controller: offerEndDateController,
                                            readOnly: true, // prevent keyboard
                                            onTap: () async {
                                              final DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: selectedOfferEndDate ?? DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                              );

                                              if (pickedDate != null) {
                                                selectedOfferEndDate = pickedDate; // store as DateTime
                                                offerEndDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate); // show in UI
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: ' ',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: width * .01),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Mode',style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * .008,
                                          color: Color.fromRGBO(101, 101, 101, 1),
                                          fontWeight: FontWeight.w400,
                                        )),
                                       Container(
                          width: width * .155,
                          height: height * .06,
                          color: Colors.white,
                          child: DropdownButtonFormField<String>(
                            value: selectedMode,
                            items: ['public', 'private'].map((String mode) {
                              return DropdownMenuItem<String>(
                                value: mode,
                                child: Text(mode),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedMode = newValue;
                                  offerModeController.text = newValue;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Select Mode',
                            ),
                          ),
                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: height*.01,),

                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
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
                                          child: Container(
                                            height: height * .2,
                                            width: width * .15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.grey, // Set border color
                                                width: 1.5,         // Optional: adjust thickness
                                              ),
                                            ),
                                            alignment: Alignment.center, // Center the text
                                            child: pickedProfile == null? Text('ADD IMAGE'):CircleAvatar(
                                                radius: width*.04,
                                                backgroundColor: Color.fromRGBO(247, 247, 250, 1),
                                                child: Image.memory(pickedProfile!.bytes,fit: BoxFit.fill,)),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: width*.01,),
                                    Column(
                                      children: [
                                        Text(''),
                                        InkWell(
                                          onTap: () async {
                                            if (offerNameController.text.isEmpty) {
                                              showCommonSnackbar(context, 'Please Enter Name');
                                              return;
                                            }
                                            if (offerAmountController.text.isEmpty) {
                                              showCommonSnackbar(context, 'Please Enter Amount');
                                              return;
                                            }
                                            if (offerCurrencyController.text.isEmpty) {
                                              showCommonSnackbar(context, 'Please Select Currency type');
                                              return;
                                            }
                                            if (offerDescriptionController.text.isEmpty) {
                                              showCommonSnackbar(context, 'Please Enter Description');
                                              return;
                                            }
                                            if (offerModeController.text.isEmpty) {
                                              showCommonSnackbar(context, 'Please Select Mode');
                                              return;
                                            }
                                            if (offerEndDateController.text.isEmpty) {
                                              showCommonSnackbar(context, 'Please Select End Date');
                                              return;
                                            }
                                            showCustomAlertBox(
                                              context,
                                              'Do you want add this offer?',
                                                  () async {
                                                 String profileUrl = '';
                                                 if (pickedProfile != null) {
                                                   final uploadedUrl = await ImagePickerHelper
                                                       .uploadImageToFirebase(
                                                       pickedProfile!);
                                                   if (uploadedUrl != null) {
                                                     profileUrl = uploadedUrl;
                                                   } else {
                                                     showCommonSnackbar(context,
                                                         'Image upload failed');
                                                     hideLoading(
                                                         context); // ✅ Ensure this is called
                                                     return;
                                                   }

                                                   print(
                                                       'thottuuuuuuuuuuuuuuuuuu');
                                                   try {
                                                     print('Creating offer...');
                                                     final OfferModel offer = OfferModel(
                                                         name: offerNameController
                                                             .text,
                                                         amount: offerAmountController
                                                             .text,
                                                         endDate: selectedOfferEndDate ??
                                                             DateTime.now(),
                                                         delete: false,
                                                         createTime: DateTime
                                                             .now(),
                                                         currency: offerCurrencyController
                                                             .text,
                                                         description: offerDescriptionController
                                                             .text,
                                                         mode: offerModeController
                                                             .text ?? '',
                                                         affiliate: selectedMode ==
                                                             'private' ? widget
                                                             .affiliate.id : '',
                                                         image: profileUrl ?? ''
                                                     );

                                                     print(
                                                         'Calling addAdmin...');
                                                     await ref.read(
                                                         offerControllerProvider
                                                             .notifier)
                                                         .addOffer(
                                                         context: context,
                                                         offerModel: offer);
                                                     print(
                                                         'addAdmin completed');

                                                     offerNameController
                                                         .clear();
                                                     offerAmountController
                                                         .clear();
                                                     leadsContactNoController
                                                         .clear();
                                                     offerDescriptionController
                                                         .clear();
                                                     offerCurrencyController
                                                         .clear();
                                                     offerEndDateController
                                                         .clear();
                                                   } catch (e) {
                                                     print(
                                                         'Error during save: $e');
                                                     showCommonSnackbar(context,
                                                         'Something went wrong!');
                                                   }
                                                 }},
                                            );
                                          },
                                          child: Container(
                                            width: width * 0.155,
                                            height: height*.05,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                              vertical: height * 0.008,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              border: Border.all(
                                                width: width * 0.0003,
                                                color: Colors.black,
                                              ),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              'Add Offer',
                                              style: GoogleFonts.firaSansCondensed(
                                                fontSize: width * .008,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: height * .02),
                              ],
                            ),
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

  Widget labelWithField(String label, {int maxLines = 1,TextEditingController? controllor}) {
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
              controller: controllor,
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
