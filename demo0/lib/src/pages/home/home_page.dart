import 'package:demo0/src/bloc/login/login_bloc.dart';
import 'package:demo0/src/constants/asset.dart';
import 'package:demo0/src/constants/network_api.dart';
import 'package:demo0/src/models/product.dart';
import 'package:demo0/src/pages/app_routes.dart';
import 'package:demo0/src/pages/home/widgets/dialog_barcode_image.dart';
import 'package:demo0/src/pages/home/widgets/dialog_qr_image.dart';
import 'package:demo0/src/pages/home/widgets/dialog_scan_qrcode.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// final vs const

class _HomePageState extends State<HomePage> {
  List<Product> products = [];

  @override
  initState() {
    super.initState();

    _loadData();
  }

  _loadData() async {
    final dio = Dio();
    final result = await dio.get(NetworkAPI.baseURL + "/products");
    products = productFromJson(result.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        drawer: CustomDrawer(),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Text(products[index].name!);
          },
        ));
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  void _showDialogBarcode(context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => const DialogBarcodeImage(
        'www.codemobiles.com',
      ),
    );
  }

  void _showDialogQRImage(context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => const DialogQRImage(
        'www.codemobiles.com',
      ),
    );
  }

  void _showScanQRCode(context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => const DialogScanQRCode(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ListTile(
            onTap: () => _showDialogBarcode(context),
            title: const Text("BarCode"),
            leading:
                const Icon(Icons.bar_chart_outlined, color: Colors.deepOrange),
          ),
          ListTile(
            onTap: () => _showDialogQRImage(context),
            title: const Text("QRCode"),
            leading: const Icon(Icons.qr_code, color: Colors.green),
          ),
          ListTile(
            onTap: () => _showScanQRCode(context),
            title: const Text("Scanner"),
            leading: const Icon(Icons.qr_code_scanner, color: Colors.blueGrey),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AppRoute.map),
            title: const Text("Map"),
            leading: const Icon(Icons.map_outlined, color: Colors.blue),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AppRoute.sqlite),
            title: const Text("SQLite3 (Option)"),
            leading: const Icon(Icons.table_rows_sharp, color: Colors.blue),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AppRoute.firebase_push),
            title: const Text("FirebasePush (Option)"),
            leading: const Icon(Icons.message, color: Colors.yellow),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AppRoute.firebase_auth),
            title: const Text("FirebaseAuth (Option)"),
            leading: const Icon(Icons.local_fire_department_rounded,
                color: Colors.orange),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AppRoute.firebase_store),
            title: const Text("FirebaseStore (Option)"),
            leading: const Icon(Icons.storage, color: Colors.red),
          ),
          ListTile(
            leading: Icon(Icons.abc, color: Colors.pink),
            trailing: Icon(Icons.inbox),
            title: Text("FirebaseAnalytic (Option)"),
            onTap: () => _showDialog(context),
          ),
          const Spacer(),
          _buildLogoutButton(),
          const Spacer(),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    // print("Hey");
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("I am lek"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Close"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  UserAccountsDrawerHeader _buildProfile() => UserAccountsDrawerHeader(
        currentAccountPicture: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            backgroundImage: AssetImage(Asset.cmLogoImage),
          ),
        ),
        accountName: const Text('CMDev'),
        accountEmail: const Text('support@codemobiles.com'),
      );

  Builder _buildLogoutButton() => Builder(
        builder: (context) => SafeArea(
          child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              onTap: () => context.read<LoginBloc>().add(LoginEventLogout())),
        ),
      );
}
