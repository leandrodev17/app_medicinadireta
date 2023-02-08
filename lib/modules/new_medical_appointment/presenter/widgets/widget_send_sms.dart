import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../constants/const_colors.dart';
import '../../../../core/helpers/formats_constants.dart';
import '../../../../core/packages/dropdown_search_package/app_dropdown_widget_search_impl.dart';
import '../../../../core/validators/app_validators.dart';
import '../../../../core/widgets/form/app_text_field_simple.dart';
import '../controller/new_medical_appointment_controller.dart';

class WidgetSendSms extends StatelessWidget {
  final NewMedicalAppointmentController controller;

  const WidgetSendSms({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? selectedItemSelectModelSMS;

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
                    value: controller.typeSendSms.value,
                    onChanged: controller.onChangeTypeSms,
                    activeColor: ConstColors.blue,
                    trackColor: ConstColors.ff969696,
                  ),
                ),
                Text('send_sms_scheduling'.tr)
              ],
            );
          }),
        ),
        Obx(() {
          return Visibility(
            visible: controller.typeSendSms.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextFieldSimple(
                  controller: controller.phoneSMSController,
                  focusNode: controller.phoneSMSFocusNode,
                  maxLength: 20,
                  hintText: 'DDD + Celular*',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  enabled: !controller.loadingSave.value,
                  inputFormatters: [FormatsConstants.phoneMask],
                  onSaved: (data) {
                    if (data != null) {
                      var numbers = data.replaceAll(RegExp(r'[^0-9]'), '');
                      controller.requestToSnap = controller.requestToSnap.copyWith(
                        smsTelefone: numbers,
                        smsEnviar: "1",
                      );
                    }
                  },
                  validator: AppValidators.multiple([
                    AppValidators.required(),
                    AppValidators.phone(),
                  ]),
                ),
                const SizedBox(height: 5),
                AppDropdownWidgetSearchImpl(
                  items: controller.listModelToSms.map((e) => e.toMap()).toList(),
                  selectedItem: selectedItemSelectModelSMS,
                  itemAsString: (dynamic value) => value['assuntoModeloSms'].toString(),
                  isDecorationNotBorder: true,
                  borderSideColor: ConstColors.white,
                  validator: AppValidators.required(),
                  onSaved: (dynamic d) {
                    if (d != null) {
                      controller.requestToSnap = controller.requestToSnap.copyWith(
                        idSms: d['id'],
                        codModeloSms: d['codModeloSms'],
                        assuntoModeloSms: d['assuntoModeloSms'],
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
