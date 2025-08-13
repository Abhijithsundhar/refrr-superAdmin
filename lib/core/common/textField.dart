import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globelvariable.dart';

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
            controller: controller,
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
