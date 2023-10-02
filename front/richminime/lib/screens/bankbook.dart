import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:richminime/models/bankbook_model.dart';
import 'package:richminime/services/bankbook_service.dart';
import 'dart:convert';

class BankBook extends StatefulWidget {
  const BankBook({super.key});

  @override
  State<BankBook> createState() => _BankBookState();
}

class _BankBookState extends State<BankBook> {
  late Future<List<BankbookModel>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = BankbookService().getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(40),
            child: const Text(
              "잔액 : ",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<BankbookModel>>(
              future: transactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('내역이 존재하지 않습니다.'));
                } else {
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      BankbookModel transaction = snapshot.data![index];
                      return Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text({transaction.summary}.toString()),
                          subtitle: Text(
                              '날짜: ${transaction.date}, 금액: ${transaction.amount}, 잔액: ${transaction.balance}, 타입: ${transaction.transactionType}'),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
