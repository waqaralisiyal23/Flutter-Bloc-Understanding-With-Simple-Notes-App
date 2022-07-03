import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginHandle {
  final String token;

  const LoginHandle({required this.token});

  const LoginHandle.fakeLogin() : token = 'waqartoken';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHanlde (token=$token)}';
}

@immutable
class Note {
  final String title;

  const Note({required this.title});

  @override
  String toString() => 'Note (title=$title)';
}

final List<Note> mockNotes =
    List.generate(3, (index) => Note(title: 'Note ${index + 1}'));
