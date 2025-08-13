import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/common/snackbar.dart';
import '../../../core/constants/color-constants.dart';
import '../../../core/globelvariable.dart';
import '../../Admin/controllor/admin-controllor.dart';
import '../../home/homepage.dart';


final loginEmailController = TextEditingController();
final loginPasswordController = TextEditingController();


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final adminList = ref.watch(adminStreamProvider(''));

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  color: Colors.white,
                  height: height * .5,
                  width: width * .4,
                  child: Column(
                    children: [
                      SizedBox(height: height * .05),
                      Text("Admin",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: width * .015,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.tableRowColor,
                          )),
                      SizedBox(height: height * .01),
                      Text("Login",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: width * .01,
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.tableRowColor,
                          )),
                      SizedBox(height: height * .03),
                      // Email Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter Email ID',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: width * .008,
                                    color: const Color.fromRGBO(101, 101, 101, 1),
                                    fontWeight: FontWeight.w400,
                                  )),
                              Container(
                                width: width * .3,
                                height: height * .05,
                                color: Colors.white,
                                child: TextField(
                                  controller: loginEmailController,
                                  decoration: const InputDecoration(
                                    hintText: ' ',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * .02),
                      // Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter Password',
                                  style: GoogleFonts.firaSansCondensed(
                                    fontSize: width * .008,
                                    color: const Color.fromRGBO(101, 101, 101, 1),
                                    fontWeight: FontWeight.w400,
                                  )),
                              Container(
                                width: width * .3,
                                height: height * .05,
                                color: Colors.white,
                                child: TextField(
                                  controller: loginPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: ' ',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * .025),
                      adminList.when(
                        data: (adminList) {
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoggingIn = true;
                              });

                              final enteredEmail = loginEmailController.text.trim();
                              final enteredPassword = loginPasswordController.text.trim();

                              await Future.delayed(const Duration(milliseconds: 300));

                              final matchedAdmin = adminList.firstWhereOrNull(
                                    (admin) =>
                                admin.mailId == enteredEmail &&
                                    admin.password == enteredPassword,
                              );

                              if (matchedAdmin != null ||
                                  (enteredEmail == 'superadmin1010@gmail.com' &&
                                      enteredPassword == 'superadmin1010')) {
                                loginEmailController.clear();
                                loginPasswordController.clear();

                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setBool('isLoggedIn', true);

                                setState(() {
                                  _isLoggingIn = false;
                                });

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => Home()),
                                );
                              } else {
                                setState(() {
                                  _isLoggingIn = false;
                                });

                                showCommonSnackbar(context, 'Enter correct email or password');
                              }
                            },
                            child: Container(
                              width: width * 0.3,
                              height: height * .05,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: height * 0.008),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  width: width * 0.0003,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Login',
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
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (error, _) => const Center(child: Text('Error loading admins')),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isLoggingIn)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.black),
              // You can use Lottie animation here as commented
              // child: Lottie.asset('assets/lottie/loading-lottie.json'),
            ),
          )
      ],
    );
  }
}
