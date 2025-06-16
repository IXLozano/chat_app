import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final users = [
    User(uid: 1, name: 'Maria', email: 'user@gmail.com', online: false),
    User(uid: 2, name: 'Sofi', email: 'user@gmail.com', online: false),
    User(uid: 3, name: 'Liliana', email: 'user@gmail.com', online: true),
    User(uid: 4, name: 'Isaac', email: 'user@gmail.com', online: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My name'),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app_outlined)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle, //Icons.offline_bolt color red
              color: Colors.green[400],
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,

        header: const WaterDropMaterialHeader(
          color: Colors.white,
          distance: 30,
          offset: -8,
        ),
        child: _usersList(),
      ),
    );
  }

  ListView _usersList() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) => _userTile(users[index]),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userTile(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  void _loadUsers() async {
    final _ = await Future.delayed(
      const Duration(milliseconds: 1000),
      () => _refreshController.refreshCompleted(),
    );
  }
}
