import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CodeMobiles"),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        _buildProfile()
      ],),
    );
  }


  UserAccountsDrawerHeader _buildProfile() => UserAccountsDrawerHeader(
    currentAccountPicture: Container(
      child: const CircleAvatar(
        backgroundImage: NetworkImage('https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png'),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    ),
    accountName: Text('CMDev'),
    accountEmail: Text('support@codemobiles.com'),
  );

}
