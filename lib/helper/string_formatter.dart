String getAcronym(String text) {
  if (text.contains('/')) {
    final splitted = text.split('/');
    return splitted[0][0] + splitted[1][0];
  }
  final result = text[0];
  return result;
}
