import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../auth/auth_provider.dart';
import '../chat_screen/chat_screen.dart';
import '../home_screen/home_screen.dart';
import '../profile_sreen/profile.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<Widget> _children = [
    const HomeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
  int _selectedIndex = 0;

  late UserModel user;
  @override
  void initState() {
    super.initState();
    user = context.read<Authentication>().loggedUser!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Social App'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        items: [
          BottomNavyBarItem(
            activeColor: Colors.greenAccent,
            title: const Text('Home'),
            icon: const Icon(Icons.home),
          ),
          BottomNavyBarItem(
            activeColor: Colors.greenAccent,
            title: const Text('Chats'),
            icon: const Icon(Icons.message, color: Colors.greenAccent),
          ),
          BottomNavyBarItem(
            activeColor: Colors.greenAccent,
            title: const Text('Pfofile'),
            icon: const Icon(Icons.person, color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }
}
