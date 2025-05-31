// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:nutri_plant/screens/authentication_screens/verifyEmail.dart';
// import 'package:nutri_plant/screens/authentication_screens/phoneEntryScreen.dart'; // Import the phone entry screen
//
// class RegistrationScreen extends StatefulWidget {
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isObscure = true;
//   bool _isChecked = false;
//   String _errorMessage = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF1FAEE),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(19.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 45),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.black),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//               Text(
//                 " Let's Create an account!",
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 50),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   labelText: 'Name',
//                   hintText: 'Your Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//                 ),
//               ),
//               SizedBox(height: 30),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   labelText: 'Email',
//                   hintText: 'example@gmail.com',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//                 ),
//               ),
//               SizedBox(height: 30),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _isObscure,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   labelText: 'Create your password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isObscure ? Icons.visibility : Icons.visibility_off,
//                       color: Colors.black54,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isObscure = !_isObscure;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               CheckboxListTile(
//                 controlAffinity: ListTileControlAffinity.leading,
//                 title: Text(
//                   'I would like to receive your newsletter and other promotional information.',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 value: _isChecked,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     _isChecked = value!;
//                   });
//                 },
//               ),
//               SizedBox(height: 70),
//               if (_errorMessage.isNotEmpty)
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               SizedBox(height: 20),
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/login');
//                   },
//                   child: Text(
//                     'Already have an account? Sign In',
//                     style: TextStyle(color: Colors.green, fontSize: 16),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _signUp();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 child: Text(
//                   'Register',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PhoneEntryScreen(),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 child: Text(
//                   'Verify Phone Number',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _signUp() async {
//     String name = _nameController.text.trim();
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty || name.isEmpty) {
//       setState(() {
//         _errorMessage = 'Please fill in all fields.';
//       });
//       return;
//     }
//
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => VerifyEmailScreen(user: userCredential.user!),
//         ),
//       );
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error: ${e.toString()}';
//       });
//     }
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Ensure to import Firestore
// import 'package:nutri_plant/screens/authentication_screens/verifyEmail.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isObscure = true;
//   bool _isChecked = false;
//   String _errorMessage = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF1FAEE), // Very light green background color
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(19.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 45),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.black),
//                   onPressed: () {
//                     Navigator.pop(context); // Navigate back
//                   },
//                 ),
//               ),
//               Text(
//                 " Let's Create an account!",
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 50),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white, // White colored text box
//                   labelText: 'Name',
//                   hintText: 'Thomas Anderson',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0), // Circular border
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//                 ),
//               ),
//               SizedBox(height: 30),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white, // White colored text box
//                   labelText: 'Email',
//                   hintText: 'turjoiu01@gmail.com',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0), // Circular border
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//                 ),
//               ),
//               SizedBox(height: 30),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _isObscure,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white, // White colored text box
//                   labelText: 'Create your password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0), // Circular border
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _isObscure ? Icons.visibility : Icons.visibility_off,
//                       color: Colors.black54,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isObscure = !_isObscure;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               CheckboxListTile(
//                 controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left side
//                 title: Text(
//                   'I would like to receive your newsletter and other promotional information.',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 value: _isChecked,
//                 onChanged: (bool? value) {
//                   setState(() {
//                     _isChecked = value!;
//                   });
//                 },
//               ),
//               SizedBox(height: 130),
//               if (_errorMessage.isNotEmpty)
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               SizedBox(height: 20),
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/login'); // Replace with your sign-in route name
//                   },
//                   child: Text(
//                     'Already have an account? Sign In',
//                     style: TextStyle(color: Colors.green, fontSize: 16),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _signUp(); // Call sign-up method
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green, // Green register button
//                   minimumSize: Size(double.infinity, 50), // Full width button
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0), // Circular border
//                   ),
//                 ),
//                 child: Text(
//                   'Register',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _signUp() async {
//     String name = _nameController.text.trim();
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty || name.isEmpty) {
//       setState(() {
//         _errorMessage = 'Please fill in all fields.';
//       });
//       return;
//     }
//
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       // Navigate to the email verification screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => VerifyEmailScreen(user: userCredential.user!),
//         ),
//       );
//
//       // No need to store user data here, it will be stored in VerifyEmailScreen
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error: ${e.toString()}'; // Display the error message
//       });
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutri_plant/screens/authentication_screens/verifyEmail.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isChecked = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1FAEE),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                " Let's Create an account!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Name',
                  hintText: 'Thomas Anderson',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email',
                  hintText: 'yourname@example.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Create your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  'I would like to receive your newsletter and other promotional information.',
                  style: TextStyle(color: Colors.black),
                ),
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              SizedBox(height: 130),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Already have an account? Sign In',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await _signUp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    }
  }
}
