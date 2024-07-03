import 'package:curren_see/colors.dart';
import 'package:curren_see/screens/converter.dart';
import 'package:curren_see/screens/history.dart';
import 'package:curren_see/screens/login.dart';
import 'package:curren_see/screens/ratelist.dart';
import 'package:curren_see/screens/register.dart';
import 'package:flutter/material.dart';

class Product{
  late String name;
  // late String desc;
  // late String price;
  late String image;
  late int id;

  Product({required String this.name , required String this.image, required this.id}){

  }
}


class ScreenProduct extends StatefulWidget {
  const ScreenProduct({Key? key}) : super(key: key);

  @override
  State<ScreenProduct> createState() => _ScreenProductState();
}

class _ScreenProductState extends State<ScreenProduct> {

  List<Product> prod_list = [

    Product(name: " CONVERTER ", image: "https://images.pexels.com/photos/3806749/pexels-photo-3806749.jpeg?auto=compress&cs=tinysrgb&w=600", id: 1),
    Product(name: " CONVERSION HISTORY ", image: "https://images.pexels.com/photos/210705/pexels-photo-210705.jpeg?auto=compress&cs=tinysrgb&w=600", id: 2),
    Product(name: " RATELIST ",  image: "https://images.pexels.com/photos/7054384/pexels-photo-7054384.jpeg?auto=compress&cs=tinysrgb&w=600",id: 3),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF1B4242),
        title: Center(
          child: Text("CurrenSee",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),),
        ),

        leading:
        IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
          },
        ),

      ),
      body: Container(

        color: Color(0xFF5C8374),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: ListView.builder(
          itemCount: prod_list.length,
          itemBuilder: (context, index) {
            return get_card(name: prod_list[index].name,  image: prod_list[index].image , pag_id: prod_list[index].id);
          },

        ),

      ),
    );
  }

  Widget get_card( { required String name , required String image , required int pag_id})
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Card(
          child: Container(
              color: Color(0xFF5C8374),
              child: Stack(
                children: [
                  Positioned(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(46),
                        child: Image.network(image)),
                  ),
                  Positioned(
                      top: 40,
                      left: 15,
                      child: Text(name,style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),)
                  ),

                  Positioned(
                      top: 170,
                      left: 15,

                      child: MaterialButton(
                          color : Colors.white,
                          onPressed: () {
                                if(pag_id == 1){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Home1()));
                                }
                                else if(pag_id == 2){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>ConversionHistoryPage()));
                                }
                                else if(pag_id == 3){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>RateList()));
                                }
                            },
                          child: Text("OPEN",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),))
                  ),



                ],
              )
          ),
        ),
      ),
    );
  }
}
