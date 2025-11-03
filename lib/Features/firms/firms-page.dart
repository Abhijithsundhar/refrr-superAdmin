import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntrradminweb/model/leads-model.dart';

import '../../core/constants/color-constants.dart';
import '../../core/globelvariable.dart';
import '../../model/leads-model.dart';
import '../Leads/Controllor/leads-controllor.dart';
import '../Leads/Screens/add-service.dart';
import '../Leads/Screens/view-firms.dart';
import '../Leads/Screens/view-leads.dart';
import '../home/homepage.dart';

class AgentPage extends ConsumerStatefulWidget {


  @override
  _LeadsTablePageState createState() => _LeadsTablePageState();
}

class _LeadsTablePageState extends ConsumerState<AgentPage> {
  int currentPage = 0;
  final int rowsPerPage = 10;
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final  lead = ref.watch(leadsControllerProvider.notifier).getLeads(searchQuery);
    print('user!.userId');
    print(user);
    print('user!.userId');
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(248, 250, 252, 1),
          title: Row(
            children: [
              SizedBox(
                width: width * 0.08,
                child: Image.asset('assets/images/icanyonlogo.png'),
              ),
              Spacer(),
              SizedBox(
                width: width * 0.3,
                height: height * 0.05,
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase().trim();
                      currentPage = 0; // Reset page on new search
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: GoogleFonts.firaSansCondensed(
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.sideTextColor,
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding:
                    EdgeInsets.only(left: width * 0.01, right: width * 0.02),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * 0.006),
              InkWell(
                onTap: () {
                  // Future.delayed(Duration(milliseconds : 50),(){
                  //   showDialog(
                  //     context: context,
                  //     // barrierDismissible: false,
                  //     builder: (_) =>  AddLeadsAlertBox(),
                  //   );
                  // });

                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: width * 0.01,
                  child: Icon(Icons.add, size: width * 0.012, color: Colors.white),
                ),
              ),
              SizedBox(width: width * 0.006),
              CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: width * 0.01,
                  child:
                  // user.isEmpty?
                  Image.asset('assets/images/defualtprofile.png',fit: BoxFit.fill)
                // : Image.network(user,fit: BoxFit.fill,),
              ),
              Icon(Icons.keyboard_arrow_down, size: width * 0.01),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(248, 250, 252, 1),
        body: ref.watch(leadsStreamProvider('')).when(
          data: (leadsList) {
            // flatten all firms from all leads
            final allFirms = leadsList.expand((lead) => lead.firms).where((firm) =>
                firm.name.toLowerCase().contains(searchQuery)).toList();

            if (allFirms.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.1),
                  child: Text(
                    'No firms available',
                    style: GoogleFonts.firaSansCondensed(
                      fontSize: width * 0.01,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }

            final paginatedData = allFirms.skip(currentPage * rowsPerPage).take(rowsPerPage).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 16),

                  // Header Row
                  Container(
                    color: Color.fromRGBO(248, 250, 252, 1),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    child: Row(
                      children: [
                        buildListCell('S.I.NO', width, flex: 1),
                        buildListCell('Name', width, flex: 3),
                        buildListCell('Location', width, flex: 3),
                        buildListCell('Industry type', width, flex: 3),
                        buildListCell('Contact No', width, flex: 3),
                        buildListCell('Email', width, flex: 2),
                        buildListCell('', width, flex: 1),
                        buildListCell('', width, flex: 1),
                        buildListCell('', width, flex: 1),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: paginatedData.length,
                    itemBuilder: (context, index) {
                      final firm = paginatedData[index];

                      return Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 8.0),
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        child: Row(
                          children: [
                            buildListCell('${currentPage * rowsPerPage + index + 1}', width, flex: 1),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.025,
                                      height: height * 0.035,
                                      child: Image.network(
                                        firm.logo,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/defultFirm.jpg', // Your local default image
                                            fit: BoxFit.contain,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: height * 0.002),
                                    Flexible(
                                      child: Text(
                                        firm.name,
                                        style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * 0.0085,
                                          fontWeight: FontWeight.w500,
                                          color: ColorConstants.tableRowColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            buildListCell(firm.address, width, flex: 3),
                            buildListCell(firm.industryType, width, flex: 2),
                            buildListCell(firm.phoneNo.toString(), width, flex: 2),
                            buildListCell(firm.email, width, flex: 2),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  // show firm details
                                  showDialog(
                                    context: context, builder: (_) => ViewFirms(firm: firm),
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    width: width * 0.042,
                                    height: height * 0.04,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.editButtonColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'View',
                                        style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * 0.0075,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  // find which LeadsModel this firm belongs to
                                  final parentLead = leadsList.firstWhere(
                                        (lead) => lead.firms.any((f) => f.reference == firm.reference),
                                  );

                                  if (parentLead == null) {
                                    // this means no lead found for this firm
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('No lead found for this firm')),
                                    );
                                    return;
                                  }

                                  // now you have firm and correct lead
                                  showDialog(
                                    context: context,
                                    builder: (_) => AddService(firm: firm, lead: parentLead),
                                  );
                                },

                                child: Center(
                                  child: Container(
                                    width: width * 0.042,
                                    height: height * 0.04,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.editButtonColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Service',
                                        style: GoogleFonts.firaSansCondensed(
                                          fontSize: width * 0.0075,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: height * 0.02),
                ],
              ),
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => Center(child: CircularProgressIndicator()),
        ),

        bottomNavigationBar: ref.watch(leadsStreamProvider('')).when(
          data: (leadsList) {
            final allFirms = leadsList
                .expand((lead) => lead.firms)
                .where((firm) =>
                firm.name.toLowerCase().contains(searchQuery))
                .toList();

            final totalPages = (allFirms.length / rowsPerPage).ceil();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.016, vertical: height * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('SHOW', style: GoogleFonts.firaSansCondensed(fontSize: width * 0.007, fontWeight: FontWeight.w600)),
                      SizedBox(width: width * 0.003),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.004, vertical: height * 0.004),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 1.5),
                        ),
                        child: Text(
                          '$rowsPerPage',
                          style: GoogleFonts.firaSansCondensed(fontSize: width * 0.007, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: width * 0.003),
                      Text('ENTRIES', style: GoogleFonts.firaSansCondensed(fontSize: width * 0.007, fontWeight: FontWeight.w600)),
                      SizedBox(width: width * 0.3),
                      Text(
                        'Showing ${allFirms.isEmpty ? 0 : currentPage * rowsPerPage + 1} - ${(currentPage + 1) * rowsPerPage > allFirms.length ? allFirms.length : (currentPage + 1) * rowsPerPage} of ${allFirms.length} entries',
                        style: GoogleFonts.firaSansCondensed(fontSize: width * 0.007, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(width: width * 0.21),
                  GestureDetector(
                    onTap: currentPage > 0 ? () => setState(() => currentPage--) : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.01),
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                      child: Text('Previous', style: GoogleFonts.firaSansCondensed(fontSize: width * 0.007, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                  Wrap(
                    spacing: 8,
                    children: List.generate(
                      totalPages,
                          (index) => GestureDetector(
                        onTap: () => setState(() => currentPage = index),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.004, vertical: height * 0.004),
                          decoration: BoxDecoration(
                            color: currentPage == index ? Colors.black : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: width * 0.007,
                              fontWeight: FontWeight.w600,
                              color: currentPage == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                  GestureDetector(
                    onTap: currentPage < totalPages - 1 ? () => setState(() => currentPage++) : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.01),
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                      child: Text('Next', style: GoogleFonts.firaSansCondensed(fontSize: width * 0.007, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (_, __) => SizedBox(),
          loading: () => SizedBox(),
        ),

      ) ;
  }

  Widget buildListCell(String text, double width,
      {Color? color, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.firaSansCondensed(
            fontSize: width * 0.0085,
            fontWeight: FontWeight.w500,
            color: color ?? ColorConstants.tableRowColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
