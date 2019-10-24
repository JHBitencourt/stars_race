import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

abstract class BlocEvent {}
abstract class BlocState {}

/// Base class to control event based blocs.
/// Based on some event, this can trigger N states.
abstract class BlocEventStateBase<BlocEvent, BlocState> implements BlocBase {

  PublishSubject<BlocEvent> _eventController = PublishSubject<BlocEvent>();
  BehaviorSubject<BlocState> _stateController = BehaviorSubject<BlocState>();

  /// Invoke this to be able to emit an event
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  /// Use it to be able to listen to the current or new state
  Stream<BlocState> get state => _stateController.stream;

  /// The last event streamed
  BlocState get currentState => _stateController.value;

  /// To be extended and used by subclasses to process the events
  Stream<BlocState> eventHandler(BlocEvent event, BlocState state);

  /// The events must begin with an initial state
  final BlocState initialState;

  BlocEventStateBase({
    @required this.initialState
  }) {
    /// For each new event triggered, we send it to the handler and add the responses
    /// on the stateController stream
    _eventController.listen((BlocEvent event) {
      BlocState currentState = _stateController.value ?? initialState;

      eventHandler(event, currentState).forEach((BlocState newState) {
        _stateController.sink.add(newState);
      });
    });
  }

  BlocState get initialOrCurrentState => currentState != null ? currentState : initialState;

  @override
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}