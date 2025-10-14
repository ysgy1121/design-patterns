import 'package:observer/observer.dart';
import 'package:observer/subject.dart';

void main(List<String> arguments) async {
  final subject = TimeSubject();

  subject.startTimer();
  await Future.delayed(const Duration(seconds: 1));

  final lunchTimerObserver = LunchTimerObserver();
  subject.registerObserver(lunchTimerObserver);

  await Future.delayed(const Duration(seconds: 2));

  final dinnerTimerObserver = DinnerTimerObserver();
  subject.registerObserver(dinnerTimerObserver);

  await Future.delayed(const Duration(seconds: 3));

  subject.removeObserver(lunchTimerObserver);

  await Future.delayed(const Duration(seconds: 4));

  subject.clear();
}
