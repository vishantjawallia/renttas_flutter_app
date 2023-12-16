import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class ttttttt extends StatefulWidget {
  const ttttttt({super.key});

  @override
  State<ttttttt> createState() => _tttttttState();
}

class _tttttttState extends State<ttttttt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showImageAlertDialog(
                context); // Call the function to display the AlertDialog with an image
          },
          child: Text('Show Image AlertDialog'),
        ),
      ),
    );
  }

  void _showImageAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  title: Text('Image Alert Dialog'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/renttas.png', // Replace with your image path
                width: 150, // Adjust image width as needed
              ),
              //   SizedBox(height: 2), // Adjust spacing as needed
              Text('Enter 4 digit OTP here'),
            ],
          ),
          actions: <Widget>[
            OTPTextField(
                //       controller: otpController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                //     outlineBorderRadius: 15,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                }),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange)),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the AlertDialog
                },
                child: Text('Verify OTP'),
              ),
            ),
          ],
        );
      },
    );
  }
}
