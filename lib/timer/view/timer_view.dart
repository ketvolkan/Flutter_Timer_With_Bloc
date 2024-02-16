import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_timer_example/core/constants.dart';
import 'package:flutter_bloc_timer_example/timer/bloc/timer_bloc.dart';
import 'package:flutter_bloc_timer_example/timer/bloc/timer_event.dart';
import 'package:flutter_bloc_timer_example/timer/bloc/timer_state.dart';

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    int duration = context.watch<TimerBloc>().state.duration;
    String minute = "${duration / 60 < 10 ? "0${(duration / 60).floor().toStringAsFixed(0)}" : duration / 60}";
    String second = "${duration % 60 < 10 ? "0${duration % 60}" : duration % 60}";
    return Scaffold(body: Stack(children: [backgroudWidget(context, duration), inputAndTimeWidget(minute, second, context)]));
  }

  Column inputAndTimeWidget(String minute, String second, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$minute:$second", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.25), textAlign: TextAlign.center),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        BlocBuilder<TimerBloc, TimerState>(
          bloc: context.read<TimerBloc>(),
          builder: (context, state) => state.isStart ? whenStartButtons(context) : startButton(context),
        ),
      ],
    );
  }

  Positioned backgroudWidget(BuildContext context, int duration) {
    return Positioned(
      bottom: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor.withBlue(255)),
        child: AnimatedSize(
          duration: const Duration(seconds: 1),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * (duration / AppConstants.timerCount),
          ),
        ),
      ),
    );
  }

  SizedBox startButton(BuildContext context) => SizedBox(
        width: double.infinity,
        child: IconButton(
          onPressed: () => context.read<TimerBloc>().startTimer(),
          icon: CircleAvatar(
            backgroundColor: Colors.black,
            radius: MediaQuery.of(context).size.width * 0.1,
            child: Icon(Icons.play_arrow_rounded, size: MediaQuery.of(context).size.width * 0.15, color: Colors.white),
          ),
        ),
      );

  Row whenStartButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<TimerBloc, TimerState>(
          bloc: context.read<TimerBloc>(),
          builder: (context, state) => state.isPaused ? unPauseButton(context) : pauseButton(context),
        ),
        IconButton(
          onPressed: () => context.read<TimerBloc>().restartTimer(),
          icon: CircleAvatar(
            backgroundColor: Colors.black,
            radius: MediaQuery.of(context).size.width * 0.1,
            child: Icon(Icons.restart_alt, size: MediaQuery.of(context).size.width * 0.15, color: Colors.white),
          ),
        ),
      ],
    );
  }

  IconButton pauseButton(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<TimerBloc>().pauseTimer(),
      icon: CircleAvatar(
        backgroundColor: Colors.black,
        radius: MediaQuery.of(context).size.width * 0.1,
        child: Icon(Icons.pause, size: MediaQuery.of(context).size.width * 0.15, color: Colors.white),
      ),
    );
  }

  IconButton unPauseButton(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<TimerBloc>().unPauseTimer(),
      icon: CircleAvatar(
        backgroundColor: Colors.black,
        radius: MediaQuery.of(context).size.width * 0.1,
        child: Icon(Icons.play_arrow_rounded, size: MediaQuery.of(context).size.width * 0.15, color: Colors.white),
      ),
    );
  }
}
