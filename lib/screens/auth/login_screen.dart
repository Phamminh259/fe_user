import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:jobfe/features/login_form.dart';
import 'package:jobfe/screens/auth/register_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late ValueNotifier<int> _tabIndexBasicToggle;
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    int indexScreen = widget.tabIndex;
    _tabIndexBasicToggle = ValueNotifier(indexScreen);
  }

  // Sửa: dùng 'title' thay vì 'child' vì DataTab không hỗ trợ 'child'
  List<DataTab> get _listDataTabs => [
    DataTab(title: "Sign up"),
    DataTab(title: "Sign in"),
  ];

  double heightInPercent(double percent, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (percent / 100) * screenHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/loginbg.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
              child: basicTabToggle(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget basicTabToggle(BuildContext context) => Column(
    children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(EneftyIcons.briefcase_bold, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'TOP VIEC LAM',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      ValueListenableBuilder<int>(
        valueListenable: _tabIndexBasicToggle,
        builder: (context, currentIndex, _) {
          return FlutterToggleTab(
            width: 60,
            borderRadius: 30,
            height: 45,
            selectedIndex: _tabIndexBasicToggle.value,
            marginSelected: const EdgeInsets.all(5.0),
            selectedBackgroundColors: const [Colors.red, Colors.redAccent],
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
            ),
            isScroll: false,
            dataTabs: _listDataTabs,
            selectedLabelIndex: (index) {
              _tabIndexBasicToggle.value = index;
            },
          );
        },
      ),
      SizedBox(height: heightInPercent(3, context)),
      ValueListenableBuilder<int>(
        valueListenable: _tabIndexBasicToggle,
        builder: (context, currentIndex, _) {
          if (currentIndex == 0) {
            return const RegisterForm();
          } else {
            return const LoginForm();
          }
        },
      ),
    ],
  );
}
