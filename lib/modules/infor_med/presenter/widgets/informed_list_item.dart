import 'package:medicinadireta/constants/const_colors.dart';
import 'package:medicinadireta/modules/infor_med/domain/entities/contents_info_med.dart';
import 'package:medicinadireta/modules/infor_med/presenter/controller/infor_med_controller.dart';
import 'package:medicinadireta/modules/infor_med/presenter/widgets/contents_html.dart';
import 'package:flutter/material.dart';

class InforMedListItem extends StatelessWidget {
  final List<ContentsInfoMed> listData;
  final InforMedController controller;
  InforMedListItem({Key? key, required this.listData, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12, top: 8),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (_, index) {
          ContentsInfoMed _item = listData[index];
          var _category = controller.filterCategory.firstWhere((e) => e['id'] == _item.tipo);
          var _yearPublish = _item.copyright != null ? _item.copyright : (_item.anoPublicacao != null ? _item.anoPublicacao : '--');
          return Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ContentsHtml(controller: controller, id: _item.id.toString()),
                    ),
                  );
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                title: Text(
                  '${_item.titulo?.toUpperCase()}',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Color(0xff002d72), fontWeight: FontWeight.w500, fontSize: 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                        children: _item.autores
                                ?.map(
                                    (m) => Text(m, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.grey.shade800, fontWeight: FontWeight.w400, fontSize: 16)))
                                .toList() ??
                            []),
                    Text('Publicação: $_yearPublish | ${_item.minutosLeitura} min de leitura',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.w400, fontSize: 16)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        _category['value'] ?? '--',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: Color(0xff002d72)),
                    )
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: ConstColors.orange, size: 30),
              )
            ],
          );
        },
        itemCount: listData.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, index) => Divider(),
      ),
    );
  }
}
