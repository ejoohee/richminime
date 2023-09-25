import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BankBook extends StatefulWidget {
  const BankBook({super.key});

  @override
  State<BankBook> createState() => _BankBookState();
}

class Transaction {
  final int amount;
  final String date;
  final int balance;
  final String transactionType;
  final String summary;

  Transaction({
    required this.amount,
    required this.date,
    required this.balance,
    required this.transactionType,
    required this.summary,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      date: json['date'],
      balance: json['balance'],
      transactionType: json['transactionType'],
      summary: json['summary'],
    );
  }
}

class _BankBookState extends State<BankBook> {
  Future<List<Transaction>> transactions =
      Future.value([]); // Transaction은 나중에 정의할 모델 클래스입니다.

  @override
  void initState() {
    super.initState();
    transactions = getBankList();
  }

  Future<List<Transaction>> getBankList() async {
    final url = Uri.parse("http://10.0.2.2:8080/api/bankbook");
    final response = await http.get(
      url,
      headers: {}, // Access token 넣어야 함
    );

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((e) => Transaction.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
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
            child: FutureBuilder<List<Transaction>>(
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
                      Transaction transaction = snapshot.data![index];
                      return Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(transaction.summary),
                          subtitle: Text(
                              'Date: ${transaction.date}, Amount: ${transaction.amount}, Balance: ${transaction.balance}, Type: ${transaction.transactionType}'),
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
