import 'package:bloc_native_example/domain/container_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BLoC Native'),
        ),
        body: const BodyContent(),
      ),
    );
  }
}

class BodyContent extends StatefulWidget {
  const BodyContent({super.key});

  @override
  State<BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  // Получение блока для передачи эвентов и запуска функционала
  ContainerBloc bloc = ContainerBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          StreamBuilder<Color>(
            stream: bloc.outputStateStream,
            initialData: Colors.blue,
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 200,
                height: 200,
                color: snapshot.data,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomePageBtn(
                btnAction: () {
                  bloc.inputEventSink.add(ContainerEvents.colorRedEvent);
                },
              ),
              HomePageBtn(
                btnAction: () {
                  bloc.inputEventSink.add(ContainerEvents.colorGreenEvent);
                },
                btnColor: Colors.green,
              ),
              HomePageBtn(
                btnAction: () {
                  bloc.inputEventSink.add(ContainerEvents.colorRandomEvent);
                },
                btnColor: Colors.yellow,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HomePageBtn extends StatelessWidget {
  final Function btnAction;
  final Color btnColor;

  const HomePageBtn({
    super.key,
    required this.btnAction,
    this.btnColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: btnColor,
      onPressed: () => btnAction(),
    );
  }
}
