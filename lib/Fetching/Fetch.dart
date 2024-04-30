import 'dart:convert';

import 'package:quotiful/Models/model.dart';
import 'package:http/http.dart' as http;

List<QuoteStruct> quoteList = [];

Future<List<QuoteStruct>> getQuotes(String valueChosen) async {
  final response = await http.get(
    Uri.parse('https://api.api-ninjas.com/v1/quotes?category=$valueChosen'),
    headers: {"X-Api-Key": "wpCFOwxeIzFu6sEgFzXPaQ==BFS857Q1R18Slp2i"},
  );

  var data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    for (Map i in data) {
      QuoteStruct quote = QuoteStruct(quote: i["quote"], author: i["author"]);
      quoteList.add(quote);
    }
    return quoteList;
  } else {
    return quoteList;
  }
}
