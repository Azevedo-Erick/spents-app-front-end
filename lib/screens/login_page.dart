import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void didUpdateWidget(LoginPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController.duration = Duration(milliseconds: 1000);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFormMode() {
    _animationController.forward(
      from: 0.0,
    );
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 31, 122, 114),
                    Color.fromARGB(255, 11, 20, 68),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: _isLogin
                    ? _LoginWidget(
                        animationController: _animationController,
                        toggleFormMode: _toggleFormMode,
                      )
                    : _RegisterWidget(
                        animationController: _animationController,
                        toggleFormMode: _toggleFormMode,
                      )),
          )

          // ),
        ],
      ),
    );
  }
}

class _LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();

  Function toggleFormMode;
  AnimationController animationController;
  _LoginWidget(
      {Key? key,
      required this.toggleFormMode,
      required this.animationController})
      : super(key: key);
}

class _LoginWidgetState extends State<_LoginWidget> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Icon(Icons.monetization_on, color: Colors.black, size: 72)),
        Spacer(),
        Text(
          'Login',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 31, 122, 114),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              if (isEmail(value) == false) {
                return 'Please enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 31, 122, 114),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 31, 122, 114),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/transactions-overview');
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 31, 122, 114),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'Login',
              style: GoogleFonts.nunito(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            setState(() {
              widget.toggleFormMode();
            });
          },
          child: Text('Dont have an account?'),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {},
          child: Text('Forgot Password?'),
        ),
      ],
    );
  }
}

class _RegisterWidget extends StatefulWidget {
  Function toggleFormMode;

  AnimationController animationController;
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();

  _RegisterWidget(
      {Key? key,
      required this.toggleFormMode,
      required this.animationController})
      : super(key: key);
}

class _RegisterWidgetState extends State<_RegisterWidget> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Icon(Icons.monetization_on, color: Colors.black, size: 72)),
        Spacer(),
        Text(
          'Register',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 31, 122, 114),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            onChanged: (value) => email = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              if (isEmail(value) == false) {
                return 'Please enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 31, 122, 114),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            onChanged: (value) => password = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 31, 122, 114),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            onChanged: (value) => confirmPassword = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              if (value != password) {
                return 'Passwords do not match';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 31, 122, 114),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 31, 122, 114),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            print(email);

            print(password);
            print(confirmPassword);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 31, 122, 114),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'Registrar',
              style: GoogleFonts.nunito(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Spacer(),
        TextButton(
            onPressed: () {
              setState(() {
                widget.toggleFormMode();
              });
            },
            child: Text('Fazer Login')),
      ],
    );
  }
}

// class _CustomClipper extends CustomClipper<Path> {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1;

//     Path path0 = Path();
//     path0.moveTo(size.width * 0.0000130, size.height * 0.0004396);
//     path0.lineTo(size.width * 0.0010156, size.height * 0.5777080);
//     path0.quadraticBezierTo(size.width * 0.1704297, size.height * 0.4928414,
//         size.width * 0.2963542, size.height * 0.5796703);
//     path0.cubicTo(
//         size.width * 0.3724219,
//         size.height * 0.6377708,
//         size.width * 0.5392187,
//         size.height * 0.5930769,
//         size.width * 0.6201693,
//         size.height * 0.5844584);
//     path0.quadraticBezierTo(size.width * 0.7261979, size.height * 0.5458870,
//         size.width * 0.9986979, size.height * 0.5792936);
//     path0.lineTo(size.width, 0);
//     path0.lineTo(size.width * 0.0000130, size.height * 0.0004396);
//     path0.close();

//     canvas.drawPath(path0, paint0);
//   }

//   @override
//   Path getClip(Size size) {
//     Path path0 = Path();
//     path0.moveTo(0, size.height * 0.0019623);
//     path0.lineTo(0, size.height * 1.0031083);
//     path0.quadraticBezierTo(size.width * 0.2227083, size.height * 1.0467504,
//         size.width * 0.2986589, size.height * 1.0228885);
//     path0.quadraticBezierTo(size.width * 0.4364974, size.height * 0.9618367,
//         size.width, size.height * 0.9993407);
//     path0.lineTo(size.width, 0);
//     path0.lineTo(0, size.height * 0.0019623);
//     path0.close();
//     return path0;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
