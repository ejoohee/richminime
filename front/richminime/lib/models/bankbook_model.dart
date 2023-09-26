class BankbookModel {
  int? bankBookId;
  int? amount;
  DateTime? date;
  int? balance;
  String? transactionType;
  String? summary;

  BankbookModel(
      {this.bankBookId,
      this.amount,
      this.date,
      this.balance,
      this.transactionType,
      this.summary});

  BankbookModel.fromJson(Map<String, dynamic> json) {
    bankBookId = json['bankBookId'];
    amount = json['amount'];
    date = json['date'];
    balance = json['balance'];
    transactionType = json['transactionType'];
    summary = json['summary'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['bankBookId'] = bankBookId;
  //   data['amount'] = amount;
  //   data['date'] = date;
  //   data['balance'] = balance;
  //   data['transactionType'] = transactionType;
  //   data['summary'] = summary;
  //   return data;
  // }
}
