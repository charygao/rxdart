import 'dart:async';

/// Returns a Stream that emits a sequence of Integers within a specified
/// range.
///
/// ### Examples
///
///     new RangeStream(1, 3).listen((i) => print(i)); // Prints 1, 2, 3
///
///     new RangeStream(3, 1).listen((i) => print(i)); // Prints 3, 2, 1
class RangeStream extends Stream<int> {
  final Stream<int> stream;

  RangeStream(int startInclusive, int endInclusive)
      : stream = buildStream(startInclusive, endInclusive);

  @override
  StreamSubscription<int> listen(void onData(int event),
          {Function onError, void onDone(), bool cancelOnError}) =>
      stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  static Stream<int> buildStream(int step, int goal) async* {
    if (step == goal) {
      // final event
      yield step;
    } else if (step < goal) {
      yield step;
      yield* buildStream(step + 1, goal);
    } else if (step > goal) {
      yield step;
      yield* buildStream(step - 1, goal);
    }
  }
}
