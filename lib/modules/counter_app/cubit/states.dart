abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterMinusState extends CounterStates {
  late int counter;

  CounterMinusState(this.counter);
}

class CounterPlusState extends CounterStates {
  late int counter;

  CounterPlusState(this.counter);
}
