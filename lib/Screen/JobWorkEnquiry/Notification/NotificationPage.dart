import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_engineer/Constant/theme_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  Widget notificationCard(){
    return
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(10),
            color: Colors.white,
            shadowColor: Colors.blueGrey,
            // shape:  OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(10),
            //     borderSide: BorderSide(color: ThemeColors.primaryColor, width: 1)
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  <Widget>[
                ListTile(
                    leading: Container(
                      height: double.infinity,
                        child: Icon(Icons.message_rounded, color: Colors.black,)),
                    title:  Text(
                      "Notification",
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w500,
                        // color: ThemeColors.greyTextColor.withOpacity(0.7),
                        // color: Colors.grey,
                        fontSize: 15.0,
                      ),

                    ),
                    subtitle: Row(
                      children: [

                      ],
                    )
                )

              ],
            ),
          );

        },
      );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: ThemeColors.whiteTextColor,
        elevation: 5,
        centerTitle: true,
        title: Text('Notification',),
      ),
      backgroundColor: Color(0xffF8F9FC),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Container(
              child: notificationCard()),
        ),
      )

    );
  }
}