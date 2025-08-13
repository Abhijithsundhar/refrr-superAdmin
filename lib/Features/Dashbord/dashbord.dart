import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/common/dashbord-containers.dart';
import '../../core/globelvariable.dart';
import '../Admin/controllor/admin-controllor.dart';
import '../Affiliates/Controllors/affiliate-controllor.dart';
import '../Leads/Controllor/leads-controllor.dart';

class Dashboard extends ConsumerStatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  List<Map<String, String>> titles = [
    {'title': 'TOTAL LEADS', 'subtitle': '0'},
    {'title': 'TOTAL AFFILIATES', 'subtitle': '0'},
    {'title': 'TOTAL ADMINS', 'subtitle': '0'},
    {'title': 'TOTAL CREDITS', 'subtitle': '0'},
  ];
  List<String> statuses = ['New Lead']; // Start with one default card

  void updateStatus(int index, String newStatus) {
    // Skip updating the first 'New Lead' card
    if (index == 0) return;

    setState(() {
      statuses[index] = newStatus;

      // Only add new card if editing the last card (not index 0)
      if (index == statuses.length - 1) {
        statuses.add('Lead');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCounts();
  }

  void fetchCounts() {
    // Leads Count
    ref.read(leadsStreamProvider('').future).then((leads) {
      setState(() {
        titles[0]['subtitle'] = leads.length.toString();
      });
    });

    // Affiliates Count & Total Credit
    ref.read(affiliateStreamProvider('').future).then((affiliates) {
      int totalAmount = 0;
      for (var affiliate in affiliates) {
        final credit = int.tryParse(affiliate.totalCredit.toString()) ?? 0;
        totalAmount += credit;
      }
      setState(() {
        titles[1]['subtitle'] = affiliates.length.toString();
        titles[3]['subtitle'] = totalAmount.toString();
      });
    });

    // Admins Count
    ref.read(adminStreamProvider('').future).then((admins) {
      setState(() {
        titles[2]['subtitle'] = admins.length.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 250, 252, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * .1),
              // Top 2 rows of stats
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildBox(titles[0]['title']!, titles[0]['subtitle']!),
                  SizedBox(width: width * 0.03),
                  buildBox(titles[1]['title']!, titles[1]['subtitle']!),
                  SizedBox(width: width * 0.03),
                  buildBox(titles[2]['title']!, titles[2]['subtitle']!),
                  SizedBox(width: width * 0.03),
                  buildBox(titles[3]['title']!, titles[3]['subtitle']!),
                  SizedBox(width: width * 0.03),
                  buildBox(titles[2]['title']!, titles[2]['subtitle']!),
                ],
              ),
              SizedBox(height: height * 0.05),

              /// Funnel Title
              Padding(
                padding:  EdgeInsets.only(right: width*.825),
                child: Text(
                  'Funnel',
                  style: GoogleFonts.firaSansCondensed(
                    fontSize: width * 0.015,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              /// 5 Small Containers + Arrows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWithArrowBox(
                    subtitle: "Firm (All)",
                    onTap: () {
                      // Your onTap logic here
                    },
                    icon: Icons.keyboard_arrow_down,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(width: width * 0.03),

                  TextWithArrowBox(
                    subtitle: "Status (All)",
                    onTap: () {
                      // Your onTap logic here
                    },
                    icon: Icons.keyboard_arrow_down,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(width: width * 0.03),

                  TextWithArrowBox(
                    subtitle: "Period",
                    onTap: () {
                      // Your onTap logic here
                    },
                    icon: Icons.calendar_month_sharp,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(width: width * 0.03),

                  TextWithArrowBox(
                    subtitle: "Affiliates (All)",
                    onTap: () {
                      // Your onTap logic here
                    },
                    icon: Icons.keyboard_arrow_down,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(width: width * 0.03),

                  TextWithArrowBox(
                    subtitle: "More",
                    onTap: () {
                      // Your onTap logic here
                    },
                    icon: Icons.keyboard_arrow_down,
                    width: MediaQuery.of(context).size.width,
                  ),

                ],
              ),
              SizedBox(height: height * 0.05),

              /// GridView with 6 per row
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: statuses.length, // Example: 18 items
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, // 6 per row
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 388,
                      height: 354,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: height*.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// firm name and
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: width*.01),
                                      child: Text(
                                        "i-canyon technologies",
                                        style: GoogleFonts.roboto(
                                          fontSize: width*.008,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: width*.01),
                                      child: Text(
                                        "Dubai",
                                        style: GoogleFonts.roboto(
                                          fontSize: width*.007,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // Circular avatar at the end
                                Column(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(right: width*.005),
                                      child: CircleAvatar(
                                        radius: 11,
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(right: width*.005),
                                      child: Text('Abhijith',style: GoogleFonts.roboto(color: Colors.black,fontWeight: FontWeight.w500,
                                          fontSize: width*.006),),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: height*.02,),
                            Padding(
                              padding:  EdgeInsets.only(right: width*.078),
                              child: Text('25/02/2555',style: GoogleFonts.roboto(color: Colors.black,fontWeight: FontWeight.w500,
                                  fontSize: width*.007)),
                            ),
                            SizedBox(height: height*.01,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // First container
                                Container(
                                  width: width * .055,
                                  height: height * .075,
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'WebSite \nDevelopment',
                                      style: GoogleFonts.roboto( fontWeight:FontWeight.w500,fontSize: width*.005,color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),

                                // The vertical line in between
                                Container(
                                  width: 15,                      // thickness of the line
                                  height: height * .001,    // make it a bit shorter than the containers if you like
                                  color: Colors.blue,
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                ),

                                // Second container
                                Container(
                                  width: width * .055,
                                  height: height * .075,
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Abc\nTechnologies',
                                      style: GoogleFonts.roboto( fontWeight:FontWeight.w500,fontSize: width*.005,color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height*.015,),

                            Padding(
                              padding:  EdgeInsets.only(right: width*.088),
                              child: Text('Status',style: GoogleFonts.roboto(color: Colors.black,fontWeight: FontWeight.w500,
                                  fontSize: width*.007)),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: width*.0115,right: width*.0115),
                              child: StatusButton(
                                subtitle: statuses[index],
                                ontap:
                                     () {
                                  showStatusDialog(context, width, (selectedStatus) {
                                    updateStatus(index, selectedStatus);
                                  });
                                  },
                                icon: Icons.keyboard_arrow_down,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ],
                        )
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
