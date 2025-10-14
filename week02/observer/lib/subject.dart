import 'dart:async';

import 'package:observer/observer.dart';

abstract class Subject {
  void registerObserver(Observer observer);
  void removeObserver(Observer observer);
  void notifyObservers();
}

class TimeSubject implements Subject {
  final List<Observer> observers = [];
  int startTime = 9;
  Timer? timer;

  @override
  void registerObserver(Observer observer) {
    observers.add(observer);
  }

  @override
  void removeObserver(Observer observer) {
    observers.remove(observer);
  }

  @override
  void notifyObservers() {
    for (var observer in observers) {
      observer.update(startTime + (timer?.tick ?? 0));
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyObservers();
    });
  }

  void clear() {
    timer?.cancel();
    observers.clear();
  }
}
