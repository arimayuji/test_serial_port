abstract class InputState {
  final String inputMessage;
  const InputState(this.inputMessage);
}

class InputWaitingConnectionState extends InputState {
  InputWaitingConnectionState() : super('Esperando conexão com a porta serial...');
}

class InputEstablishingConnectionState extends InputState {
  InputEstablishingConnectionState() : super('Estabelecendo conexão com a porta serial...');
}

class InputCapturingDataState extends InputState {
  InputCapturingDataState() : super('Captando dados da porta serial...');
}

class InputConnectionClosedState extends InputState {
  InputConnectionClosedState() : super('Conexão encerrada e porta serial desconectada.');
}
