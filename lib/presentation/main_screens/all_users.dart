// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class UserDetailPage extends StatefulWidget {
  final Map user;

  const UserDetailPage({super.key, required this.user});

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final _btcBalanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _btcBalanceController.text = widget.user['btc_balance'];
  }

  Future<void> updateBtcBalance() async {
    try {
      final response = await Dio().post(
        'https://bytus.online/api/admin/users/${widget.user['id']}',
        data: {
          'btc_balance': _btcBalanceController.text,
        },
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('BTC Balance updated successfully')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update BTC Balance')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Name: ${widget.user['first_name']} ${widget.user['last_name']}'),
            const SizedBox(height: 8),
            Text('Email: ${widget.user['email']}'),
            const SizedBox(height: 8),
            const Text('BTC Balance:'),
            TextField(
              controller: _btcBalanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'BTC Balance',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateBtcBalance,
              child: const Text('Update BTC Balance'),
            ),
          ],
        ),
      ),
    );
  }
}
