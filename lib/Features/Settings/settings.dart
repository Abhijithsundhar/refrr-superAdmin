import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color-constants.dart';
import '../../core/globelvariable.dart';
import '../home/homepage.dart';

class Settings extends ConsumerStatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(248, 250, 252, 1),
        title: Row(
          children: [
            SizedBox(
              width: width * 0.08,
              child: Image.asset('assets/images/icanyonlogo.png'),
            ),
            Spacer(),
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: width * 0.01,
              child:
              // user!.profile.isEmpty?
              Image.asset('assets/images/defualtprofile.png',fit: BoxFit.fill)
                  // :Image.network(user!.profile,fit: BoxFit.fill,),
            ),
            Icon(Icons.keyboard_arrow_down, size: width * 0.01),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(248, 250, 252, 1),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 7/ 2, // Adjusts card shape
          children: [
            {
              'title': 'Master data settings',
              'description':
                  'Master data is the core data that is absolutely essential for running \noperations',
              'icon':
                  'assets/images/masterdata.png', // Change to .svg if you handle SVGs
            },
            {
              'title': 'User data settings',
              'description':
                  'Master data is the core data that is absolutely essential for running \noperations',
              'icon': 'assets/images/Plandata.png',
            },
            {
              'title': 'Plan data settings',
              'description':
                  'Master data is the core data that is absolutely essential for running  \noperations',
              'icon': 'assets/images/userdata.png',
            },
          ].map((data) {
            return Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(8.0), // smaller padding
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width*.05,
                      height: height*.05,
                      child: Image.asset(data['icon']!),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['title']!,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: width * 0.01,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(61, 63, 69, 1),
                            ),
                          ),
                          SizedBox(height: height * 0.004),
                          Text(
                            data['description']!,
                            style: GoogleFonts.firaSansCondensed(
                              fontSize: width * 0.008,
                              fontWeight: FontWeight.w400,
                              color:Color.fromRGBO(108, 122, 145, 1),
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
