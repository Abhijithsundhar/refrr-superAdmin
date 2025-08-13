
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/color-constants.dart';
import '../../core/globelvariable.dart';

var myColor = Color(0xff002859);
var mySecondColor = Colors.blue.shade300;


class SideMenu extends StatefulWidget {
  const SideMenu({Key? key, required TabController tabController})
      :tabController = tabController,
        super(key: key);
  final TabController tabController;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

// signout(BuildContext context) async {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => LoginPage()));
//   adminMail = '';
//   adminPass = '';
//   final prefence = await SharedPreferences.getInstance();
//   prefence.remove("userId");
//   prefence.remove("password");
// }

class _SideMenuState extends State<SideMenu> {

  int selectedTab = 0;
  int subTab = 0;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.black,
      width: width*.1,
      child: Theme(
        data: ThemeData(highlightColor: const Color(0xff333333)),
        child: Scrollbar(
          child: ListView(
            children: [
               SizedBox(height: height*.1,),
              Column(
                children: [
                  ///DASHBOARD
                  Padding(
                    padding:  EdgeInsets.only(left: width*.02,top: height*.04),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          setState(() {
                            widget.tabController.animateTo(0);
                            subTab = 0;
                            selectedTab = 0;
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Dashboard',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w500,
                                color:selectedTab==0?Colors.white: ColorConstants.sideTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///leads
                  Padding(
                    padding:  EdgeInsets.only(left: width*.02,top: height*.04),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          setState(() {
                            widget.tabController.animateTo((1));
                            subTab = 1;
                            selectedTab = 1;
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Leads',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w500,
                                color: selectedTab==1?Colors.white: ColorConstants.sideTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///firm
                  Padding(
                    padding:  EdgeInsets.only(left: width*.02,top: height*.04),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          setState(() {
                            widget.tabController.animateTo((2));
                            subTab = 2;
                            selectedTab = 2;
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Firms',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w500,
                                color: selectedTab==2?Colors.white: ColorConstants.sideTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///Affliate
                  Padding(
                    padding:  EdgeInsets.only(left: width*.02,top: height*.04),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          setState(() {
                            widget.tabController.animateTo((3));
                            subTab = 3;
                            selectedTab = 3;
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Affiliate',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w500,
                                color: selectedTab==3?Colors.white: ColorConstants.sideTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///Account
                  Padding(
                    padding:  EdgeInsets.only(left: width*.02,top: height*.04),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          setState(() {
                            widget.tabController.animateTo((4));
                            subTab = 4;
                            selectedTab = 4;
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Account',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w500,
                                color: selectedTab==4?Colors.white: ColorConstants.sideTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///Admin
                  Padding(
                    padding:  EdgeInsets.only(left: width*.02,top: height*.04),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          setState(() {
                            widget.tabController.animateTo((4));
                            subTab = 5;
                            selectedTab = 5;
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Admin',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w500,
                                color: selectedTab==5?Colors.white: ColorConstants.sideTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///Settings
                  Padding(
                    padding:  EdgeInsets.only(left: width*.02,top: height*.04),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          setState(() {
                            widget.tabController.animateTo((5));
                            subTab = 6;
                            selectedTab = 6;
                          });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Settings',
                              style: GoogleFonts.firaSansCondensed(
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w500,
                                color: selectedTab==6?Colors.white: ColorConstants.sideTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(height: 10,),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         SizedBox(width: 15,),
                  //         Icon(Icons.logout, size: 18, color: Colors.white,),
                  //         SizedBox(width: 7),
                  //         InkWell(
                  //           child:Text(
                  //             'Log Out',
                  //             style: TextStyle(color: Colors.white,fontSize: 16),
                  //           ),
                  //           // CollaspeItem(
                  //           //   label: "Logout",
                  //           //   icon: Icons.logout,
                  //           //   style: TextStyle(
                  //           //       color: subTab == 14 ? Colors.blue.shade300 : Colors.grey,
                  //           //       fontWeight: subTab == 14 ? FontWeight.bold : FontWeight.normal,
                  //           //       fontSize: 16),
                  //           // ),
                  //           // radius: 30,
                  //           onTap: () async {
                  //             subTab = 15;
                  //             await showDialog(
                  //               context: context,
                  //               builder: (alertDialogContext) {
                  //                 return AlertDialog(
                  //                   shape: OutlineInputBorder(
                  //                       borderSide: BorderSide(color: Colors.white),
                  //                       borderRadius: BorderRadius.circular(15)),
                  //                   backgroundColor: Color(0xff002859),
                  //                   title:  Text('Log Out !',style: GoogleFonts.ubuntu(
                  //                       fontWeight: FontWeight.w400,
                  //                       fontSize: 26,
                  //                       color: Colors.white
                  //                   ),),
                  //                   content:  Text('Do you Want to Logout ?',style: GoogleFonts.ubuntu(
                  //                       fontWeight: FontWeight.w300,
                  //                       fontSize: 17,
                  //                       color: Colors.white
                  //                   ),),
                  //                   actions: [
                  //                     TextButton(
                  //                       onPressed: () =>
                  //                           Navigator.pop(alertDialogContext),
                  //                       child:  Text('Cancel',style: GoogleFonts.ubuntu(
                  //                           fontWeight: FontWeight.w600,
                  //                           fontSize: 16,
                  //                           color: Colors.red
                  //                       ),),
                  //                     ),
                  //                   ],
                  //                 );
                  //               },
                  //             );
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
