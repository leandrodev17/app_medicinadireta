import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class ShimmerListAnamnese extends StatelessWidget {
  const ShimmerListAnamnese({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                  Container(color: Colors.white, height: 40.0, width: MediaQuery.of(context).size.width),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    color: Colors.white,
                    child: SizedBox(height: 25.0, width: MediaQuery.of(context).size.width / 1.5),
                  ),
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
