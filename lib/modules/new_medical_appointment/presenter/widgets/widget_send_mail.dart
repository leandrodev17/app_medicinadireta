import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../constants/const_colors.dart';
import '../../../../core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import '../../../../core/validators/app_validators.dart';
import '../../../../core/widgets/form/app_text_field_simple.dart';
import '../controller/new_medical_appointment_controller.dart';

class WidgetSendMail extends StatelessWidget {
  final NewMedicalAppointmentController controller;

  const WidgetSendMail({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? selectedItemSelectModelEmail;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Obx(() {
            return Row(
              children: [
                Transform.scale(
                  scale: 0.9,
                  child: CupertinoSwitch(
                    value: controller.typeSendMail.value,
                    onChanged: controller.onChangeTypeMail,
                    activeColor: ConstColors.blue,
                    trackColor: ConstColors.ff969696,
                  ),
                ),
                Text('send_email_scheduling'.tr)
              ],
            );
          }),
        ),
        Obx(() {
          return Visibility(
            visible: controller.typeSendMail.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextFieldSimple(
                  controller: controller.sendMailController,
                  focusNode: controller.sendMailFocusNode,
                  maxLength: 100,
                  hintText: 'E-mail para envio*',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  enabled: !controller.loadingSave.value,
                  onSaved: (data) {
                    controller.requestToSnap = controller.requestToSnap.copyWith(
                      email: data,
                      emailEnviar: "1",
                    );
                  },
                  validator: AppValidators.multiple([
                    AppValidators.required(),
                    AppValidators.email(),
                  ]),
                ),
                const SizedBox(height: 5),
                AppDropdownWidgetSearchImpl(
                  items: controller.listModelToMail.map((e) => e.toMap()).toList(),
                  selectedItem: selectedItemSelectModelEmail,
                  itemAsString: (dynamic value) => value['assuntoModeloEmail'].toString(),
                  isDecorationNotBorder: true,
                  borderSideColor: ConstColors.white,
                  validator: AppValidators.required(),
                  onSaved: (dynamic d) {
                    if (d != null) {
                      controller.requestToSnap = controller.requestToSnap.copyWith(
                        idEmail: d['id'],
                        codModeloEmail: d['codModeloEmail'],
                        assuntoModeloEmail: d['assuntoModeloEmail'],
                      );
                    }
                  },
                  hintText: 'Selecione o modelo*',
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
