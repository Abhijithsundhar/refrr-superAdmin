import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huntrradminweb/Features/Admin/controllor/admin-controllor.dart';
import '../../../core/constants/color-constants.dart';
import '../../../core/globelvariable.dart';
import '../../home/homepage.dart';
import 'add-admin.dart';

class AdminTable extends ConsumerStatefulWidget {
  @override
  _AdminTableState createState() => _AdminTableState();
}

class _AdminTableState extends ConsumerState<AdminTable> {
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
                  contentPadding: EdgeInsets.only(
                      left: width * 0.01, right: width * 0.02),
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
                Future.delayed(Duration(milliseconds: 50), () {
                  showDialog(
                    context: context,
                    builder: (_) => AddAdminAlertBox(),
                  );
                });
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
              // user!.profile.isEmpty?
              Image.asset('assets/images/defualtprofile.png',fit: BoxFit.fill)
                  // :Image.network(user.profile,fit: BoxFit.fill,),
            ),
            Icon(Icons.keyboard_arrow_down, size: width * 0.01),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(248, 250, 252, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),

            // Header Row
            Container(
              color: Color.fromRGBO(248, 250, 252, 1),
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Row(
                children: [
                  buildListCell('SI. No.', width),
                  buildListCell('Name', width),
                  SizedBox(width: width * 0.04),
                  buildListCell('Zone', width),
                  buildListCell('User ID', width),
                  buildListCell('Password', width),
                  buildListCell('Mail ID', width),
                ],
              ),
            ),

            SizedBox(height: 8),

            ref.watch(adminStreamProvider(searchQuery)).when(
              data: (adminList) {
                if (adminList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: Text(
                        'No data available',
                        style: GoogleFonts.firaSansCondensed(
                          fontSize: width * 0.01,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }
                // Apply pagination
                final paginatedData = adminList.skip(currentPage * rowsPerPage).take(rowsPerPage).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: paginatedData.length,
                  itemBuilder: (context, index) {
                    final data = paginatedData[index];
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 8.0),
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                      child: Row(
                        children: [
                          buildListCell('    ${currentPage * rowsPerPage + index + 1}', width),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                data.profile.isEmpty?
                                CircleAvatar(child: Image.asset('assets/images/defualtprofile.png',fit: BoxFit.fill))
                                    :CircleAvatar(child: Image.network(data.profile,fit: BoxFit.fill)),
                                SizedBox(width: width * 0.001),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.name,
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: width * 0.0085,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstants.tableRowColor,
                                      ),
                                    ),
                                    Text(
                                      data.phone,
                                      style: GoogleFonts.firaSansCondensed(
                                        fontSize: width * 0.0065,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstants.tableRowColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          buildListCell(data.zone, width),
                          buildListCell(data.userId, width),
                          buildListCell(data.password, width),
                          buildListCell(data.mailId, width),
                        ],
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => Center(child: CircularProgressIndicator()),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
      bottomNavigationBar: ref.watch(adminStreamProvider(searchQuery)).when(
        data: (adminList) {
          final totalPages = (adminList.length / rowsPerPage).ceil();
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
                        '${rowsPerPage}',
                        style: GoogleFonts.firaSansCondensed(fontSize: width * 0.007, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: width * 0.003),
                    Text('ENTRIES', style: GoogleFonts.firaSansCondensed(fontSize: width * 0.007, fontWeight: FontWeight.w600)),
                    SizedBox(width: width * 0.3),
                    Text(
                      'Showing ${currentPage * rowsPerPage + 1} - ${(currentPage + 1) * rowsPerPage > adminList.length ? adminList.length : (currentPage + 1) * rowsPerPage} of ${adminList.length} entries',
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
    );
  }

  Widget buildListCell(String text, double width, {Color? color}) {
    return Expanded(
      child: Text(
        text,
        style: GoogleFonts.firaSansCondensed(
          fontSize: width * 0.0085,
          fontWeight: FontWeight.w500,
          color: color ?? ColorConstants.tableRowColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

