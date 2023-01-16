import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../Config/image.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.7;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              // Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Dashboard',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              primary: false,
              padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              // childAspectRatio: .7,

              shrinkWrap: true,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.dashboardBG),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                    child: Column(
                      children: [
                        Text("3054",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),),
                        Text("Total Service Done",
                          style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),),
                        Spacer(),
                        Text('Total Service Done',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.dashboardBG),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                    child: Column(
                      children: [
                        Text("\u{20B9}30.1K",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),),
                        Text("Total Earning",
                          style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),),
                        Spacer(),
                        Text('Total Earning',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.dashboardBG),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                    child: Column(
                      children: [
                        Text("214",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),),
                        Text("Payment Pending",
                          style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),),
                        Spacer(),
                        Text('Payment Pending',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.dashboardBG),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                    child: Column(
                      children: [
                        Text("13",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),),
                        Text("Received Payments",
                          style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),),
                        Spacer(),
                        Text('Received Payments',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                  ),
                ),


              ],
            )
          ],
        ),
      )
    );
  }
}
