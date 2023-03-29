import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MyTask/my_task_detail.dart';

import '../../../Bloc/home/home_bloc.dart';
import '../../../Bloc/home/home_state.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Widget/custom_snackbar.dart';



class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key,required this.myTaskData}) : super(key: key);
  MyTaskModel myTaskData;

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _headingController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  HomeBloc? _homeBloc;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _headingController.dispose();
    _descriptionController.dispose();
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
      body: Container(
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
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if(state is CreateTaskLoading){
              _isLoading = state.isLoading;
            }
            if(state is CreateTaskSuccess){
              // Navigator.of(context).pop();
              showCustomSnackBar(context,state.message.toString(),isError: false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyTaskDetailsScreen(myTaskData: widget.myTaskData,)));
            }
            if(state is CreateTaskFail){
              showCustomSnackBar(context,state.msg.toString());
            }
          },
          child: InkWell(
            onTap: (){
              if(_formKey.currentState!.validate()){
                _homeBloc!.add(CreateTask(userId: '1',machineEnquiryId: '1',transportEnquiryId: '0',jobWorkEnquiryId: '0', heading: _headingController.text,
                    description: _descriptionController.text,status: 0));
              }else{
                showCustomSnackBar(context,'Fill the details.');
              }

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
                    style: TextStyle(fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ))),
              ),
            ),
          ),

        );


      })


    );
  }
}
