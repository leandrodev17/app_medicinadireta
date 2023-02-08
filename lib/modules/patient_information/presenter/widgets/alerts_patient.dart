import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/widgets/scaffold/app_bar_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertsPatient extends StatefulWidget {
  AlertsPatient({Key? key}) : super(key: key);

  @override
  State<AlertsPatient> createState() => _AlertsPatientState();
}

class _AlertsPatientState extends State<AlertsPatient> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault.bar(title: Text("CARLOS SANTOS")),
      backgroundColor: ConstColors.backgroundDefault,
      body: CupertinoScrollbar(
        thumbVisibility: false,
        controller: _scrollController,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: 3,
            separatorBuilder: (_, index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: ConstColors.border),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: index == 1 ? ConstColors.danger : (index == 2 ? ConstColors.orange : ConstColors.blue),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                        ),
                        child: Text(
                          index == 1 ? "INSETOS" : (index == 2 ? "ALIMENTAR" : "LÁTEX"),
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "#11139 - CARLOS FLUTTER CRM-SP 123654 - 16/02/2022 às 21:32",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 3),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text("LÁTEX", style: Theme.of(context).textTheme.subtitle1),
                      Text("Teste", style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
                  children: [
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.done_all_outlined),
                          label: Text("Visualizar", style: Theme.of(context).textTheme.subtitle2),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.border_color_outlined),
                          label: Text("Editar", style: Theme.of(context).textTheme.subtitle2),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
