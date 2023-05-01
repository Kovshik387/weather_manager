import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:floating_tabbar/Models/tab_item.dart';
import 'package:floating_tabbar/Widgets/nautics.dart';
import 'package:floating_tabbar/Widgets/top_tabbar.dart';
import 'package:floating_tabbar/floating_tabbar.dart';
import 'package:flutter/rendering.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp( debugShowCheckedModeBanner: false,
//       title: 'Авторизация', theme: ThemeData(primarySwatch: Colors.pink),
//       home: AuthorizationPage(title: 'Авторизация', database: FirebaseFirestore.instance),
//     );
//   }
// }

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key? key, required this.title, required this.database})
      : super(key: key);
  final String title;
  final FirebaseFirestore database;
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final Map<String, TextEditingController> _textFieldControllers =
      <String, TextEditingController>{};
  final List<DropdownMenuItem<String>> _menuItems = <DropdownMenuItem<String>>[
    DropdownMenuItem(value: "Нет значения", child: Text("Выберите город")),
    DropdownMenuItem(value: "Липецк", child: Text("Липецк")),
    DropdownMenuItem(value: "Воронеж", child: Text("Воронеж")),
    DropdownMenuItem(value: "Москва", child: Text("Москва")),
    DropdownMenuItem(value: "Санкт-Петербург", child: Text("Санкт-Петербург")),
  ];
  int _selectedPageIndex = 0;
  bool _passwordVisible = false, _licenseAccept = false;
  String _cityUserValue = '';

  _AuthorizationPageState() {
    for (final item in <String>[
      'login',
      'password',
      'email',
      'name',
      'surname'
    ]) {
      this
          ._textFieldControllers
          .addEntries({item: TextEditingController()}.entries);
    }
    this._cityUserValue = this._menuItems[0].value ?? ' ';
  }

  static Widget _textFieldView(
      {required String hintText,
      required BuildContext context,
      TextEditingController? controller,
      bool? obscureText,
      Widget? suffixElement,
      Color color = Colors.black}) {
    final decoration = InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        labelText: hintText,
        labelStyle:
            TextStyle(fontWeight: FontWeight.w400, color: color, fontSize: 14),
        suffixIcon: suffixElement,
        counterText: '',
        fillColor: Colors.white,
        filled: true);
    return Padding(
        child: Container(
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 0))
            ]),
            height: 42,
            child: TextField(
              style: TextStyle(fontSize: 14),
              autocorrect: false,
              maxLength: 40,
              decoration: decoration,
              controller: controller,
              obscureText: obscureText ?? false,
            )),
        padding: EdgeInsets.only(bottom: 20));
  }

  @override
  void dispose() {
    for (var item in this._textFieldControllers.entries) item.value.dispose();
    super.dispose();
  }

  String? _checkTextFieldsValidation({List<String>? formField}) {
    for (final record in this
        ._textFieldControllers
        .entries
        .map((item) => MapEntry(item.key, item.value.value.text))) {
      final value = record.value;
      if (formField != null && !formField.contains(record.key)) continue;

      if (value.trim().length != value.length ||
          value.split(' ').length != 1 ||
          value.length < 6) return '${record.key} неверно заполнен';
    }
    return null;
  }

  static final _showInfoDialog = (
          {required String text,
          required BuildContext context,
          String? title}) =>
      showDialog<String>(
          builder: (BuildContext context) => AlertDialog(
                  title: Text(title ?? 'Неверные данные',
                      textAlign: TextAlign.center),
                  content: Text(text,
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('OK'))
                  ]),
          context: context);

  void authorization() => Navigator.pushNamedAndRemoveUntil(
      context, '/authorize', (route) => false);

  void _loginButtonHandler() async {
    var validationCheck = this
        ._checkTextFieldsValidation(formField: <String>['login', 'password']);
    if (validationCheck != null) {
      _showInfoDialog(context: context, text: validationCheck);
      return;
    }

    var users = super.widget.database.collection('users');
    await users.get().then((QuerySnapshot<Map<String, dynamic>> value) {
      for (final document in value.docs) {
        if (document.data()['login'] ==
                this._textFieldControllers['login']!.value.text &&
            document.data()['password'] ==
                this._textFieldControllers['password']!.value.text) {
          _showInfoDialog(
              text: 'Вы вошли в профиль',
              context: context,
              title: 'Успешная работа');
          return this.authorization();
        }
      }
      _showInfoDialog(
          text: 'Данного пользователя нет',
          context: context,
          title: 'Профиль не найден');
    });
  }

  void _registrationButtonHandler() async {
    var users = super.widget.database.collection('users');
    var validationCheck = this._checkTextFieldsValidation();
    if (validationCheck != null) {
      _showInfoDialog(context: context, text: validationCheck);
      return;
    }

    var emailRegex = RegExp(r'^\w+@(gmail|mail|yandex).(ru|com)$');
    if (!emailRegex.hasMatch(this._textFieldControllers['email']!.value.text)) {
      _showInfoDialog(
          context: context, text: 'Адрес почты имеет неверный формат');
      return;
    }
    await users.get().then((QuerySnapshot<Map<String, dynamic>> value) {
      for (final userRecord in value.docs) {
        if (userRecord.data()['login'].toString() ==
            this._textFieldControllers['login']!.value.text) {
          setState(() => this._licenseAccept = false);
          return _showInfoDialog(
              text: 'Логин уже используется другим пользователем',
              context: context);
        }
        if (userRecord.data()['email'].toString() ==
            this._textFieldControllers['email']!.value.text) {
          setState(() => this._licenseAccept = false);
          return _showInfoDialog(
              text: 'Адрес почты уже используется другим пользователем',
              context: context);
        }
      }
    });
    if (!this._licenseAccept) return;
    var databaseValue = <String, dynamic>{'city': this._cityUserValue};
    for (final userInfo in this
        ._textFieldControllers
        .entries
        .map((item) => MapEntry(item.key, item.value.value))) {
      databaseValue.addEntries({userInfo.key: userInfo.value.text}.entries);
    }
    await users
        .doc('${databaseValue['login']}:${databaseValue['email']}')
        .set(databaseValue);
    _showInfoDialog(
        text: 'Профиль был создан', context: context, title: 'Успешная работа');
  }

  void _telegramButtonHandler() {}

  void _vkontacteButtonHandler() {}

  void _checkLicenseButtonHandler() {}

  Widget _customAuthorizationPageView(
      {required int pageIndex, required BuildContext buildContext}) {
    final renderHelpButton = (
        {required String icon,
        required String text,
        required Function() handler,
        MaterialColor? color}) {
      final elementColor = color ?? Theme.of(context).primaryColor;
      return Expanded(
          child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 0)),
        ]),
        child: ElevatedButton(
          child: Row(children: [
            ImageIcon(AssetImage(icon)),
            Container(
              child: Text(text),
              padding: EdgeInsets.only(left: 10),
            )
          ]),
          onPressed: handler,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(elementColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: elementColor),
              ),
            ),
          ),
        ),
      ));
    };

    final pagesList = <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: SafeArea(
          child: Column(children: [
            Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.center,
                    child: const Image(
                        image: AssetImage('assets/mainlogo.png'),
                        color: null,
                        width: 130,
                        height: 130))),
            Container(
                margin: const EdgeInsets.only(left: 20, bottom: 50),
                child: const Text(
                  'Авторизация',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'sans serif'),
                ),
                alignment: Alignment.centerLeft),
            _AuthorizationPageState._textFieldView(
                hintText: 'Введите Логин/Email',
                controller: this._textFieldControllers['login']!,
                context: context,
                color: Theme.of(context).primaryColor),
            _AuthorizationPageState._textFieldView(
                hintText: 'Введите пароль',
                controller: this._textFieldControllers['password']!,
                color: Theme.of(context).primaryColor,
                obscureText: !this._passwordVisible,
                suffixElement: IconButton(
                  icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black26),
                  onPressed: () {
                    setState(() => this._passwordVisible = !_passwordVisible);
                  },
                ),
                context: context),
            Row(children: [
              Expanded(
                  child: Container(
                      child: TextButton(
                        onPressed: this._loginButtonHandler,
                        child: const Text('Войти в профиль',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side:
                                        BorderSide(color: Colors.deepOrange)))),
                      ),
                      height: 50,
                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 0)),
                      ])))
            ], crossAxisAlignment: CrossAxisAlignment.center),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  renderHelpButton(
                      icon: 'assets/vkontacte.png',
                      handler: this._vkontacteButtonHandler,
                      text: 'Вконтакте',
                      color: Colors.indigo),
                  renderHelpButton(
                      icon: 'assets/telegram.png',
                      text: 'Телеграм',
                      color: Colors.blue,
                      handler: this._telegramButtonHandler),
                ],
              ),
            ))
          ], crossAxisAlignment: CrossAxisAlignment.center),
        ),
      ),
      // ТУТ РАБОТАТЬ
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 40),
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    const Image(
                        image: AssetImage('assets/mainlogo.png'),
                        width: 40,
                        height: 40,
                        alignment: Alignment.centerLeft),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'sans serif'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 125,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _AuthorizationPageState._textFieldView(
                      hintText: 'Введите Логин',
                      controller: this._textFieldControllers['login']!,
                      context: context,
                      color: Theme.of(context).primaryColor,
                    ),
                    _AuthorizationPageState._textFieldView(
                        hintText: 'Введите Пароль',
                        controller: this._textFieldControllers['password']!,
                        obscureText: !this._passwordVisible,
                        color: Theme.of(context).primaryColor,
                        suffixElement: IconButton(
                          icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black26),
                          onPressed: () {
                            setState(() =>
                                this._passwordVisible = !_passwordVisible);
                          },
                        ),
                        context: context)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 295,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 0)),
                        ],
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(25)),
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 0, bottom: 5),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Контактные данные:',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                        _AuthorizationPageState._textFieldView(
                            hintText: 'Укажите имя',
                            controller: this._textFieldControllers['name']!,
                            context: context),
                        _AuthorizationPageState._textFieldView(
                            hintText: 'Укажите фамилию',
                            controller: this._textFieldControllers['surname']!,
                            context: context),
                        Row(
                          children: [
                            Expanded( //нужен
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 0))
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                margin: EdgeInsets.only(bottom: 14),
                                child: DropdownButton(
                                  onChanged: (String? value) => setState(
                                      () => this._cityUserValue = value ?? ''),
                                  items: this._menuItems,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  value: this._cityUserValue,
                                  borderRadius: BorderRadius.circular(10),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _AuthorizationPageState._textFieldView(
                          hintText: 'Адрес почты',
                          controller: this._textFieldControllers['email']!,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 108,
              //child: Expanded(
                //flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Container(
                        child: Row(children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                            value: this._licenseAccept,
                            onChanged: (bool? value) {
                              setState(() => this._licenseAccept = value!);
                            },
                          ),
                          Container(
                            child:
                                Text('Принять', style: TextStyle(fontSize: 13)),
                            margin: EdgeInsets.only(left: 10),
                          ),
                          TextButton(
                            child: Text('Пользовательские соглашения',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context).primaryColor)),
                            onPressed: this._checkLicenseButtonHandler,
                          )
                        ]),
                        margin: EdgeInsets.only(bottom: 10)),
                    Row(children: [
                      Expanded(
                        child: Container(
                          child: TextButton(
                            onPressed: this._registrationButtonHandler,
                            child: Text('Зарегистрироваться',
                                style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Colors.deepOrange)))),
                          ),
                          height: 50,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ], mainAxisAlignment: MainAxisAlignment.end),
                ),
              //),
            ),
          ],
        ),
      ),
    ];
    return Center(child: pagesList[pageIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._customAuthorizationPageView(
          pageIndex: this._selectedPageIndex, buildContext: context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._selectedPageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Войти в профиль',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Регистрация',
              backgroundColor: Colors.white),
        ],
        onTap: (index) {
          this.setState(() => this._selectedPageIndex = index);
        },
      ),
    );
  }
}
