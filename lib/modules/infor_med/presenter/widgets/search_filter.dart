import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/core/drawer/search.dart';
import 'package:medicinadireta/core/widgets/form/app_button.dart';
import 'package:medicinadireta/core/widgets/form/app_button_simple.dart';
import 'package:medicinadireta/modules/infor_med/presenter/controller/infor_med_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class SearchFilter extends StatelessWidget {
  final InforMedController controller;
  final TextEditingController searchEC;
  final Debouncer debouncer;
  const SearchFilter({Key? key, required this.controller, required this.searchEC, required this.debouncer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget setupAlertDialoadCategorys() {
      return Container(
        height: MediaQuery.of(context).size.height * .5,
        width: MediaQuery.of(context).size.width * .8,
        child: Obx(() {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: controller.filterCategory.length,
            itemBuilder: (BuildContext context, int index) {
              var _decode = controller.filterCategory[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: _decode["visible"] ? Icon(Icons.check_box_outlined, color: ConstColors.blue) : Icon(Icons.check_box_outline_blank_outlined, color: ConstColors.grey),
                title: Text(_decode['value'], style: Theme.of(context).textTheme.subtitle2),
                onTap: () => controller.changeCategorys(index),
              );
            },
            separatorBuilder: (context, index) => Divider(height: 0.4),
          );
        }),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 80, maxWidth: MediaQuery.of(context).size.width),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Search(
                autofocus: true,
                controller: searchEC,
                onChanged: (data) {
                  debouncer(() async {
                    if (data.length > 3) await controller.searchInfoMed(data);
                  });
                },
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "O que deseja pesquisar?".tr,
              ),
            ),
          ),
          Obx(() {
            return AppButton(
              onPressed: controller.searchTerm.value == '' || controller.searchTerm.value.isEmpty
                  ? () => controller.messageAlert()
                  : () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Selecione a categoria desejada.", style: Theme.of(context).textTheme.subtitle2),
                              const SizedBox(height: 10),
                              Obx(() {
                                return TextButton.icon(
                                    onPressed: () => controller.checkAll(visible: !controller.filterAllCategory.value),
                                    icon: Icon(controller.filterAllCategory.value ? Icons.check_box_outline_blank_outlined : Icons.check_box_outlined),
                                    label: Text(controller.filterAllCategory.value ? "Marcar".tr : "Desmarcar"));
                              })
                            ],
                          ),
                          content: setupAlertDialoadCategorys(),
                          actions: [
                            AppButtonSimple(onPressed: () => Navigator.pop(context), backgroundColor: ConstColors.orange, child: Text("close".tr)),
                            AppButtonSimple(
                              onPressed: () async => await controller.searchInfoMedFilter(),
                              backgroundColor: ConstColors.blue,
                              child: Text("Pesquisar"),
                              width: 130,
                            ),
                          ],
                        );
                      }),
              height: 80,
              minWidth: 50,
              colorBackground: Colors.white,
              childRaisedButton: Icon(Icons.filter_list, color: ConstColors.blue),
            );
          }),
        ],
      ),
    );
  }
}
