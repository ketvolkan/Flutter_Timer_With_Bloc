import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_timer_example/core/constants.dart';
import 'package:flutter_bloc_timer_example/timer/bloc/timer_event.dart';
import 'package:flutter_bloc_timer_example/timer/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  void runTimer() {
    add(StartedEvent());
  }

  void restartTimer() {
    _timer?.cancel();
    add(RestartedEvent());
  }

  void pauseTimer() {
    _timer?.cancel();
    add(PausedEvent());
  }

  void unPauseTimer() {
    runTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => runTimer());
    add(UnPausedEvent());
  }

  void startTimer() {
    runTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => runTimer());
  }

  Timer? _timer;

  TimerBloc(super.initialState) {
    on<TimerEvent>(
      (event, emit) async {
        if (event is PausedEvent) {
          emit(state.copyWith(duration: state.duration, isStart: true, isPaused: true));
          return;
        }
        if (event is UnPausedEvent) {
          emit(state.copyWith(duration: state.duration, isStart: true, isPaused: false));
          return;
        }
        if (event is RestartedEvent) {
          emit(state.copyWith(duration: AppConstants.timerCount, isStart: false));
          return;
        }
        if (event is StartedEvent) {
          emit(state.copyWith(duration: state.duration - 1, isStart: true, isPaused: state.isPaused));
          if (state.duration != -1) return;
          _timer?.cancel();
          emit(state.copyWith(duration: AppConstants.timerCount, isStart: false));
          return;
        }
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
