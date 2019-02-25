class Util {
  static String translatePlayCount(count) {
    if (count >= 10000 && count < 100000000) {
      return (count ~/ 10000).toString() + '万';
    }

    if (count >= 100000000) {
      double b = count / 100000000;
      return b.toStringAsFixed(1) + '亿';
    }

    return count.toString();
  }
}