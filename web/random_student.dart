
part of test_json;

class RandomStudent {
  String personId;
  final String studentName;
  final String distEvent;
  final String computerId;
  final String distTime;

  final List<int> evenNums = [0,2,4,6,8];
  final List<int> oddNums = [1,3,5,7,9];

  var rnd = new Random();
  NumberFormat twoDigits = new NumberFormat("00");

  RandomStudent(this.personId, this.studentName, [this.distEvent, this.computerId, this.distTime]);

  String toString() => '$personId - $studentName, $distEvent, $computerId, $distTime';

  RandomStudent.withRandomId(this.studentName, [this.distEvent, this.computerId, this.distTime]) {
    personId = _getRndPersonId();
  }

  String _getRndPersonId() {
    String birthDate = _rndGroup(rnd.nextInt(99) + 1);
    String birthNum = twoDigits.format(rnd.nextInt(98) + 1);
    int sex = rnd.nextInt(9);
    String sexDigit = _getRandomSexDigit(sex);
//  String chkDigit = rnd.nextInt(9).toString();
//  String chkDigit = calculate('$birthDate$birthNum$sexDigit').toString();
    String chkDigit = _getInvalidCheckDigit('$birthDate$birthNum$sexDigit');
    String personId = '$birthDate$birthNum$sexDigit$chkDigit';
    return personId;
  }

  String _rndGroup(int rndNumber) {
    if (rndNumber > 0 && rndNumber <= 10) {
      return _getRandomDate(new DateTime(1985, 01, 01), 365);
    } else if (rndNumber > 10 && rndNumber <= 100) {
      return _getRandomDate(new DateTime(1987, 01, 01), 365);
    } else {
      return '$rndNumber out of range';
    }
  }

  String _getRandomDate(DateTime start, int maxDaysToAdd) {
    Duration days = new Duration(days: rnd.nextInt(maxDaysToAdd));
    var rndDate = start.add(days);
    var dateString = '${rndDate.year - 1900}${twoDigits.format(rndDate.month)}${twoDigits.format(rndDate.day)}';
    return dateString;
  }

  String _getRandomSexDigit(int sex) {
    if (sex % 2 == 0) {
      return _getRandowEven().toString();
    } else {
      return _getRandowOdd().toString();
    }

  }

  int _getRandowEven() {
    return evenNums[rnd.nextInt(4)];
  }

  int _getRandowOdd() {
    return oddNums[rnd.nextInt(4)];
  }

  String _getInvalidCheckDigit(String luhn) {
    int checkDigit;
    do {
      checkDigit = rnd.nextInt(9);
    } while (checkDigit == _calculate(luhn));
    return checkDigit.toString();
  }

  int _calculate(luhn) {
    var sum = luhn.split("").map((e) => int.parse(e, radix:10)).reduce((a,b) => a + b);

    var delta = [0,1,2,3,4,-4,-3,-2,-1,0];
    for (var i=luhn.length-1; i >= 0; i-=2 ) {
      sum += delta[int.parse(luhn.substring(i,i+1), radix:10)];
    }

    var mod10 = 10 - (sum % 10);
    return mod10==10 ? 0 : mod10;
  }

  bool _validate(luhn) {
    var luhnDigit = int.parse(luhn.substring(luhn.length-1,luhn.length), radix:10);
    var luhnLess = luhn.substring(0,luhn.length-1);
    return (_calculate(luhnLess) == luhnDigit);
  }
}