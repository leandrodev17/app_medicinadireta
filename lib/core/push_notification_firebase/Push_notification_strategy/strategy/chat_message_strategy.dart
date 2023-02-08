
import 'i_push_strategy.dart';

class ChatMessageStrategy implements IPushStrategy {
  @override
  void execute(Map<String, dynamic> pushPayload) {
    // Aqui pode redirecionar para alguma página com o payload

    // Modular.to.pushNamed('/chat', arguments: pushPayload['message']);
    //['message'] está dentro do payload do json enviado. Lembrando que o nome 'payload' pode ser outro nome
  }
}
