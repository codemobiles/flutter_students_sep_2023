import 'package:demo0/src/bloc/home/home_bloc.dart';
import 'package:demo0/src/bloc/login/login_bloc.dart';
import 'package:demo0/src/constants/asset.dart';
import 'package:demo0/src/models/product.dart';
import 'package:demo0/src/pages/app_routes.dart';
import 'package:demo0/src/pages/home/widgets/dialog_barcode_image.dart';
import 'package:demo0/src/pages/home/widgets/dialog_qr_image.dart';
import 'package:demo0/src/pages/home/widgets/dialog_scan_qrcode.dart';
import 'package:demo0/src/pages/home/widgets/my_dialog_barcode_image.dart';
import 'package:demo0/src/pages/home/widgets/product_item.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setupNotification();
    context.read<HomeBloc>().add(HomeEventLoadProducts());
  }

  late FirebaseMessaging messaging;
  void setupNotification() {
    FirebaseMessaging.instance.getToken().then((value) {
      // print("Push Token: " + value.toString());
      print("Push Token: " + value.toString());
      FirebaseMessaging.instance.subscribeToTopic("all");
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

  @override
  Widget build(BuildContext context) {
    // final homeState = context.watch<HomeBloc>().state;
    // final homeState = BlocProvider.of<HomeBloc>(context, listen: true).state;

    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text("Home BlocV2"),
          actions: [
            IconButton(
              onPressed: () =>
                  context.read<HomeBloc>().add(HomeEventToggleDisplay()),
              icon: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return state.isGrid
                      ? const Icon(Icons.grid_3x3)
                      : const Icon(Icons.list);
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateManagementPage(),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final products = state.products;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeEventLoadProducts());
              },
              child: Container(
                child: state.isGrid
                    ? _buildGridView(products)
                    : _buildListView(products),
              ),
            );
          },
        ));
  }

  _navigateManagementPage([Product? product]) async {
    await Navigator.pushNamed(context, AppRoute.management, arguments: product);
    context.read<HomeBloc>().add(HomeEventLoadProducts());
  }

  Widget _buildListView(List<Product> products) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: SizedBox(
                  height: 350,
                  child: ProductItem(
                    product: products[index],
                    onTap: () => _navigateManagementPage(products[index]),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SizedBox(
              height: 350,
              child: ProductItem(
                product: products[index],
                onTap: () => _navigateManagementPage(products[index]),
              ),
            ),
          );
        }
      },
      itemCount: products.length,
    );
  }

  Widget _buildGridView(List<Product> products) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (context, index) {
              final productItemState = GlobalKey<ProductItemState>();

              return ProductItem(
                key: productItemState,
                isGrid: true,
                product: products[index],
                onTap: () => _navigateManagementPage(products[index]),
                // onTap: () => productItemState.currentState?.show(),
              );
            },
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio:
                  0.9, // set height ratio -  (itemWidth / itemHeight)
            ),
          ),
        ),
      ],
    );
  }

  _buildHeader() {
    return Container(
        child: Image.asset(
      Asset.logoImage,
      height: 100,
      width: double.infinity,
    ));
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  void _showDialogBarcode(context) {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialogBarCode(code: "123412341234");
      },
    );

    // showDialog<void>(
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (BuildContext dialogContext) => const DialogBarcodeImage(
    //     'www.codemobiles.com',
    //   ),
    // );
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfile(),
            ListTile(
              onTap: () => _showDialogBarcode(context),
              title: const Text("BarCode"),
              leading: const Icon(Icons.bar_chart_outlined,
                  color: Colors.deepOrange),
            ),
            ListTile(
              onTap: () => _showDialogQRImage(context),
              title: const Text("QRCode"),
              leading: const Icon(Icons.qr_code, color: Colors.green),
            ),
            ListTile(
              onTap: () => _showScanQRCode(context),
              title: const Text("Scanner"),
              leading:
                  const Icon(Icons.qr_code_scanner, color: Colors.blueGrey),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, AppRoute.map),
              title: const Text("Map"),
              leading: const Icon(Icons.map_outlined, color: Colors.blue),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, AppRoute.webview),
              title: const Text("Web"),
              leading: const Icon(Icons.web, color: Colors.purple),
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
              onTap: () =>
                  Navigator.pushNamed(context, AppRoute.firebase_store),
              title: const Text("FirebaseStore (Option)"),
              leading: const Icon(Icons.storage, color: Colors.red),
            ),
            ListTile(
              onTap: () =>
                  Navigator.pushNamed(context, AppRoute.firebase_analytics),
              title: const Text("FirebaseAnalytic (Option)"),
              leading: const Icon(Icons.analytics, color: Colors.purpleAccent),
            ),
            _buildLogoutButton(),
          ],
        ),
      ),
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
