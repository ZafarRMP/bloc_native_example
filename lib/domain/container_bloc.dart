import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// Создаем эвенты
enum ContainerEvents { colorRedEvent, colorGreenEvent, colorRandomEvent }

// Класс для реализации бизнес логики
class ContainerBloc {
  // Определяем параметры которые требуется изменить в зависимости от эвента который мы получаем от пользователя
  Color _color = Colors.red;
  // Контроллер который отвечает за входной поток данных
  final _inputEventController = StreamController<ContainerEvents>();
  // Стрим для входной информации
  StreamSink<ContainerEvents> get inputEventSink => _inputEventController.sink;
  // Стрим для состояния которое мы отправляем в UI
  final _outputStateController = StreamController<Color>();
  Stream<Color> get outputStateStream => _outputStateController.stream;

  // Future<void>
  Future<void> _changeContainerState(ContainerEvents event) async {
    if (event == ContainerEvents.colorRedEvent) {
      _color = Colors.red;
    } else if (event == ContainerEvents.colorGreenEvent) {
      _color = Colors.green;
    } else if (event == ContainerEvents.colorRandomEvent) {
      _color = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1,
      );
    } else {
      // Создается исключение которое оповестит нас о том что произошла ошибка
      throw Exception('Не корректный эвент и все сломалось');
    }
    _outputStateController.sink.add(_color);
  }

  ContainerBloc() {
    // Здесь мы подписываемся на поток и обрабатываем события пришедшие со стороны UI
    // трансформируем в новый state
    _inputEventController.stream.listen(_changeContainerState);
  }

  Future<void> dispose() async {
    _inputEventController.close();
    _outputStateController.close();
  }
}
