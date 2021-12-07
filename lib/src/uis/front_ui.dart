import 'dart:ui';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sri_shakti_foundation/src/resources/helper.dart';
import 'package:sri_shakti_foundation/src/providers/front_provider.dart';
import 'package:sri_shakti_foundation/src/views/front_view.dart';

var emailValid = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class FrontUI extends StatefulWidget {
  @override
  _FrontUIState createState() => _FrontUIState();
}

class _FrontUIState extends State<FrontUI>
    with SingleTickerProviderStateMixin, AfterLayoutMixin
    implements FrontView {
  Animation<double>? _blurAnimation;
  AnimationController? _blurController;

  FormController? _registerController;
  FormController? _loginController;

  bool _obsText = true;

  List<FocusNode> _loginNode = [];
  List<FocusNode> _registerNode = [];

  Map<String, String> _loginValidation = new Map();
  Map<String, String> _registerValidation = new Map();

  GlobalKey globalKey = GlobalKey();

  AnimationController _controller() {
    return AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
  }

  Animation<double> _animation() {
    return Tween<double>(begin: 0.0, end: 1.0).animate(_blurController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (Provider.of<FrontProvider>(context, listen: false).state !=
              PageState.IDLE) {
            Provider.of<FrontProvider>(context, listen: false).switchState();
            _blurController?.reverse();
          }
        } else if (status == AnimationStatus.dismissed) {
          //controller.forward();
        }
      });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<FrontProvider>(context, listen: false).view = this;

    _loginValidation.addAll({kIdentifierLower: kAlertEmailEmpty});
    _loginValidation.addAll({kPasswordLower: kAlertPasswordEmpty});

    _registerValidation.addAll({kNameLower: kAlertNameEmpty});
    _registerValidation.addAll({kAgeLower: kAlertAgeEmpty});
    _registerValidation.addAll({kEmailLower: kAlertEmailEmpty});
    _registerValidation.addAll({kPasswordLower: kAlertPasswordEmpty});
  }

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _loginController = new FormController(_loginNode);
    _registerController = new FormController(_registerNode);
    _blurController = _controller();
    _blurAnimation = _animation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: _body(),
        key: globalKey,
      ),
      onWillPop: () {
        return Future<bool>.value(false);
      },
    );
  }

  Widget _logo() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              child: Image.asset(
                'images/aikam_aikoham_2.png',
                width: 300,
              ),
            ),
            SizedBox(height: 20),
            Image.asset('images/logo_with_name.png'),
          ],
        ));
  }

  Widget _content() {
    return Visibility(
      child: Opacity(
        opacity: 1.0 - _blurController!.value,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(
                'images/background_2.png',
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 40),
              _logo(),
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 40),
                    const Text(
                      "\"When the mind breathes stillness,\nthe God manifests\"",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 100),
                    _control(),
                    SizedBox(height: 15),
                    Material(
                      child: InkWell(
                        child: Container(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: kForgotPasswordUpper,
                                  style: TextStyle(
                                      color: Color(0xff242329).withAlpha(200),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0),
                                ),
                                TextSpan(
                                  text: kResetNowUpper,
                                  style: TextStyle(
                                      color: Color(0xff242329).withAlpha(200),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          height: 40.0,
                        ),
                        onTap: () {
                          // _goToResetPassword();
                        },
                      ),
                      type: MaterialType.transparency,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      visible:
          Provider.of<FrontProvider>(context, listen: false).currentState ==
              PageState.FRONT_PAGE,
    );
  }

  Widget _register() {
    return Visibility(
      child: Opacity(
        opacity: 1.0 - _blurController!.value,
        child: Center(
          child: SingleChildScrollView(
            controller: new ScrollController(),
            child: Container(
                margin: EdgeInsets.fromLTRB(
                  30.0,
                  30.0,
                  30.0,
                  0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _logo(),
                    SizedBox(
                      height: 40.0,
                    ),
                    _field(
                      Icons.people,
                      kName,
                      _registerController?.name(kNameLower),
                      _registerNode,
                      0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _field(
                      Icons.person,
                      kAge,
                      _registerController?.name(kAgeLower),
                      _registerNode,
                      1,
                      textInputType: TextInputType.number,
                      maxLength: 3,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _field(
                        Icons.email,
                        kEmail,
                        _registerController?.name(kEmailLower),
                        _registerNode,
                        2,
                        textInputType: TextInputType.emailAddress),
                    SizedBox(
                      height: 20.0,
                    ),
                    _field(
                        Icons.lock,
                        kPassword,
                        _registerController?.name(kPasswordLower),
                        _registerNode,
                        3,
                        password: true),
                    SizedBox(
                      height: 40.0,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 600.0),
                      child: Row(
                        children: <Widget>[
                          _button(
                            text: kSignUp,
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                            color: Color(0xFF29054D),
                            callback: _doRegister,
                          ),
                        ],
                      ),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                alignment: Alignment.center),
          ),
        ),
      ),
      visible:
          Provider.of<FrontProvider>(context, listen: false).currentState ==
              PageState.REGISTER_PAGE,
    );
  }

  Widget _login() {
    return Visibility(
      child: Opacity(
        opacity: 1.0 - _blurController!.value,
        child: Center(
          child: SingleChildScrollView(
            controller: new ScrollController(),
            child: Container(
                margin: EdgeInsets.fromLTRB(
                  30.0,
                  30.0,
                  30.0,
                  0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _logo(),
                    SizedBox(
                      height: 80.0,
                    ),
                    _field(Icons.email, kEmail,
                        _loginController?.name(kIdentifierLower), _loginNode, 0,
                        textInputType: TextInputType.emailAddress),
                    SizedBox(
                      height: 20.0,
                    ),
                    _field(Icons.lock, kPassword,
                        _loginController?.name(kPasswordLower), _loginNode, 1,
                        password: true),
                    SizedBox(
                      height: 40.0,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 600.0),
                      child: Row(
                        children: <Widget>[
                          _button(
                            text: kLogin,
                            textStyle: new TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                            color: Color(0xFF29054D),
                            callback: _doLogin,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Material(
                      child: InkWell(
                        child: Container(
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                  text: kNewMember,
                                  style: TextStyle(
                                      color: Color(0xff242329).withAlpha(200),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                ),
                                new TextSpan(
                                  text: kSignupHereUpper,
                                  style: TextStyle(
                                      color: Color(0xff242329).withAlpha(200),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          height: 40.0,
                        ),
                        onTap: _gotoRegister,
                      ),
                      type: MaterialType.transparency,
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                alignment: Alignment.center),
          ),
        ),
      ),
      visible:
          Provider.of<FrontProvider>(context, listen: false).currentState ==
              PageState.LOGIN_PAGE,
    );
  }

  Widget _field(
    IconData icons,
    String label,
    TextEditingController? controller,
    List<FocusNode> node,
    int pos, {
    TextInputType? textInputType,
    bool? password,
    int? maxLength = null,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              icons,
              color: Color(0xFF29054D),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: TextField(
              maxLength: maxLength,
              controller: controller,
              keyboardType:
                  textInputType != null ? textInputType : TextInputType.text,
              obscureText: password != null && password ? _obsText : false,
              textInputAction: node.length - 1 == pos
                  ? TextInputAction.done
                  : TextInputAction.next,
              focusNode: node.elementAt(pos),
              onSubmitted: (_) {
                if (node.length - 1 != pos)
                  FocusScope.of(context).requestFocus(
                    node.elementAt(pos + 1),
                  );
              },
              decoration: InputDecoration(
                counterText: "",
                suffixIcon: password != null && password
                    ? InkWell(
                        child: Icon(
                          _obsText ? Icons.visibility : Icons.visibility_off,
                          color: Color(0xFF29054D),
                          size: 18.0,
                        ),
                        onTap: () {
                          setState(() {
                            _obsText = !_obsText;
                          });
                        },
                      )
                    : null,
                contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                labelText: label,
                labelStyle: new TextStyle(
                  color: Color(0xff242329).withAlpha(100),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF29054D), width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF29054D), width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              style: new TextStyle(
                color: Color(0xff242329),
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _doRegister() {
    if (_valid(
        validator: _registerValidation, controller: _registerController)) {
      FocusScope.of(context).requestFocus(FocusNode());
      List<String> keys = [
        kNameLower,
        kAgeLower,
        kEmailLower,
        kPasswordLower,
      ];
      Map<String, dynamic> params = {};
      keys.forEach((element) {
        params.addAll({element: _registerController!.name(element)!.text});
      });
      Provider.of<FrontProvider>(context, listen: false)
          .doRegister(params: params, controller: _registerController);
    }
  }

  void _doLogin() {}

  Widget _button({
    required String text,
    required TextStyle textStyle,
    required Color color,
    required VoidCallback callback,
  }) {
    return Expanded(
      child: MaterialButton(
        onPressed: callback,
        child: Container(
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            text,
            style: textStyle,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
          side: BorderSide(color: Color(0xFF29054D), width: 2.0),
        ),
        color: color,
      ),
    );
  }

  Widget _control() {
    return Row(
      children: <Widget>[
        _button(
          text: kSignUp,
          textStyle: new TextStyle(
            color: Colors.white70,
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
          ),
          color: Color(0xFF29054D),
          callback: _gotoRegister,
        ),
        SizedBox(
          width: 40.0,
        ),
        _button(
          text: kLogin,
          textStyle: new TextStyle(
            color: Color(0xff242329),
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
          ),
          color: Colors.white,
          callback: _gotoLogin,
        ),
      ],
    );
  }

  Widget _backButton() {
    return Visibility(
      child: Opacity(
        opacity: 1.0 - _blurController!.value,
        child: Container(
          height: 50.0,
          width: double.infinity,
          alignment: Alignment.centerRight,
          margin: EdgeInsets.fromLTRB(
            0.0,
            20.0,
            20.0,
            0.0,
          ),
          child: Container(
            height: 50.0,
            width: 50.0,
            alignment: Alignment.centerRight,
            child: MaterialButton(
              onPressed: () {
                Provider.of<FrontProvider>(context, listen: false).state =
                    PageState.FRONT_PAGE;
                _blurController?.forward();
              },
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                  color: Color(0xff145B8F),
                  size: 24.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
            ),
          ),
        ),
      ),
      visible:
          Provider.of<FrontProvider>(context, listen: false).currentState ==
                  PageState.REGISTER_PAGE ||
              Provider.of<FrontProvider>(context, listen: false).currentState ==
                  PageState.LOGIN_PAGE ||
              Provider.of<FrontProvider>(context, listen: false).currentState ==
                  PageState.RESET_PASSWORD_PAGE ||
              Provider.of<FrontProvider>(context, listen: false).currentState ==
                  PageState.ENTER_CODE_PAGE ||
              Provider.of<FrontProvider>(context, listen: false).currentState ==
                  PageState.NEW_PASSWORD_PAGE,
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        _content(),
        _register(),
        _login(),
        _backButton(),
        _builder(),
      ],
    );
  }

  Widget _builder() {
    return Consumer<FrontProvider>(
      builder: (context, value, child) {
        if (value.loading) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black45,
            child: Center(
              child: Lottie.asset(
                'images/loading.json',
                height: 100.0,
              ),
            ),
          );
        } else if (value.registerSuccess) {
          return InkWell(
            child: Container(
              color: Colors.black87,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.white70,
                      size: 24.0,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kSignupSuccess,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Lottie.asset(
                          'images/success.json',
                          height: 300.0,
                          repeat: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Text(
                            kAlertSignupSuccess,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                alignment: Alignment.topRight,
              ),
            ),
            onTap: () => {
              Provider.of<FrontProvider>(context, listen: false)
                  .registerSuccess = false
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  bool _valid(
      {required Map<String, String> validator,
      required FormController? controller}) {
    bool valid = true;

    for (String key in validator.keys) {
      if (controller!.name(key)!.text.isEmpty) {
        valid = false;
        showMessage(validator[key]);
        break;
      }
    }

    return valid;
  }

  void showMessage(String? message) {
    showSnackBar(key: globalKey, message: message);
  }

  void _gotoLogin() {
    Provider.of<FrontProvider>(context, listen: false).state =
        PageState.LOGIN_PAGE;
    _blurController?.forward();
  }

  void _gotoRegister() {
    Provider.of<FrontProvider>(context, listen: false).state =
        PageState.REGISTER_PAGE;
    _blurController?.forward();
  }

  @override
  void dispose() {
    _blurAnimation = null;
    _blurController = null;
    super.dispose();
  }

  @override
  void backToFrontPage() {
    Provider.of<FrontProvider>(context, listen: false).state =
        PageState.FRONT_PAGE;
    _blurController?.forward();
  }

  @override
  void goToEnterCodePage() {
    // TODO: implement goToEnterCodePage
  }

  @override
  void goToNewPasswordPage() {
    // TODO: implement goToNewPasswordPage
  }

  @override
  void goToResetPasswordPage() {
    // TODO: implement goToResetPasswordPage
  }

  @override
  void gotoAppActivity() {
    // TODO: implement gotoAppActivity
  }

  @override
  void showMessageDialog({required String title, required String content}) {
    // TODO: implement showMessageDialog
  }
}

class FormController {
  Map<String, TextEditingController?> data = new Map();
  List<FocusNode> node = [];

  FormController(List<FocusNode> node) {
    this.node = node;
  }

  TextEditingController? name(String key) {
    TextEditingController? controller = data[key];
    if (controller == null) {
      controller = new TextEditingController();
      data.addAll({key: controller});
      node.add(new FocusNode());
    }
    return controller;
  }

  void clear() {
    data.keys.forEach((element) {
      data[element] = null;
    });
    data = new Map();
    node.clear();
  }
}
