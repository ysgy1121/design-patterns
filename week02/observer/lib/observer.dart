abstract class Observer {
  void update(int time);
}

/// 테스트를 위해 1시간을 1초로 설정
class DinnerTimerObserver implements Observer {
  int dinnerTime = 17;

  @override
  void update(int time) {
    if (time == dinnerTime) {
      print('DinnerTimer에서 알려드립니다. 저녁 시간입니다.');
    } else if (time > dinnerTime) {
      print('DinnerTimer에서 알려드립니다. 저녁 식사 시간이 지났습니다.');
    } else {
      print('DinnerTimer에서 알려드립니다. 저녁 식사까지 ${dinnerTime - time}시간 남았습니다.');
    }
  }
}

class LunchTimerObserver implements Observer {
  int lunchTime = 13;

  @override
  void update(int time) {
    if (time == lunchTime) {
      print('LunchTimer에서 알려드립니다. 점심 시간입니다.');
    } else if (time > lunchTime) {
      print('LunchTimer에서 알려드립니다. 점심 식사 시간이 지났습니다.');
    } else {
      print('LunchTimer에서 알려드립니다. 점심 식사까지 ${lunchTime - time}시간 남았습니다.');
    }
  }
}
