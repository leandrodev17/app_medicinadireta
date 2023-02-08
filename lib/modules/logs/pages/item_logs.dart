import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/modules/logs/debug_log_item.dart';

class ItemLogs extends StatelessWidget {
  final DebugLogItem? item;
  const ItemLogs({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            wi('Headers: ', item?.headers.toString() ?? '--'),
            Divider(color: Colors.grey.shade500, height: 60),
            wi('QueryParameters: ', item?.queryParameters.toString() ?? '--'),
            Divider(color: Colors.grey.shade500, height: 60),
            wi('Data Response: ', item?.body.toString() ?? '--'),
            Divider(color: Colors.grey.shade500, height: 60),
            wi('Data Resquest: ', item?.dataPost.toString() ?? '--'),
          ],
        ),
      ),
    );
  }

  wi(String label, String description) => RichText(
        text: TextSpan(
          text: label,
          style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.blue, fontWeight: FontWeight.w700),
          children: [
            TextSpan(
              text: description,
             style: GoogleFonts.openSans(fontSize: 14.0, color: ConstColors.blue, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
}