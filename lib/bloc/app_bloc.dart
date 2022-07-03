import 'package:bloc/bloc.dart';
import 'package:bloclearningwithsimplenotesapp/api/login_api.dart';
import 'package:bloclearningwithsimplenotesapp/api/notes_api.dart';
import 'package:bloclearningwithsimplenotesapp/bloc/actions.dart';
import 'package:bloclearningwithsimplenotesapp/bloc/app_state.dart';
import 'package:bloclearningwithsimplenotesapp/enum/login_errors.dart';
import 'package:bloclearningwithsimplenotesapp/models/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;
  final LoginHandle acceptedLoginHandle;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
    required this.acceptedLoginHandle,
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      // Start loading
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );

      // Log the user in
      final LoginHandle? loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );

      emit(
        AppState(
          isLoading: false,
          loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    on<LoadNotesAction>((event, emit) async {
      // Start loading
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );

      // get the login handle
      final LoginHandle? loginHandle = state.loginHandle;
      if (loginHandle != acceptedLoginHandle) {
        // Invalid login handle, cannot fetch notes
        emit(
          AppState(
            isLoading: false,
            loginError: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
        return;
      }

      // we have a valid login handle
      final List<Note>? notesList = await notesApi.getNotes(
        loginHandle: acceptedLoginHandle,
      );
      emit(
        AppState(
          isLoading: false,
          loginError: null,
          loginHandle: loginHandle,
          fetchedNotes: notesList,
        ),
      );
    });
  }
}
