import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/src/app.dart';
import 'package:flutter1/src/bloc/home/home_bloc.dart';
import 'package:flutter1/src/bloc/login/login_bloc.dart';
import 'package:flutter1/src/constants/asset.dart';
import 'package:flutter1/src/models/Product.dart';
import 'package:flutter1/src/pages/app_routes.dart';
import 'package:flutter1/src/pages/home/widgets/dialog_qr_image.dart';
import 'package:flutter1/src/pages/home/widgets/dialog_scan_qrcode.dart';
import 'package:flutter1/src/pages/home/widgets/product_item.dart';
import 'package:flutter1/src/services/network_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:barcode_widget/barcode_widget.dart';


import '../../constants/network_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeEvent_Fetch());
    setupNotification();
    super.initState();
  }


  void setupNotification(){
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      // print("Push Token: " + value.toString());
      loggerNoStack.i("Push Token: " + value.toString());
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  void _navigatorManagementPage([Product? product]) {
    Navigator.pushNamed(context, AppRoute.management, arguments: product).then(
      (value) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _count = context.read<HomeBloc>().state.count;
    // final _count = context.watch<HomeBloc>().state.count;

    return Scaffold(
      appBar: AppBar(
        title: Text("CodeMobiles Flutter"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigatorManagementPage(),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status != FetchStatus.success) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.black),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Loading"),
                ],
              ),
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
                    onTap: () => _navigatorManagementPage(products[index]),
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
                  onTap: () => _navigatorManagementPage(products[index]),
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
            onTap: () => _showBarcodeDialog(context),
            title: Text("BarCode"),
            leading: const FaIcon(FontAwesomeIcons.barcode, color: Colors.deepOrange),
          ),
          ListTile(
            onTap: () => _showDialogQRImage(context),
            title: Text("QRCode"),
            leading: Icon(Icons.qr_code, color: Colors.green),
          ),
          ListTile(
            onTap: () => _showScanQRCode(context),
            title: Text("Scanner"),
            leading: const Icon(Icons.qr_code_scanner, color: Colors.blueGrey),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AppRoute.map),
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

  void _showBarcodeDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              height: 200,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  BarcodeWidget(
                    // barcode: Barcode.qrCode(
                    //   errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                    // ),
                    barcode: Barcode.code128(),
                    data: "1234971234908",
                    width: 200,
                    drawText: true,
                    errorBuilder: (cxt, err) => const Center(
                      child: Text("Uh oh! Something went wrong..."),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Dismiss"),
                  )
                ],
              )),
            ),
          );
        });
  }

  void _showDialogQRImage(context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => const DialogQRImage(
        'www.codemobiles.com',
        image: Asset.pinBikerImage,
      ),
    );
  }

  void _showScanQRCode(context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => DialogScanQRCode(),
    );
  }
}
