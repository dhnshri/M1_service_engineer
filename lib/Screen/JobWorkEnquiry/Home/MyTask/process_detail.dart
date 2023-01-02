import 'package:flutter/material.dart';
import 'package:service_engineer/Constant/theme_colors.dart';

class ProcessDetailScreen extends StatefulWidget {
  const ProcessDetailScreen({Key? key}) : super(key: key);

  @override
  _ProcessDetailScreenState createState() => _ProcessDetailScreenState();
}

class _ProcessDetailScreenState extends State<ProcessDetailScreen> {

 String dumyString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,)),
        title: Text("#102GRDSA36987"
        ),
        backgroundColor: ThemeColors.backGroundColor,

      ),
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Step 1",
                  style: TextStyle(fontFamily: 'Poppins-Medium',
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),

              SizedBox(height: 8,),
              Text(dumyString),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Category",style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 15
                          ),),
                          SizedBox(height: 5,),
                          Text("Heavy",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                            fontWeight: FontWeight.bold
                          )),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Machine Name",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),

                          SizedBox(height: 5,),

                          Text("Grinder 2LA",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Manufacturer (Brand)",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),

                          Text("John Deer",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Make",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),

                          Text("Some Value here",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Machine No.",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),

                          Text("032154CS32",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Controler",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),

                          Text("Mitsubishi",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sub-Category",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),

                          Text("Semi Iron",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Machine Type",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),

                          Text("Latte",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("System name",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),

                          Text("MH23GTSF",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Model no.",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),

                          Text("02GRDSA36",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Machine Size",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),
                          SizedBox(height: 5,),
                          Text("255m",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Manufacture Date",style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15
                          ),),

                          SizedBox(height: 5,),


                          Text("24-July-2022",style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ],
                  )
                ],
              ),

            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: ThemeColors.defaultbuttonColor,
                borderRadius: BorderRadius.circular(30)),
            child: Center(child: Text("Mark As Complete",
                style: TextStyle(fontFamily: 'Poppins-Medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ))),
          ),
        ),
      ),

    );
  }
}
