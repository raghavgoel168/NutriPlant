// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'forgot_password.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _auth = FirebaseAuth.instance; // Firebase Auth instance
//   final GoogleSignIn _googleSignIn = GoogleSignIn(); // Google Sign-In instance
//   final _formKey = GlobalKey<FormState>(); // Key for form validation
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isObscure = true;
//   bool _rememberMe = false;
//   bool _isLoading = false;
//
//   // Function to handle login
//   Future<void> _login() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         _isLoading = true; // Show loading indicator
//       });
//
//       try {
//         await _auth.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//
//         // Navigate to Home screen upon successful login
//         Navigator.pushReplacementNamed(context, '/home');
//
//       } on FirebaseAuthException catch (e) {
//         // Handle errors
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? 'An error occurred')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false; // Hide loading indicator
//         });
//       }
//     }
//   }
//
//   // Function to handle Google sign-in
//   Future<void> _googleSignInMethod() async {
//     try {
//       setState(() {
//         _isLoading = true; // Show loading indicator
//       });
//
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         // User canceled the sign-in
//         return;
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Sign in to Firebase with the Google credentials
//       await _auth.signInWithCredential(credential);
//
//       // Navigate to Home screen upon successful login
//       Navigator.pushReplacementNamed(context, '/home');
//
//     } catch (error) {
//       // Handle errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Google Sign-In failed: $error')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false; // Hide loading indicator
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF1FAEE), // Light background
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(19.0),
//           child: Form(
//             key: _formKey, // Wrap in a form widget
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome Back! 👋',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Let's Continue Your Green Journey",
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),
//                 SizedBox(height: 30),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Email',
//                     prefixIcon: Icon(Icons.email, color: Colors.black54),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 30),
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: _isObscure,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     labelText: 'Password',
//                     prefixIcon: Icon(Icons.lock, color: Colors.black54),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isObscure ? Icons.visibility : Icons.visibility_off,
//                         color: Colors.black54,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isObscure = !_isObscure;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     } else if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: _rememberMe,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               _rememberMe = value!;
//                             });
//                           },
//                         ),
//                         Text('Remember me', style: TextStyle(color: Colors.black)),
//                       ],
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
//                         );
//                       },
//                       child: Text('Forgot Password?', style: TextStyle(color: Colors.green)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 _isLoading
//                     ? Center(child: CircularProgressIndicator())
//                     : ElevatedButton(
//                   onPressed: _login, // Trigger login function
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     minimumSize: Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                   child: Text(
//                     'Log in',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: Text('or', style: TextStyle(color: Colors.black54)),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton.icon(
//                   onPressed: _googleSignInMethod, // Trigger Google sign-in
//                   icon: Icon(Icons.g_translate, color: Colors.black54),
//                   label: Text('Continue with Google', style: TextStyle(color: Colors.black)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     minimumSize: Size(double.infinity, 50), // Full width button
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0), // Circular border
//                       side: BorderSide(color: Colors.black54),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Handle Apple login
//                   },
//                   icon: Icon(Icons.apple, color: Colors.black54),
//                   label: Text('Continue with Apple', style: TextStyle(color: Colors.black)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     minimumSize: Size(double.infinity, 50), // Full width button
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0), // Circular border
//                       side: BorderSide(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Handle Apple login
//                   },
//                   icon: Icon(Icons.facebook, color: Colors.black54),
//                   label: Text('Continue with Facebook', style: TextStyle(color: Colors.black)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     minimumSize: Size(double.infinity, 50), // Full width button
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0), // Circular border
//                       side: BorderSide(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 // Social login buttons can remain as is
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/GoogleSignInController.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance; // Firebase Auth instance
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  // Function to handle login
  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // Navigate to Home screen upon successful login
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  // Function to handle Google sign-in using the controller
  Future<void> _googleSignInMethod() async {
    final GoogleSignInController googleSignInController =
    Get.put(GoogleSignInController());
    try {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      await googleSignInController.signInWithGoogle();
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1FAEE), // Light background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Form(
            key: _formKey, // Wrap in a form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back! 👋',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Let's Continue Your Green Journey",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.black54),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        Text('Remember me', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: Text('Forgot Password?', style: TextStyle(color: Colors.green)),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _login, // Trigger login function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text('or', style: TextStyle(color: Colors.black54)),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _googleSignInMethod, // Trigger Google sign-in
                  icon: Icon(Icons.g_translate, color: Colors.black54),
                  label: Text('Continue with Google', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50), // Full width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Circular border
                      side: BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Apple login
                  },
                  icon: Icon(Icons.apple, color: Colors.black54),
                  label: Text('Continue with Apple', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50), // Full width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Circular border
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Apple login
                  },
                  icon: Icon(Icons.facebook, color: Colors.black54),
                  label: Text('Continue with Facebook', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50), // Full width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Circular border
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                // Social login buttons can remain as is
              ],
            ),
          ),
        ),
      ),
    );
  }
}
