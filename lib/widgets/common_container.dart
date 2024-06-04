import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_app/utils/screen_utils.dart';

class CommomContainer extends StatelessWidget {
  final IconData icon;
  final Text text;
  final IconData icon1;
  final Color iconColor;
  final VoidCallback onTap;
  const CommomContainer({super.key,
    required this.icon,
    required this.text,
    required this.icon1,
    required this.iconColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(onTap:onTap ,
        child: Container(
          height: ScreenUtil.getScreenSize(context).height *0.1,
          width: double.infinity,
          decoration: BoxDecoration(
            color:Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //     offset: Offset(0, 3), // changes position of shadow
            //   ),
            // ],
          ),child: Row(
          children: [
            Icon(icon,color: iconColor,),
            SizedBox(width: 30,),
            Expanded(child:text),
            Icon(icon1)

          ],
        ),
        ),
      ),
    );
  }
}
