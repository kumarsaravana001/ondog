// // user_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:ondgo_flutter/bloc/user_bloc/user_events.dart';
// import 'package:ondgo_flutter/bloc/user_bloc/user_state,dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   UserBloc() : super(UserInitial()) {
//     on<LoadUser>(_onLoadUser);
//     on<LogoutUser>(_onLogoutUser);
//   }

//   void _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
//     emit(UserLoading());
//     try {
//       var box = Hive.box('sessionBox');
//       String? userId = box.get('userId');
//       if (userId != null) {
//         emit(UserLoaded(userId));
//       } else {
//         emit(UserError('User not found'));
//       }
//     } catch (e) {
//       emit(UserError(e.toString()));
//     }
//   }

//   void _onLogoutUser(LogoutUser event, Emitter<UserState> emit) async {
//     var box = Hive.box('sessionBox');
//     await box.delete('userId');
//     emit(UserInitial());
//   }
// }
