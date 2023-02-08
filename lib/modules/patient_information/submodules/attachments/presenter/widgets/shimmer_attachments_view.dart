import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAttachmentsView extends StatelessWidget {
  const ShimmerAttachmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Shimmer.fromColors(
              baseColor: Color(0xFFEFEFEF),
              highlightColor: Color(0xFFE0E0E0),
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .75,
                width: MediaQuery.of(context).size.width * .8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
