import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardPatient extends StatelessWidget {
  const ShimmerCardPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _item({double? height = 20.0, double? width = 30}) => Container(color: Colors.white, height: height, width: width);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Shimmer.fromColors(
        baseColor: Color(0xFFEFEFEF),
        highlightColor: Color(0xFFE0E0E0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Icon(Icons.account_circle, size: 70, color: ConstColors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _item(height: 20, width: _size.width * .8),
                        const SizedBox(height: 2),
                        _item(height: 20, width: _size.width * .4),
                      ],
                    ),
                  )
                ],
              ),
              Divider(color: ConstColors.border),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _item(height: 20, width: _size.width * .8),
                          const SizedBox(height: 2),
                          _item(height: 20, width: _size.width * .8),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _item(height: 20, width: 30),
                        const SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                          decoration: BoxDecoration(
                            color: ConstColors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _item(height: 15, width: 20),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}
