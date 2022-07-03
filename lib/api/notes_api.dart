import 'package:bloclearningwithsimplenotesapp/models/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();
  Future<List<Note>?> getNotes({required LoginHandle loginHandle});
}

@immutable
class NotesApi implements NotesApiProtocol {
  @override
  Future<List<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) async {
    List<Note>? notesList = await Future.delayed(
      const Duration(seconds: 2),
      () {
        return loginHandle == const LoginHandle.fakeLogin() ? mockNotes : null;
      },
    );
    return notesList;
  }
}
