import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlinetv/Screen/Home/home.dart';

class OTPLoginPage extends StatefulWidget {
  @override
  State<OTPLoginPage> createState() => _OTPLoginPageState();
}

class _OTPLoginPageState extends State<OTPLoginPage> {

  TextEditingController otpController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  bool _isOTPSend = false;
  String vCode = '';


// Function to send OTP to a phone number
  Future<void> sendOTP(String phoneNumber) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // This callback will be triggered automatically if the phone number
          // is instantly verified on the device where the app is running.
          // You can sign in the user here if needed.
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Error sending OTP: ${e.code}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Store the verification ID somewhere to use it in the next step
          vCode = verificationId;
          print('Verification ID: $verificationId');
          _isOTPSend = true;
          setState(() {

          });
          // You can also store resendToken for resending the OTP
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Called when the auto-retrieval timer expires and the code has not
          // been automatically verified.
          print('Code auto retrieval timeout');
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Login'),
      ),
      body: Center(
        child: Column(
          children: [
            if(_isOTPSend = false)
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter your phone number:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle phone number submission here
                        String phoneNumber = _phoneNumberController.text;
                        // Send the phone number for OTP verification
                        sendOTP(phoneNumber);
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
            ),
            if(_isOTPSend = true)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Enter OTP:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Replace 'verificationId' with the actual verification ID obtained during OTP sent
                      String verificationId = 'your_verification_id_here';

                      AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: otpController.text,
                      );

                      await FirebaseAuth.instance.signInWithCredential(credential);

                      // OTP verification successful, navigate to the next screen
                      // Replace 'HomeScreen' with the screen you want to navigate to
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    } catch (e) {
                      // Handle OTP verification failure
                      print('Error verifying OTP: $e');
                    }
                  },
                  child: Text('Verify OTP'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
