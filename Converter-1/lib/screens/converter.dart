import 'dart:convert';

import 'package:curren_see/screens/Home2.dart';
import 'package:curren_see/screens/history.dart';
import 'package:curren_see/screens/ratelist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {

  TextEditingController amountController = TextEditingController();
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double convertedAmount = 0.0;

  List<String> all_currencies = [];

  Future<void> convertCurrency() async {



    final response = await http.post(Uri.parse('https://convertercurrency.000webhostapp.com/convert.php') , body: {
      "userId":"8",
      "baseCurrencyCode":fromCurrency,
      "targetCurrencyCode":toCurrency,
      "amount":amountController.text
    });




    if (response.statusCode == 200) {
       Map<String, dynamic> data = jsonDecode(response.body);
       final data2 = data["convertedAmount"];
      setState(() {
        convertedAmount = data2;
      });



    } else {
      throw Exception('Failed to load exchange rates');
    }

  }

  Future<void> apicurrency() async {
    final response = await http.post(Uri.parse('https://openexchangerates.org/api/currencies.json'));
    final data = jsonDecode(response.body);
    Iterable<String> keys = data.keys;
    all_currencies = keys.toList();
    print(all_currencies);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicurrency();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B4242),
        title: Center(
          child: Text("CONVERTER",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        leading:
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ScreenProduct()));
          },
        ),

    ),
     //

      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1B4242),
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Wrap(
                direction: Axis.vertical,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ScreenProduct()))),

                ]),
            IconButton(
                icon: Icon(
                  Icons.currency_exchange,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home1()))),
            SizedBox(width: 10),
            IconButton(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RateList()))),
            IconButton(
                icon: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ConversionHistoryPage()))),
          ],
        ),
      ),

      body: Container(
        color: Color(0xFF5C8374),
        child: Padding(
          padding: const EdgeInsets.all(100.0), // Adjust the padding value
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: fromCurrency,
                    onChanged: (value) {
                      setState(() {
                        fromCurrency = value!;
                      });
                    },
                    items: all_currencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text("From"),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: toCurrency,
                    onChanged: (value) {
                      setState(() {
                        toCurrency = value!;
                      });
                    },
                    items: all_currencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                    hint: Text("To"),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1B4242),
                ),
                onPressed: () async {
                  convertCurrency();
                },
                child: Text('Convert'),
              ),
              SizedBox(height: 20),
              Text(
                'Converted Amount: $convertedAmount $toCurrency',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

Widget _buildCurrencyDropdown(
    String label, String selectedValue, Function(String) onChanged , List<String> all) {
  return DropdownButton<String>(
    value: selectedValue,
    onChanged:(value) {

    },
    items: all // Add more currencies as needed
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    hint: Text(label),
  );
}
