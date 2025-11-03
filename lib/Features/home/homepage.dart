
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:huntrradminweb/Features/home/sidemenu.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import '../../model/admin-model.dart';
import '../Account/Screens/account-page.dart';
import '../Admin/Screens/admin-page.dart';
import '../Affiliates/Screens/affiliate-page.dart';
import '../Agents/Screens/agent-page.dart';
import '../Dashbord/dashbord.dart';
import '../Leads/Screens/leads-page.dart';
import '../Settings/settings.dart';
import '../firms/firms-page.dart';


late TabController tabController;
var mainColor = Color(0xFF084586);
final currentUserProvider = StateProvider<AdminModel?>((ref) => null);


class Home extends ConsumerStatefulWidget {
  final int initialTabIndex;
  final AdminModel? user;

  const Home({Key? key,this.initialTabIndex = 0,this.user,}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with SingleTickerProviderStateMixin {
  @override

  void initState() {
    print('widget.user 000000');
    print(widget.user?.reference);
    print('widget.user 000000');
    super.initState();
    Future.microtask(() {
      ref.read(currentUserProvider.notifier).state = widget.user;
    });    tabController = TabController(length:7 , initialIndex: widget.initialTabIndex,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // w < 700 || h < 500 ?
      //     SizedBox(
      //       height: w*2.7,
      //       width: double.infinity,
      //       child: Lottie.network("https://asset-cdn.lottiefiles"),
      //     ):
      ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizingInformation) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideMenu(tabController: tabController),

              Expanded(
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Dashboard(),//0
                      LeadsTablePage(), //1
                      AgentsTable(),//2
                      AffiliateTable(),//3
                      AccountTable(),//4
                      AdminTable(),//5
                      Settings(),//6

                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}