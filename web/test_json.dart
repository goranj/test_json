library test_json;

import 'dart:html';
import 'dart:json' as json;
import 'dart:math';
import 'package:intl/intl.dart';

part 'student.dart';
part 'random_student.dart';

HttpRequest request;

void main() {
  loadData();
//  print(new Student('5507172939', 'Göran Johansson', '', '', ''));
//  print('hej hopp!');
}

void loadData() {
  request = new HttpRequest();

  request.onReadyStateChange.listen(onDataLoaded);

//  var url = "https://script.google.com/a/macros/longbay.se/s/AKfycbzeu-2KwKocJdXvGvPBiR73BcU8J6dbIsGp9CbTf_JaqbnILM0/exec";
  var url = "https://script.google.com/macros/s/AKfycbzeu-2KwKocJdXvGvPBiR73BcU8J6dbIsGp9CbTf_JaqbnILM0/exec";

  request.open('GET', url);
  request.send();

  // call the web server asynchronously
//  var request = HttpRequest.getString(url).then(onDataLoaded).catchError(handleError);
//  var request = HttpRequest.request(url).then(onDataLoaded).catchError(handleError);
}

// print the raw json response text from the server
void onDataLoaded(_) {
  if (request.readyState == HttpRequest.DONE &&
      request.status == 200) {
    // Data saved OK.
    var response = request.responseText;
    List<Map> jsonResponse = json.parse(response);

    List<RandomStudent> rndStudents = [];
    jsonResponse.forEach((row) {
      rndStudents.add(new RandomStudent.withRandomId(row['namn']));
    });
    rndStudents.forEach((rndStudent) => print(rndStudent));

  } else if (request.readyState == HttpRequest.DONE &&
      request.status == 0) {
    // Status is 0...most likely the server isn't running.
    print('No server');
  }
//  var jsonString = responseText.responseText;
//  print(jsonString);
}

void handleError(error) {
  print(error.toString());
}