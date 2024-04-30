import 'package:flutter/material.dart';
import 'package:quotiful/Fetching/Fetch.dart';
import 'package:quotiful/Widgets/category_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String valueChosen = "age";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[200],
          title: Center(
            child: Text(
              "Quotiful",
              style: TextStyle(
                color: Colors.amber[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bgc.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Select category",
                          style: TextStyle(
                            color: Colors.amberAccent[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 175,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black38),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                                borderRadius: BorderRadius.circular(15),
                                dropdownColor: Colors.orange[50],
                                value: valueChosen,
                                items: categories.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(
                                      valueItem,
                                      style:
                                          TextStyle(color: Colors.orange[800]),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChosen = newValue!;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 135,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder(
                  future: getQuotes(valueChosen),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String quote1 =
                          snapshot.data![quoteList.length - 1].quote;
                      String author1 =
                          snapshot.data![quoteList.length - 1].author;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          color: Colors.black38,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                quote1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: AutofillHints.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '~ $author1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator(
                        color: Colors.orange,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
