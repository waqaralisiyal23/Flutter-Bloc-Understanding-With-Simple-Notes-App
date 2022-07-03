import 'package:bloclearningwithsimplenotesapp/api/login_api.dart';
import 'package:bloclearningwithsimplenotesapp/api/notes_api.dart';
import 'package:bloclearningwithsimplenotesapp/bloc/actions.dart';
import 'package:bloclearningwithsimplenotesapp/bloc/app_bloc.dart';
import 'package:bloclearningwithsimplenotesapp/bloc/app_state.dart';
import 'package:bloclearningwithsimplenotesapp/dialogs/generic_dialog.dart';
import 'package:bloclearningwithsimplenotesapp/dialogs/loading_screen.dart';
import 'package:bloclearningwithsimplenotesapp/models/models.dart';
import 'package:bloclearningwithsimplenotesapp/res/constants.dart';
import 'package:bloclearningwithsimplenotesapp/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Bloc Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
        acceptedLoginHandle: const LoginHandle.fakeLogin(),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(Constants.homePage),
          ),
          body: BlocConsumer<AppBloc, AppState>(
            listener: (context, appState) {
              // loading screen
              if (appState.isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                  text: Constants.pleaseWait,
                );
              } else {
                LoadingScreen.instance().hide();
              }

              // display possible errors
              final loginError = appState.loginError;
              if (loginError != null) {
                showGenericDialog(
                  context: context,
                  title: Constants.loginErrorDialogTitle,
                  content: Constants.loginErrorDialogContent,
                  optionsBuilder: () => {Constants.ok: true},
                );
              }

              // if we are logged in, but we have no fetched notes, fetch them now
              if (appState.isLoading == false &&
                  appState.loginError == null &&
                  appState.loginHandle == const LoginHandle.fakeLogin() &&
                  appState.fetchedNotes == null) {
                context.read<AppBloc>().add(const LoadNotesAction());
              }
            },
            builder: (context, appState) {
              final notes = appState.fetchedNotes;
              if (notes == null) {
                return LoginView(
                  onLoginTapped: (email, password) {
                    context.read<AppBloc>().add(
                          LoginAction(
                            email: email,
                            password: password,
                          ),
                        );
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(notes[index].title),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
