String hideText(String text, {String symbol = "*"}) {
  if (text.length <= 2) {
    return text;
  }

  int middleLength = text.length - 2;
  return text[0] + symbol * middleLength + text[text.length - 1];
}
