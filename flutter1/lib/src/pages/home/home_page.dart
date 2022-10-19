import 'package:flutter/material.dart';
import 'package:flutter1/src/bloc/home/home_bloc.dart';
import 'package:flutter1/src/bloc/login/login_bloc.dart';
import 'package:flutter1/src/constants/asset.dart';
import 'package:flutter1/src/models/Product.dart';
import 'package:flutter1/src/pages/app_routes.dart';
import 'package:flutter1/src/pages/home/widgets/product_item.dart';
import 'package:flutter1/src/services/network_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/network_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeEvent_Fetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _count = context.read<HomeBloc>().state.count;
    // final _count = context.watch<HomeBloc>().state.count;

    return Scaffold(
      appBar: AppBar(
        title: Text("CodeMobiles"),
        actions: [
          TextButton(
            onPressed: () => context.read<HomeBloc>().add(HomeEvent_ToggleGridAndListView()),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Icon(
                  state.isGrid ? Icons.grid_3x3 : Icons.list,
                  color: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status != FetchStatus.success) {
            return const Center(
              child: Text("Loading"),
            );
          }
          final products = state.products;
          return RefreshIndicator(
            child: state.isGrid ? _showGridView(products) : _showListView(products),
            onRefresh: () async {
              context.read<HomeBloc>().add(HomeEvent_Fetch());
            },
          );
        },
      ),
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

  _buildHeader() {
    return Container(
        color: Colors.black87,
        child: Image.asset(
          Asset.logoImage,
          height: 100,
          width: double.infinity,
        ));
  }

  _showListView(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        if (index == 0) {
          return Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: SizedBox(
                  child: ProductItem(
                    product: products[index],
                    onTap: () => Navigator.pushNamed(context, AppRoute.management),
                  ),
                  height: 350,
                ),
              ),
            ],
          );
        }

        return SizedBox(
          height: 350,
          child: ProductItem(
            product: product,
            onTap: () => Navigator.pushNamed(context, AppRoute.management),
          ),
        );
      },
    );
  }

  _showGridView(List<Product> products) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 0.9, // set height ratio -  (itemWidth / itemHeight)
            ),
            itemBuilder: (context, index) {
              return Container(
                child: ProductItem(
                  isGrid: true,
                  product: products[index],
                  onTap: () => Navigator.pushNamed(context, AppRoute.management),
                ),
              );
            },
            itemCount: products.length,
          ),
        ),
      ],
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
