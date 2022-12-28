
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget notificationIcon(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          //color: Color(0xffc32c37),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1)),
      child: InkWell(
        onTap: (){
         // Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationPage()));

        },
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 21,
                ),
              ),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 6, left: 4),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //color: Color(0xffc32c37),
                      color: Colors.red,
                      border: Border.all(color: Colors.black, width: 1)),
                  child: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(
                        "",
                        // _counter.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

}

Widget addIcon(){
  return InkWell(
    onTap: (){
      //AddProduct(context);
    },
    child: Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffEC2326),
          //color: Colors.red,
          border: Border.all(color: Colors.black, width: 1)),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
                child:Icon(Icons.add,color: Colors.white,)
            ),
          ],
        ),
      ),
    ),
  );
}

Widget notification(BuildContext context) {
  return InkWell(
    onTap: (){
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationPage()));

    },
    child: Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 26,
            ),
          ),
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 11, left: 4),
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //color: Color(0xffc32c37),
                  color: Colors.red,
                  border: Border.all(color: Colors.black, width: 1)),
              child: const Padding(
                padding: EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    "",
                    // _counter.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

}





final List<String> imgList = [

  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 800.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();

//////