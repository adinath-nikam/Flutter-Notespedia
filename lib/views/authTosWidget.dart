import 'package:flutter/material.dart';
import 'otpAuth.dart';

class authTosWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "By Signing In, you Agree to our ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                color: Colors.grey[500]
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => otpAuth())),
            child: Text(
              "Terms and Conditions*.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.lightBlue
              ),
            ),
          )
        ],
      ),
    );
  }
}
