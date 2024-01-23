abstract class SignInState {}

class SignupSubmitted extends SignInState {
  final Map<String, dynamic> userData;
  SignupSubmitted(this.userData);
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String errorMessage;
  SignInFailure(this.errorMessage);
}
