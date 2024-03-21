import 'package:characters/characters.dart';

bool isArabic(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return text.characters.any((char) => arabicRegex.hasMatch(char));
}
