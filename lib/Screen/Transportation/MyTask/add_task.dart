import 'package:flutter/material.dart';
import 'package:service_engineer/Constant/theme_colors.dart';


class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _headingController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();


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
        title: Text("Adding Task"
        ),
        backgroundColor: ThemeColors.backGroundColor,

      ),
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                ///Heading
                TextFormField(
                  // initialValue: Application.customerLogin!.name.toString(),
                  controller: _headingController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColors.textFieldBackgroundColor,
                    hintText: "Heading",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(
                            width: 0.8,
                            color: ThemeColors.textFieldBackgroundColor)),
                  ),
                  validator: (value) {
                    // profile.name = value!.trim();
                    // Pattern pattern =
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    // RegExp regex =
                    // new RegExp(pattern.toString());
                    if (value == null || value.isEmpty) {
                      return 'Please enter Heading';
                    }
                    // else if(!regex.hasMatch(value)){
                    //   return 'Please enter valid name';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      // _nameController.text = value;
                      if (_formKey.currentState!.validate()) {}
                    });
                  },
                ),

                SizedBox(height: 15,),


                ///Description
                TextFormField(
                  controller: _descriptionController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  keyboardType:
                  TextInputType.text,
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColors.textFieldBackgroundColor,
                    contentPadding:
                    EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0),
                    hintStyle:
                    TextStyle(fontSize: 15),
                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              10.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors
                              .textFieldBackgroundColor),
                    ),
                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              10.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors
                              .textFieldBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(
                                10.0)),
                        borderSide: BorderSide(
                            width: 0.8,
                            color: ThemeColors
                                .textFieldBackgroundColor)),
                    hintText: "Description",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if (_formKey.currentState!
                          .validate()) {}
                    });
                  },
                ),
              ],
            ),),
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
            child: Center(child: Text("Add",
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
