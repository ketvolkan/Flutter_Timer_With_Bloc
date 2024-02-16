import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_timer_example/core/constants.dart';
import 'package:flutter_bloc_timer_example/timer/bloc/timer_bloc.dart';
import 'package:flutter_bloc_timer_example/timer/bloc/timer_state.dart';
import 'package:flutter_bloc_timer_example/timer/view/timer_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TimerBloc>(
        create: (context) => TimerBloc(TimerState(duration: AppConstants.timerCount)),
        child: const TimerView(),
      ),
    );
  }
}
