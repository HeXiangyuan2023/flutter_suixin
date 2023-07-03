import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:suixin_app/app_colors.dart';
import 'package:toast/toast.dart';

import 'package:suixin_app/api/beans/message_model.dart';
import 'package:suixin_app/api/biz_error.dart';
import 'package:suixin_app/api/http_apis.dart';
import 'package:suixin_app/common/cookie_manager.dart';
import 'package:suixin_app/routers.dart';
import 'package:suixin_app/typography.dart';
import 'package:suixin_app/widgets/loading.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class TestPage extends StatelessWidget, {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: Text('NestedScrollView'),
            pinned: true,
            floating: true,
            snap: true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: 'Tab1'),
                Tab(text: 'Tab2'),
              ],
            ),
          ),
        ];
      },
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: TabBarView(
          controller: TabController(length: 2, vsync: this),
          children: <Widget>[
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _onRefresh() {
    return Future.value();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      routerConfig: routers,
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Role> roles = [];
  int _stamina = 0;

  @override
  void initState() {
    super.initState();
    showLoading();
    if (UserManager().isLogin()) {
      HttpApis().getHomeRoles().then((value) {
        setState(() {
          roles = value?.roles ?? [];
          _stamina = value?.stamina ?? 0;
        });
        dismissLoading();
      }).onError((error, stackTrace) {
        dismissLoading();
        if (error is XTBizError && error.code == "401") {
          AppRouters.pushToLogin(context);
        }
      });
    } else {
      AppRouters.pushToLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(""),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    padding:
                        EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.yellow,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: Colors.orange,
                        ),
                        Text(
                          "$_stamina 体力",
                          style: const TextStyle(
                              color: Colors.orange, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('分享得体力'),
              onTap: () {
                AppRouters.pushToShare(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 72, left: 12, right: 12),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          CircleAvatar(
            child: SizedBox(
                width: 160,
                child: Image.asset(
                  "assets/images/app_logo.png",
                  fit: BoxFit.fill,
                )),
          ),
          const SizedBox(height: 12),
          const Text("随心 AI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
              child: ListView.builder(
            itemCount: roles.length,
            itemBuilder: (context, index) {
              return RoleItemWidget(
                id: roles[index].id ?? 0,
                avatar: roles[index].pic ?? "",
                name: roles[index].name ?? "",
                desc: roles[index].chat?.content ?? "",
              );
            },
          ))
        ]),
      ),
    );
  }
}

class RoleItemWidget extends StatelessWidget {
  final String name;
  final int id;
  final String avatar;
  final String desc;
  const RoleItemWidget(
      {super.key,
      required this.name,
      required this.avatar,
      required this.desc,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!UserManager().isLogin()) {
          context.push("/mobile-login");
        } else {
          AppRouters.pushToChat(context,
              roleId: id.toString(), roleName: name, rolePic: avatar);
        }
      },
      child: Card(
        elevation: 0.3,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Row(
            children: [
              CircleAvatar(
                  child: Image.network(
                avatar,
                fit: BoxFit.fill,
              )),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.h2(),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.h3(),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
