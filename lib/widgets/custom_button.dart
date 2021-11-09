import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customButton(String imgPath, String buttonText, double size,
    BuildContext context, void Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 60,
      height: 60,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(width: 1, color: Colors.grey),
        ),
        color: Color(0xff070024),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imgPath,
              height: size,
              width: size,
            ),
            const SizedBox(width: 15),
            Text(buttonText, style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    ),
  );
}
