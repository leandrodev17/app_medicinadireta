import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import 'package:medicinadireta/constants/const_colors.dart';

class ShimmerAlerts extends StatelessWidget {
  const ShimmerAlerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Shimmer.fromColors(
            baseColor: const Color(0xFFEFEFEF),
            highlightColor: const Color(0xFFE0E0E0),
            child: Container(color: Colors.white, width: _size.width, height: 45),
          ),
        ),
        const Text(
          'carregando os alertas...',
          style: TextStyle(fontWeight: FontWeight.w700, color: ConstColors.cinza2, fontSize: 15),
        ),
      ],
    );
  }
}
