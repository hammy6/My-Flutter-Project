import 'dart:convert';

import 'package:curren_see/screens/Home2.dart';
import 'package:curren_see/screens/converter.dart';
import 'package:curren_see/screens/history.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RateList extends StatefulWidget {
  const RateList({Key? key}) : super(key: key);

  @override
  State<RateList> createState() => _RateListState();
}

class _RateListState extends State<RateList> {


  late final conversionHistory ;
  late final conversionHistory2 ;
  bool isLoading = true;
  Future<void> get_history() async{

    final response = await http.get(Uri.parse("https://openexchangerates.org/api/latest.json?app_id=06f3ca5b1a9847a0a2de0efe56bc49d0"));
    if (response.statusCode == 200) {

      //print(response.body);

      setState(() {
        conversionHistory = jsonDecode(response.body);
        conversionHistory2 = conversionHistory["rates"];
        print(conversionHistory2);
        //print(conversionHistory);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load conversion records');
    }

  }

  void initState() {
    // TODO: implement initState
    super.initState();
    get_history();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B4242),
        title: Center(
          child: Text("RateList",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        leading:
        IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ScreenProduct()));
          },
        ),
      ),


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



      body:isLoading
          ? Center(

        child: CircularProgressIndicator(),
      )

          : ListView.builder(
        itemCount: conversionHistory2.length,
        itemBuilder: (context, index) {

          String currencyCode = conversionHistory2.keys.elementAt(index);
          double conversionRate = conversionHistory2[currencyCode]!;

          String displayText =
              '${currencyCode}: ${conversionRate.toStringAsFixed(5)}';


          return Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text(displayText, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                subtitle: Text('Currency Code: ${currencyCode}', style: TextStyle(color: Colors.black),),



              ),
            ),
          );
        },
      ),
    );
  }
}
