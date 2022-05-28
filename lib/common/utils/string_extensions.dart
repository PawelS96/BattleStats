extension StringExt on String {
  String withTrimmedSpaces() => replaceAll(RegExp(' +'), ' ');

  String withCapitalizedWords() => split(' ').map((e) => e.trim().capitalized()).join(' ');

  String capitalized() => substring(0, 1).toUpperCase() + substring(1);

  String withUppercaseWords(List<String> words) {
    final lowercaseWords = words.map((e) => e.toLowerCase()).toList();
    return split(' ')
        .map((e) => lowercaseWords.contains(e.toLowerCase()) ? e.toUpperCase() : e)
        .join(' ');
  }
}
