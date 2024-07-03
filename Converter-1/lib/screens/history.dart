import 'dart:convert';

import 'package:curren_see/screens/Home2.dart';
import 'package:curren_see/screens/converter.dart';
import 'package:curren_see/screens/ratelist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConversionHistoryPage extends StatefulWidget {
  @override
  _ConversionHistoryPageState createState() => _ConversionHistoryPageState();
}


class _ConversionHistoryPageState extends State<ConversionHistoryPage> {

  late List<dynamic> conversionHistory = [];
  bool isLoading = true;
  Future<void> get_history() async{

    final response = await http.post(Uri.parse("https://convertercurrency.000webhostapp.com/conversion_history.php"),body: {
      "userId":"8"
    });
    if (response.statusCode == 200) {
      setState(() {
        conversionHistory = jsonDecode(response.body);
        isLoading = false;
      });

    } else {
      throw Exception('Failed to load conversion records');
    }
    print(conversionHistory);
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
          child: Text("Conversion History",
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


      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: conversionHistory.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  '${conversionHistory[index]["Amount"]} -- ${conversionHistory[index]["Code"]}',

                  style: TextStyle(
                    fontSize: 20,

                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF1B4242),
                  // backgroundImage: AssetImage('assets/images/pakistan.png'),
                  child: Text(
                    index.toString(),
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                trailing: Text(" ${conversionHistory[index]["ConvertedAmount"]}", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          );
        },
      ),
    );
  }


}
