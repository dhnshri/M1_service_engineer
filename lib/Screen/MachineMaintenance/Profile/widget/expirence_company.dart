import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/theme_colors.dart';
import '../../../../Model/experience_company_model.dart';



class ExpCompanyFormWidget extends StatefulWidget {
  ExpCompanyFormWidget(
      {Key? key, this.expCompanyModel,required this.onRemove, this.index})
      : super(key: key);

  final index;
  ExpCompanyModel? expCompanyModel;
  final Function onRemove;
  final state = _ExpCompanyFormWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _jobPostController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _workFromYearsController = TextEditingController();
  TextEditingController _workTillYearsController = TextEditingController();
  TextEditingController _workFromMonthsController = TextEditingController();
  TextEditingController _workTillMonthsController = TextEditingController();

  bool isValidated() => state.validate();
}

class _ExpCompanyFormWidgetState extends State<ExpCompanyFormWidget> {
  final formKey = GlobalKey<FormState>();
  DateTime selectedWorkFromDate = DateTime.now();
  DateTime selectedWorkTillDate = DateTime.now();


  Future<Null> _selectWorkFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: selectedDate,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedWorkFromDate = picked;
        if (selectedWorkFromDate != null) {
          widget._workFromYearsController.text =
              DateFormat.yMd('es').format(selectedWorkFromDate);
          widget.expCompanyModel!.fromYear =
              DateFormat.yMd('es').format(selectedWorkFromDate);
        }
      });
  }

  Future<Null> _selectWorkTillDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: selectedDate,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedWorkTillDate = picked;
        if (selectedWorkTillDate != null) {
          widget._workTillYearsController.text =
              DateFormat.yMd('es').format(selectedWorkTillDate);
          widget.expCompanyModel!.tillYear =
              DateFormat.yMd('es').format(selectedWorkTillDate);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: (){
                      widget.onRemove();
                    },
                    child: Icon(Icons.clear, color: ThemeColors.buttonColor,))
              ],
            ),
            ///Company Name
            TextFormField(
              // initialValue: Application.customerLogin!.name.toString(),
              controller: widget._companyNameController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
                hintText: "Company Name",
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

                if (value == null || value.isEmpty) {
                  return 'Please enter Company Name';
                }

                return null;
              },
              onSaved: (value) => widget.expCompanyModel!.companyName = value!,
              onChanged: (value) {
                widget.expCompanyModel!.companyName=value;
                setState(() {
                  // _nameController.text = value;
                  if (formKey.currentState!.validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),


            ///Description
            TextFormField(
              controller: widget._descriptionController,
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
              onSaved: (value) => widget.expCompanyModel!.desciption = value!,

              onChanged: (value) {
                widget.expCompanyModel!.desciption = value;
                setState(() {
                  if (formKey.currentState!
                      .validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Text("Worked From",
                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              onTap: (){
                _selectWorkFromDate(context);
              },
              child: TextFormField(
                enabled: false,
                // readOnly: false,
                // initialValue: Application.customerLogin!.name.toString(),
                controller: widget._workFromYearsController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month),
                  filled: true,
                  fillColor: ThemeColors.textFieldBackgroundColor,
                  hintText: "Work from",
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

                  if (value == null || value.isEmpty) {
                    return 'Please enter Years';
                  }

                  return null;
                },
                onSaved: (value) => widget.expCompanyModel!.fromYear = value!,
                onChanged: (value) {
                  setState(() {
                    // _nameController.text = value;
                    if (formKey.currentState!.validate()) {}
                    widget.expCompanyModel!.fromYear=value;

                  });
                },
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ///Years
            //     SizedBox(
            //       // width: MediaQuery.of(context).size.width * 0.4,
            //       child: TextFormField(
            //         // initialValue: Application.customerLogin!.name.toString(),
            //         controller: widget._workFromYearsController,
            //         textAlign: TextAlign.start,
            //         keyboardType: TextInputType.text,
            //         style: TextStyle(
            //           fontSize: 18,
            //           height: 1.5,
            //         ),
            //         decoration: InputDecoration(
            //           filled: true,
            //           fillColor: ThemeColors.textFieldBackgroundColor,
            //           hintText: "Years",
            //           contentPadding: EdgeInsets.symmetric(
            //               vertical: 10.0, horizontal: 15.0),
            //           hintStyle: TextStyle(fontSize: 15),
            //           enabledBorder: OutlineInputBorder(
            //             borderRadius:
            //             BorderRadius.all(Radius.circular(1.0)),
            //             borderSide: BorderSide(
            //                 width: 0.8,
            //                 color: ThemeColors.textFieldBackgroundColor
            //             ),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderRadius:
            //             BorderRadius.all(Radius.circular(1.0)),
            //             borderSide: BorderSide(
            //                 width: 0.8,
            //                 color: ThemeColors.textFieldBackgroundColor),
            //           ),
            //           border: OutlineInputBorder(
            //               borderRadius:
            //               BorderRadius.all(Radius.circular(1.0)),
            //               borderSide: BorderSide(
            //                   width: 0.8,
            //                   color: ThemeColors.textFieldBackgroundColor)),
            //         ),
            //         validator: (value) {
            //           // profile.name = value!.trim();
            //           // Pattern pattern =
            //           //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            //           // RegExp regex =
            //           // new RegExp(pattern.toString());
            //           if (value == null || value.isEmpty) {
            //             return 'Please enter Years';
            //           }
            //           // else if(!regex.hasMatch(value)){
            //           //   return 'Please enter valid name';
            //           // }
            //           return null;
            //         },
            //         onSaved: (value) => widget.expCompanyModel!.fromYear = value!,
            //
            //         onChanged: (value) {
            //           widget.expCompanyModel!.fromYear=value;
            //           setState(() {
            //             // _nameController.text = value;
            //             if (formKey.currentState!.validate()) {}
            //           });
            //         },
            //       ),
            //     ),
            //
            //     ///Months
            //     // SizedBox(
            //     //   width: MediaQuery.of(context).size.width * 0.4,
            //     //
            //     //   child: TextFormField(
            //     //     // initialValue: Application.customerLogin!.name.toString(),
            //     //     controller: widget._workFromMonthsController,
            //     //     textAlign: TextAlign.start,
            //     //     keyboardType: TextInputType.number,
            //     //     style: TextStyle(
            //     //       fontSize: 18,
            //     //       height: 1.5,
            //     //     ),
            //     //     decoration: InputDecoration(
            //     //       filled: true,
            //     //       fillColor: ThemeColors.textFieldBackgroundColor,
            //     //       hintText: "Months",
            //     //       contentPadding: EdgeInsets.symmetric(
            //     //           vertical: 10.0, horizontal: 15.0),
            //     //       hintStyle: TextStyle(fontSize: 15),
            //     //       enabledBorder: OutlineInputBorder(
            //     //         borderRadius:
            //     //         BorderRadius.all(Radius.circular(1.0)),
            //     //         borderSide: BorderSide(
            //     //             width: 0.8,
            //     //             color: ThemeColors.textFieldBackgroundColor
            //     //         ),
            //     //       ),
            //     //       focusedBorder: OutlineInputBorder(
            //     //         borderRadius:
            //     //         BorderRadius.all(Radius.circular(1.0)),
            //     //         borderSide: BorderSide(
            //     //             width: 0.8,
            //     //             color: ThemeColors.textFieldBackgroundColor),
            //     //       ),
            //     //       border: OutlineInputBorder(
            //     //           borderRadius:
            //     //           BorderRadius.all(Radius.circular(1.0)),
            //     //           borderSide: BorderSide(
            //     //               width: 0.8,
            //     //               color: ThemeColors.textFieldBackgroundColor)),
            //     //     ),
            //     //     validator: (value) {
            //     //       // profile.name = value!.trim();
            //     //       // Pattern pattern =
            //     //       //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            //     //       // RegExp regex =
            //     //       // new RegExp(pattern.toString());
            //     //       if (value == null || value.isEmpty) {
            //     //         return 'Please enter months';
            //     //       }
            //     //       // else if(!regex.hasMatch(value)){
            //     //       //   return 'Please enter valid name';
            //     //       // }
            //     //       return null;
            //     //     },
            //     //     onSaved: (value) => widget.expCompanyModel!.fromMonth = value!,
            //     //
            //     //     onChanged: (value) {
            //     //       widget.expCompanyModel!.fromMonth=value;
            //     //       setState(() {
            //     //         // _nameController.text = value;
            //     //         if (formKey.currentState!.validate()) {}
            //     //       });
            //     //     },
            //     //   ),
            //     // ),
            //
            //
            //   ],
            // ),

            SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Text("Worked Till",
                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),

            InkWell(
              onTap: (){
                _selectWorkTillDate(context);
              },
              child: TextFormField(
                // initialValue: Application.customerLogin!.name.toString(),
                enabled: false,
                controller: widget._workTillYearsController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month),
                  filled: true,
                  fillColor: ThemeColors.textFieldBackgroundColor,
                  hintText: "Work till",
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter Years';
                  }
                  return null;
                },
                onSaved: (value) => widget.expCompanyModel!.tillYear = value!,

                onChanged: (value) {
                  widget.expCompanyModel!.tillYear=value;
                  setState(() {
                    // _nameController.text = value;
                    if (formKey.currentState!.validate()) {}
                  });
                },
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ///Years
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width * 0.4,
            //       child: TextFormField(
            //         // initialValue: Application.customerLogin!.name.toString(),
            //         controller: widget._workTillYearsController,
            //         textAlign: TextAlign.start,
            //         keyboardType: TextInputType.text,
            //         style: TextStyle(
            //           fontSize: 18,
            //           height: 1.5,
            //         ),
            //         decoration: InputDecoration(
            //           filled: true,
            //           fillColor: ThemeColors.textFieldBackgroundColor,
            //           hintText: "Years",
            //           contentPadding: EdgeInsets.symmetric(
            //               vertical: 10.0, horizontal: 15.0),
            //           hintStyle: TextStyle(fontSize: 15),
            //           enabledBorder: OutlineInputBorder(
            //             borderRadius:
            //             BorderRadius.all(Radius.circular(1.0)),
            //             borderSide: BorderSide(
            //                 width: 0.8,
            //                 color: ThemeColors.textFieldBackgroundColor
            //             ),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderRadius:
            //             BorderRadius.all(Radius.circular(1.0)),
            //             borderSide: BorderSide(
            //                 width: 0.8,
            //                 color: ThemeColors.textFieldBackgroundColor),
            //           ),
            //           border: OutlineInputBorder(
            //               borderRadius:
            //               BorderRadius.all(Radius.circular(1.0)),
            //               borderSide: BorderSide(
            //                   width: 0.8,
            //                   color: ThemeColors.textFieldBackgroundColor)),
            //         ),
            //         validator: (value) {
            //           // profile.name = value!.trim();
            //           // Pattern pattern =
            //           //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            //           // RegExp regex =
            //           // new RegExp(pattern.toString());
            //           if (value == null || value.isEmpty) {
            //             return 'Please enter Years';
            //           }
            //           // else if(!regex.hasMatch(value)){
            //           //   return 'Please enter valid name';
            //           // }
            //           return null;
            //         },
            //         onSaved: (value) => widget.expCompanyModel!.tillYear = value!,
            //
            //         onChanged: (value) {
            //           widget.expCompanyModel!.tillYear=value;
            //           setState(() {
            //             // _nameController.text = value;
            //             if (formKey.currentState!.validate()) {}
            //           });
            //         },
            //       ),
            //     ),
            //
            //     ///Months
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width * 0.4,
            //
            //       child: TextFormField(
            //         // initialValue: Application.customerLogin!.name.toString(),
            //         controller: widget._workTillMonthsController,
            //         textAlign: TextAlign.start,
            //         keyboardType: TextInputType.number,
            //         style: TextStyle(
            //           fontSize: 18,
            //           height: 1.5,
            //         ),
            //         decoration: InputDecoration(
            //           filled: true,
            //           fillColor: ThemeColors.textFieldBackgroundColor,
            //           hintText: "Months",
            //           contentPadding: EdgeInsets.symmetric(
            //               vertical: 10.0, horizontal: 15.0),
            //           hintStyle: TextStyle(fontSize: 15),
            //           enabledBorder: OutlineInputBorder(
            //             borderRadius:
            //             BorderRadius.all(Radius.circular(1.0)),
            //             borderSide: BorderSide(
            //                 width: 0.8,
            //                 color: ThemeColors.textFieldBackgroundColor
            //             ),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderRadius:
            //             BorderRadius.all(Radius.circular(1.0)),
            //             borderSide: BorderSide(
            //                 width: 0.8,
            //                 color: ThemeColors.textFieldBackgroundColor),
            //           ),
            //           border: OutlineInputBorder(
            //               borderRadius:
            //               BorderRadius.all(Radius.circular(1.0)),
            //               borderSide: BorderSide(
            //                   width: 0.8,
            //                   color: ThemeColors.textFieldBackgroundColor)),
            //         ),
            //         validator: (value) {
            //           // profile.name = value!.trim();
            //           // Pattern pattern =
            //           //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            //           // RegExp regex =
            //           // new RegExp(pattern.toString());
            //           if (value == null || value.isEmpty) {
            //             return 'Please enter months';
            //           }
            //           // else if(!regex.hasMatch(value)){
            //           //   return 'Please enter valid name';
            //           // }
            //           return null;
            //         },
            //         onSaved: (value) => widget.expCompanyModel!.tillMonth = value!,
            //
            //         onChanged: (value) {
            //           widget.expCompanyModel!.tillMonth=value;
            //           setState(() {
            //             // _nameController.text = value;
            //             if (formKey.currentState!.validate()) {}
            //           });
            //         },
            //       ),
            //     ),
            //
            //
            //   ],
            // ),

            SizedBox(height: 15,),




          ],
        ),
      ),
    );
  }

  bool validate() {
    //Validate Form Fields
    bool validate = formKey.currentState!.validate();
    if (validate) formKey.currentState!.save();
    return validate;
  }
}