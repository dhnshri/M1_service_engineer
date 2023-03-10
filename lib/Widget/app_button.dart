import 'package:flutter/material.dart';

import '../Constant/theme_colors.dart';


class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool? loading;
  final bool? disableTouchWhenLoading;
  final OutlinedBorder? shape;
  final Color? color;


  AppButton({
    Key? key,
    this.onPressed,
    this.text,
    this.loading = false,
    this.disableTouchWhenLoading = false,
    this.shape,
  this.color,
  }) : super(key: key);

  Widget _buildLoading() {
    if (loading!) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: 14,
      height: 14,
      child: CircularProgressIndicator(strokeWidth: 2,color: Colors.white,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
    SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      child:

      ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).buttonColor, width: 1),
         primary: Theme.of(context).buttonColor,
         // color:Colors.red,
          shape: shape,
        ),
      // shape: shape,
      onPressed: disableTouchWhenLoading! && loading! ? null : onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text!,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          _buildLoading()
        ],
      ),
    )
    );
  }
}
