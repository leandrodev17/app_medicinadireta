import 'strategy/i_push_strategy.dart';
import 'strategy/open_link_strategy.dart';
import 'strategy/show_alert_image_strategy.dart';
import 'strategy/show_alert_info_strategy.dart';
import 'strategy/user_logout_strategy.dart';

class PushNotificationFactory {
  Map<String, dynamic> pushPayload;
  IPushStrategy? strategy;
  PushNotificationFactory.create(this.pushPayload) {
    switch (pushPayload['type_strategy']) {
      case 'info':
        strategy = ShowAlertInfoStrategy();
        break;
      case 'link':
        strategy = OpenLinkStrategy();
        break;
      case 'show_image':
        strategy = ShowAlertImageStrategy();
        break;
      case 'logout':
        strategy = UserLogoutStrategy();
        break;
      default:
        throw Exception('Estratégia não definida');
    }
  }
  void execute() {
    strategy?.execute(pushPayload);
  }
}
