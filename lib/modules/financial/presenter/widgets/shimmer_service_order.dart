import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerServiceOrder extends StatelessWidget {
  const ShimmerServiceOrder({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 20,
                        width: MediaQuery.of(context).size.width),
                      SizedBox(height: 3),
                      Container(
                        color: Colors.white,
                        height: 16,
                        width: MediaQuery.of(context).size.width),
                    ],
                  )
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
