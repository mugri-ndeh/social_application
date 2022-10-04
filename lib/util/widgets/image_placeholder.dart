import 'package:flutter/material.dart';

Widget imgplace(
    {required BuildContext context,
    required double height,
    required double width}) {
  return Center(
    child: Stack(
      children: [
        CircleAvatar(
          radius: height / 2,
          backgroundColor: Colors.grey.shade200,
          child: ClipOval(
            child: SizedBox(
                width: height,
                height: width,
                child: Icon(
                  Icons.image,
                  size: height / 1.7,
                  color: Colors.grey.shade300,
                )),
          ),
        ),
        Positioned(
          top: height / 1.5,
          left: height / 1.5,
          child: CircleAvatar(
            radius: height / 6,
            backgroundColor: Colors.greenAccent,
            child: ClipOval(
              child: SizedBox(
                  width: height / 3,
                  height: height / 3,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: height / 6,
                    color: Theme.of(context).backgroundColor,
                  )),
            ),
          ),
        )
      ],
    ),
  );
}
