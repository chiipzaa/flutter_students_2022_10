import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        child: TextButton(
          child: Text("ClickMe"),
          onPressed: () {},
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ListTile(
            onTap: () {},
            title: Text("BarCode"),
            leading: const FaIcon(FontAwesomeIcons.barcode, color: Colors.deepOrange),
          ),
          ListTile(
            onTap: () {},
            title: Text("QRCode"),
            leading: Icon(Icons.qr_code, color: Colors.green),
          ),
          ListTile(
            onTap: () {},
            title: Text("Scanner"),
            leading: const Icon(Icons.qr_code_scanner, color: Colors.blueGrey),
          ),
          ListTile(
            onTap: () {},
            title: Text("Map"),
            leading: Icon(Icons.map_outlined, color: Colors.blue),
          ),
          const Spacer(),
          _buildLogoutButton()
        ],
      ),
    );
  }

  Builder _buildLogoutButton() => Builder(
        builder: (context) => SafeArea(
          child: ListTile(leading: FaIcon(FontAwesomeIcons.signOutAlt), title: Text('Log out'), onTap: () {}),
        ),
      );

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
