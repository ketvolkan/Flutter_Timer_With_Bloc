import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_timer_example/core/constants.dart';

class TimerState extends Equatable {
  int duration = AppConstants.timerCount;
  bool isStart;
  bool isPaused;
  TimerState({required this.duration, this.isStart = false, this.isPaused = false});

  @override
  List<Object?> get props => [duration, isStart, isPaused];

  TimerState copyWith({int? duration, bool? isStart, bool? isPaused}) => TimerState(
        duration: duration ?? AppConstants.timerCount,
        isStart: isStart ?? false,
        isPaused: isPaused ?? false,
      );
}
