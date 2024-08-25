import 'package:bytuswallet/presentation/main_screens/all_users.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await Dio().get('https://bytus.online/api/admin/users');
      setState(() {
        users = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: Expanded(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text('${user['first_name']} ${user['last_name']}'),
              subtitle: Text(user['email']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailPage(user: user),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
