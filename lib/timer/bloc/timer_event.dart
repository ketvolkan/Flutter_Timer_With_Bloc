abstract class TimerEvent {}

class PausedEvent extends TimerEvent {}

class UnPausedEvent extends TimerEvent {}

class RestartedEvent extends TimerEvent {}

class StartedEvent extends TimerEvent {}
