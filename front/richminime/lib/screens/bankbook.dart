import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:richminime/models/bankbook_model.dart';
import 'package:richminime/services/bankbook_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/widgets/appbar_back_home.dart';

class BankBook extends StatefulWidget {
  const BankBook({super.key});

  @override
  State<BankBook> createState() => _BankBookState();
}

class _BankBookState extends State<BankBook> {
  late Future<List<BankbookModel>> transactions;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    transactions = BankbookService().getAllBankBookList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBackHome(title: "통장"),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(40),
            child: FutureBuilder<String?>(
              future: storage.read(key: "balance"),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    "잔액 : ${snapshot.data} 코인",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  );
                }
              },
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
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: (transaction.transactionType == "적립" ||
                                  transaction.transactionType == "판매")
                              ? Colors.green[200]
                              : Colors.red[200],
                          child: ListTile(
                            isThreeLine: true,
                            title: Text(
                              DateFormat("yyyy-MM-dd")
                                  .format(transaction.date!),
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${transaction.summary}'),
                                    Text((transaction.transactionType == "적립" ||
                                            transaction.transactionType == "판매")
                                        ? '+ ${transaction.amount}'
                                        : '- ${transaction.amount}'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('잔액: ${transaction.balance}'),
                                  ],
                                )
                              ],
                            ),
                          ),
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
