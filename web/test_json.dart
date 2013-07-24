library test_json;

import 'dart:html';
import 'dart:json' as json;

part 'student.dart';

void main() {
  loadData();
//  print(new Student('5507172939', 'Göran Johansson', '', '', ''));
//  print('hej hopp!');
}

void loadData() {
//  var url = "http://127.0.0.1:8080/programming-languages";
  var url = "https://script.google.com/a/macros/longbay.se/s/AKfycbzeu-2KwKocJdXvGvPBiR73BcU8J6dbIsGp9CbTf_JaqbnILM0/exec";

  // call the web server asynchronously
//  var request = HttpRequest.getString(url).then(onDataLoaded).catchError(handleError);
  var request = HttpRequest.request(url).then(onDataLoaded).catchError(handleError);
}

// print the raw json response text from the server
void onDataLoaded(HttpRequest responseText) {
  var jsonString = responseText.responseText;
  print(jsonString);
}

void handleError(error) {
  print(error.toString());
}