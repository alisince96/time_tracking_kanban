abstract class GenericStates {}

class InitialState extends GenericStates {}

class LoadingState extends GenericStates {}

class ErrorState extends GenericStates {
  final String message;
  ErrorState(this.message);
}
