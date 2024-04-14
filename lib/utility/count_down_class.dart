class CountDown {
  String timeLeft(DateTime due,
      String finishedText,
      String daysTextLong,
      String hoursTextLong,
      String minutesTextLong,
      String secondsTextLong,
      String daysTextShort,
      String hoursTextShort,
      String minutesTextShort,
      String secondsTextShort,
      {bool? longDateName, bool? showLabel,Function(bool value)? onFinished}) {
    String retVal = "";

    Duration timeUntilDue = due.difference(DateTime.now());

    int daysUntil = timeUntilDue.inDays;
    int hoursUntil = timeUntilDue.inHours - (daysUntil * 24);
    int minUntil =
        timeUntilDue.inMinutes - (daysUntil * 24 * 60) - (hoursUntil * 60);
    int secUntil = timeUntilDue.inSeconds - (minUntil * 60);
    // String s = _secUntil.toString().substring(_secUntil.toString().length - 2);
    // //Fixed Invalid Range Value
    String s = secUntil.toString().length <= 2
        ? secUntil.toString()
        : secUntil.toString().substring(secUntil.toString().length - 2);

    //Check whether to return longDateName date name or not
    if (showLabel == false){
      if (daysUntil > 0) {
        retVal += "${daysUntil.toString().padLeft(2, '0')} : ";
      }
      if (hoursUntil > 0) {
        retVal += "${hoursUntil.toString().padLeft(2, '0')} : ";
      }
      if (minUntil > 0) {
        retVal +=  "${minUntil.toString().padLeft(2, '0')} : ";
      }
      if (secUntil > 0) {
        retVal += s.toString().padLeft(2, '0');
      }
      if(secUntil == 00){
        retVal += "00";
      }
    }else {
      if (longDateName == false) {
        if (daysUntil > 0) {
          retVal += daysUntil.toString() + daysTextShort;
        }
        if (hoursUntil > 0) {
          retVal += hoursUntil.toString() + hoursTextShort;
        }
        if (minUntil > 0) {
          retVal += minUntil.toString() + minutesTextShort;
        }
        if (secUntil > 0) {
          retVal += s + secondsTextShort;
        }
      } else {
        if (daysUntil > 0) {
          retVal += daysUntil.toString() + daysTextLong;
        }
        if (hoursUntil > 0) {
          retVal += hoursUntil.toString() + hoursTextLong;
        }
        if (minUntil > 0) {
          retVal += minUntil.toString() + minutesTextLong;
        }
        if (secUntil > 0) {
          retVal += s + secondsTextLong;
        }
      }
    }
    if(daysUntil < 1 && hoursUntil < 1 && minUntil < 1 && secUntil < 1){
      onFinished!(true);
      retVal = finishedText;
    }

    return retVal;
  }
}
