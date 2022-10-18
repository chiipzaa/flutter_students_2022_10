import 'package:flutter/material.dart';
import 'package:flutter1/src/bloc/home/home_bloc.dart';
import 'package:flutter1/src/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final _count = context.read<HomeBloc>().state.count;
    // final _count = context.watch<HomeBloc>().state.count;

    return Scaffold(
      appBar: AppBar(
        title: Text("CodeMobiles"),
      ),
      drawer: CustomDrawer(),
      body: _showGridView(),
    );
  }

  _showBlocDemo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text("Add"),
                onPressed: () {
                  context.read<HomeBloc>().add(HomeEvent_Add());
                },
              ),
              TextButton(
                child: Text("Delete"),
                onPressed: () {
                  context.read<HomeBloc>().add(HomeEvent_Delete());
                },
              )
            ],
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Text("Counter ${state.count}");
            },
          )
        ],
      ),
    );
  }

  _showListView() {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return Text(
          "1234",
          style: TextStyle(fontSize: 20),
        );
      },
    );
  }

  _showGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 0.9, // set height ratio -  (itemWidth / itemHeight)
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.red,
          child: Center(
            child: Text("1234"),
          ),
        );
      },
      itemCount: 40,
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
          child: ListTile(
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
            title: Text('Log out'),
            onTap: () => context.read<LoginBloc>().add(LoginEvent_Logout()),
          ),
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
