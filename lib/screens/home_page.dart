import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:second_app/models/user.dart';
import 'package:second_app/screens/home_page_view.dart';
import 'package:second_app/service/service_info.dart';
import 'package:second_app/utils/common_loader.dart';
import 'package:second_app/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  final String? accessToken;
  final String? refreshToken;

  const HomePage({Key? key, this.accessToken, this.refreshToken})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

  @override
  void initState() {
    super.initState();

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = await ServiceInfo.fetchUserData(widget.accessToken!);
    if (user != null) {
      setState(() {
        _user = user;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch user data.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Home Page'),
      ),
      drawer: const CustomDrawer(),
      body: _user != null
          ? HomePageView(
              user: _user!,
              accessToken: widget.accessToken,
              refreshUserList: _fetchUserData,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}


