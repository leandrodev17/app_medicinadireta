import 'package:medicinadireta/core/widgets/app_log.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../constants/const_endpoint.dart';

class SignalWebsocket {
  static SignalWebsocket? _instance;

  SignalWebsocket._();
  static SignalWebsocket get instance {
    _instance ??= SignalWebsocket._();
    return _instance!;
  }

  get openConnection => _conection();
  get disconecting => _disconecting();

  HubConnection? hubConnectionApp;

  Future<HubConnection> _conection() async {
    AppLog.i("Status: ${hubConnectionApp?.state == HubConnectionState.Connected} hubConnection != null ${hubConnectionApp != null} ${hubConnectionApp?.connectionId}", name: "SignalWebsocket");

    if (hubConnectionApp != null && hubConnectionApp?.connectionId != null) {
      AppLog.i("Existe uma conexão", name: "SignalWebsocket");
      return hubConnectionApp!;
    }
    hubConnectionApp = await _openChatConnection();

    return hubConnectionApp!;
  }

  Future<HubConnection> _openChatConnection() async {
    HubConnection hub = HubConnectionBuilder().withUrl(urlWebSocket).withAutomaticReconnect(
      retryDelays: [2000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000],
    ).build();

    if (hub.state != HubConnectionState.Connected) {
      hubConnectionApp = hub;
      await hub.start();
      AppLog.i("HubConnectionState.Connected =  ${hub.state}", name: "SignalWebsocket");
    } else {
      AppLog.i("HubConnectionState.Disconnected = ${hub.state}", name: "SignalWebsocket");
    }
    return hub;
  }

  Future<dynamic> _disconecting() async {
    try {
      HubConnection conn = await _conection();
      await conn.stop();
      AppLog.i("MATOU A CONEXÃO COM O SERVIÇO ${conn.state}", name: "SignalWebsocket");
    } catch (e) {
      AppLog.d("MATOU A CONEXÃO COM O SERVIÇO $e", name: "SignalWebsocket");
    }
  }
}
