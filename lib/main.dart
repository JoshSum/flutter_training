import 'package:flutter/material.dart';
import 'package:statefull_widget/screens/products/product_page.dart';
import './tabbarview/tabbarview1.dart' as home;
import './tabbarview/tabbarview2.dart' as gallery;
import './tabbarview/tabbarview3.dart' as account;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle letterStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(70, 132, 153, 1),
  );

  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        title: "Flutter First App",
        home: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                myCustomDrawerHeader(),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Home',
                    // style: letterStyle,
                  ),
                  leading: const Icon(Icons.home),
                  onTap: () => print('Homepage is opened'),
                ),
                ListTile(
                  title: const Text(
                    'Products',
                    // style: letterStyle,
                  ),
                  leading: const Icon(Icons.shopify),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductPage(),
                        ));
                  },
                ),
                ListTile(
                  title: const Text(
                    'Account',
                    // style: letterStyle,
                  ),
                  leading: const Icon(Icons.person),
                  onTap: () => print('Account is opened'),
                ),
              ],
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  floating: true,
                  snap: true,
                  pinned: true,
                  backgroundColor: const Color.fromARGB(255, 236, 214, 17),
                  leading: IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(Icons.menu),
                  ),
                  actions: <Widget>[
                    IconButton(
                        onPressed: () => print("Search Page"),
                        icon: const Icon(Icons.search)),
                    IconButton(
                        onPressed: () => print("Setting Page"),
                        icon: const Icon(Icons.settings))
                  ],
                  flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('Custom AppBar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    background: Image(
                      image: AssetImage('images/spongebob.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ];
            },
            body: TabBarView(controller: controller, children: const <Widget>[
              home.TabBarView1(),
              gallery.TabBarView2(),
              account.TabBarView3(),
            ]),
          ),
          bottomNavigationBar: Material(
            color: const Color.fromRGBO(70, 132, 153, 1),
            child: TabBar(controller: controller, tabs: const <Tab>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.photo)),
              Tab(icon: Icon(Icons.person))
            ]),
          ),
        ));
  }

  Widget myCustomDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('/images/spongebob1.jpg'), fit: BoxFit.fill),
        ),
        child: Stack(
          children: const <Widget>[
            Positioned(
              left: 20,
              bottom: 70,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2020/09/27/2954719809.png"),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 30,
              child: Text(
                "Custom Header Drawer",
                style: titleStyle,
              ),
            )
          ],
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
