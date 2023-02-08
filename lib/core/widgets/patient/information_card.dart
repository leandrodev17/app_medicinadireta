import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';

class InformationCardxxx extends StatelessWidget {
  final String patientName;
  final String age;
  final String email;
  final String phone;
  final String numberProntuario;
  final bool openCard;

  InformationCardxxx({
    required this.patientName,
    required this.age,
    required this.email,
    required this.phone,
    required this.numberProntuario,
    this.openCard = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      height: openCard ? 150 : 0,
      color: ConstColors.ligtherGrey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            patientName,
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(age),
                          Text(email),
                          Text(phone)
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('prontuário'.toUpperCase()),
                        const SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(8)), color: ConstColors.orange),
                          child: SizedBox.fromSize(
                            size: const Size(48, 24),
                            child: Center(child: Text(numberProntuario, style: const TextStyle(color: Colors.white))),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
