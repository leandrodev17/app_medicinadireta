import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerMedicineInUse extends StatelessWidget {
  const ShimmerMedicineInUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      child: ListView.builder(
        itemBuilder: (_, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Shimmer.fromColors(
              baseColor: Color(0xFFEFEFEF),
              highlightColor: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(color: Colors.white, height: 25.0, width: MediaQuery.of(context).size.width),
                ],
              ),
            ),
          );
        },
        itemCount: 10,
        shrinkWrap: true,
      ),
    );
  }
}
