import 'package:flutter/material.dart';
import 'package:plant_life/icons/custom_icons_icons.dart';
import 'package:plant_life/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomPaint(
        painter: CurvePainter(),
        child: Container(
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 0.0, left: 20.0, right: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sprout',
                    style: TextStyle(color: Colors.white, fontSize: 60.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Icon(
                      CustomIcons.plant,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0, top: 50.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        textAlign: TextAlign.left,
                        cursorColor: Colors.grey,
                        cursorWidth: 1.0,
                        maxLines: 1,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            contentPadding: EdgeInsets.all(20.0),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0)),
                            hintText: 'email',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            prefixIcon: Container(
                              margin: EdgeInsets.only(
                                  left: 10.0,
                                  top: 5.0,
                                  bottom: 5.0,
                                  right: 15.0),
                              width: 80.0,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[300],
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Center(
                                child: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        textAlign: TextAlign.left,
                        cursorColor: Colors.grey,
                        cursorWidth: 1.0,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            contentPadding: EdgeInsets.all(20.0),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(40.0)),
                            hintText: 'password',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            prefixIcon: Container(
                              margin: EdgeInsets.only(
                                  left: 10.0,
                                  top: 5.0,
                                  bottom: 5.0,
                                  right: 15.0),
                              width: 80.0,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[300],
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Center(
                                child: Icon(
                                  Icons.vpn_key,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Don\'t have an account?',
                            style: TextStyle(color: Colors.white)),
                        Text('Forgot password',
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        onPressed: () {},
                        child: Container(
                          height: 45.0,
                          width: 150.0,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.lightGreen,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Divider(
                    height: 10.0,
                    color: Colors.white,
                  ),
                )),
                Text(
                  "or",
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Divider(
                    height: 10.0,
                    color: Colors.white,
                  ),
                )),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  onPressed: () async {
                    try {
                      final firebaseAuth = Provider.of<AuthService>(context);
                      await firebaseAuth.signInWithGoogle();
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    height: 60.0,
                    width: 185.0,
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/googleicon.png',
                            fit: BoxFit.contain,
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //   body:
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    final double height = size.height;
    final double width = size.width;

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.lightGreen[300];
    mainBackground.close();
    canvas.drawPath(mainBackground, paint);

    Path path = Path();
    path.moveTo(0, height);
    path.lineTo(0, height * 0.66);
    path.quadraticBezierTo(
        width * 0.1, size.height * 0.61, width * 0.24, height * 0.64);
    path.quadraticBezierTo(
        width * 0.48, size.height * 0.68, width * 0.56, height * 0.54);
    path.lineTo(width * 0.78, height * 0.23);
    path.quadraticBezierTo(
        width * 0.9, height * 0.08, width * 1.2, height * 0.08);
    path.lineTo(width, height);
    path.close();
    paint.color = Colors.lightGreen[100];
    canvas.drawPath(path, paint);

    path = Path();
    path.moveTo(0, height);
    path.lineTo(0, height * 0.68);
    path.quadraticBezierTo(
        width * 0.1, size.height * 0.64, width * 0.22, height * 0.67);
    path.quadraticBezierTo(
        width * 0.45, size.height * 0.72, width * 0.58, height * 0.57);
    path.lineTo(width * 0.8, height * 0.27);
    path.quadraticBezierTo(
        width * 0.9, height * 0.14, width * 1.2, height * 0.14);
    path.lineTo(width, height);
    path.close();
    paint.color = Colors.lightGreen[200];
    canvas.drawPath(path, paint);

    path = Path();
    path.moveTo(0, height);
    path.lineTo(0, height * 0.7);
    path.quadraticBezierTo(
        width * 0.1, size.height * 0.66, width * 0.22, height * 0.7);
    path.quadraticBezierTo(
        width * 0.45, size.height * 0.78, width * 0.6, height * 0.6);
    path.lineTo(width * 0.82, height * 0.3);
    path.quadraticBezierTo(
        width * 0.9, height * 0.2, width * 1.2, height * 0.2);
    path.lineTo(width, height);
    path.close();
    paint.color = Colors.lightGreen[300];
    canvas.drawPath(path, paint);

    // Path path = Path();
    // path.moveTo(0, height);
    // path.lineTo(0, size.height * 0.6);
    // path.quadraticBezierTo( width * 0.1, size.height * 0.3,
    //     width * 0.2 , size.height * 0.65);
    // path.quadraticBezierTo(
    //     size.width * 0.20, size.height, size.width * 0.25, size.height * 0.90);
    // path.quadraticBezierTo(size.width * 0.40, size.height * 0.40,
    //     size.width * 0.50, size.height * 0.70);
    // path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
    //     size.width * 0.65, size.height * 0.65);
    // path.quadraticBezierTo(
    //     size.width * 0.70, size.height * 0.90, size.width, 0);
    // path.lineTo(width, height * 0.3);
    // path.close();

    // paint.color = Colors.red;
    // canvas.drawPath(path, paint);

    // path = Path();
    // path.lineTo(0, height * 0.80);
    // path.lineTo(height * 0.8, height);
    // // path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
    // //     size.width * 0.15, size.height * 0.60);
    // // path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
    // //     size.width * 0.27, size.height * 0.60);
    // // path.quadraticBezierTo(
    // //     size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    // // path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
    // //     size.width * 0.75, size.height * 0.75);
    // // path.quadraticBezierTo(
    // //     size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    // // path.lineTo(size.width, 0);
    // path.close();

    // paint.color = Colors.red[300];
    // canvas.drawPath(path, paint);

    // path = Path();
    // // path.lineTo(0, size.height * 0.75);
    // // path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
    // //     size.width * 0.22, size.height * 0.70);
    // // path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
    // //     size.width * 0.40, size.height * 0.75);
    // // path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
    // //     size.width * 0.65, size.height * 0.70);
    // // path.quadraticBezierTo(
    // //     size.width * 0.75, size.height * 0.85, size.width, size.height * 0.60);
    // // path.lineTo(size.width, 0);
    // path.close();

    // paint.color = Colors.red;
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
