abstract class SignInEvent {}

class SignInRequested extends SignInEvent {
  final String email;
  final String password;
  final String mobileNumber;
  final String firstName;
  final String lastName;

  SignInRequested({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.password,
  });
}
