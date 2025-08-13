import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../globelvariable.dart';

///dashboard above container
Widget buildBox(String title, String subtitle) {
  return Container(
    width: width * 0.15,
    height: height * 0.15,
    decoration: BoxDecoration(
        color: Color(0xFFC9F4F8),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xFF0FDCEA))
    ),
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.firaSansCondensed(
              fontSize: width * 0.012,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: GoogleFonts.firaSansCondensed(
              fontSize: width * 0.009,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}


/// container under funnel for sorting
class TextWithArrowBox extends StatelessWidget {
  // final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData icon;
  final double width;

  const TextWithArrowBox({
    super.key,
    // required this.title,
    required this.subtitle,
    required this.onTap,
    required this.icon,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.15,
      height: height * 0.06,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Centered subtitle text
            Center(
              child: Text(
                subtitle,
                style: GoogleFonts.firaSansCondensed(
                  fontSize: width * 0.009,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            // Positioned icon on the right
            Positioned(
              right: 12,
              child: Icon(
                icon,
                size: width*.015,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// container under funnel
class StatusButton extends StatelessWidget {
  final String subtitle;
  final IconData icon;
  final double width;
  final Function() ontap;

  const StatusButton({
    super.key,
    required this.subtitle,
    required this.icon,
    required this.width,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width * 0.115,
        height: height * 0.04,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                subtitle,
                style: GoogleFonts.firaSansCondensed(
                  fontSize: width * 0.007,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              right: 12,
              child: Icon(
                icon,
                size: width * .009,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showStatusDialog(
    BuildContext context, double width, Function(String) onSelected) {
  final List<String> statusList = [
    'New Lead',
    'Contacted',
    'Interested',
    'Follow-Up Needed',
    'Proposal Sent',
    'Negotiation',
    'Converted',
    'Invoice Raised',
    'Work in Progress',
    'Completed',
    'Not Qualified',
    'Lost',
  ];

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      contentPadding: const EdgeInsets.all(12),
      content: SizedBox(
        width: width * 0.15,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: statusList.map((status) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    onSelected(status); // callback to update the status
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: width * 0.012,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1),
              ],
            );
          }).toList(),
        ),
      ),
    ),
  );
}
