import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:cool_alert/cool_alert.dart';

class allaccounts extends StatefulWidget {
  @override
  _allaccountsState createState() => _allaccountsState();
}

// ignore: camel_case_types
class _allaccountsState extends State<allaccounts> {
  int n;
  final accountHolderSent = TextEditingController();
  final amount = TextEditingController();
  final accountHolderRecieved = TextEditingController();
  String RamDocId, SamDocId, AnnieDocId;
  String name1, name2;
  int RamPrevAmt, SamPrevAmt, AnniePrevAmt;
  int bal;
  getUserRecieved(name1) {
    this.name1 = name1;
  }

  getUserSent(name2) {
    this.name2 = name2;
  }

  getAmount(bal) {
    this.bal = int.parse(bal);
  }

  readData() {
    print('Button Clicked!');

    if ((name1 == "Sam" || name1 == "Ram" || name1 == "Annie") &&
            name2 == "Sam" ||
        name2 == "Ram" ||
        name2 == "Annie") {
      if ((name1 == "Sam" && name2 == "Ram") ||
          (name1 == "Ram" && name2 == "Sam")) {
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('Accounts')
            .doc('t2hy7D9MtJVdl4em36e8');
        documentReference.get().then((value) {
          SamPrevAmt = value.data()['Balance'];
          SamDocId = value.id;
        });
        DocumentReference documentReference2 = FirebaseFirestore.instance
            .collection('Accounts')
            .doc('uM2t4JstcmrqFU2gR9gB');
        documentReference2.get().then((value) {
          RamPrevAmt = value.data()['Balance'];
          RamDocId = value.id;
          // print(SamPrevAmt);
        });
      } else if ((name1 == "Ram" && name2 == "Annie") ||
          (name1 == "Annie" && name2 == "Ram")) {
        DocumentReference documentReference2 = FirebaseFirestore.instance
            .collection('Accounts')
            .doc('uM2t4JstcmrqFU2gR9gB');
        documentReference2.get().then((value) {
          RamPrevAmt = value.data()['Balance'];
          RamDocId = value.id;
          // print(RamPrevAmt);
        });
        DocumentReference documentReference3 = FirebaseFirestore.instance
            .collection('Accounts')
            .doc('R3msRrNVHMxJsxjR1CkH');
        documentReference3.get().then((value) {
          AnniePrevAmt = value.data()['Balance'];
          AnnieDocId = value.id;
        });
      } else {
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('Accounts')
            .doc('t2hy7D9MtJVdl4em36e8');
        documentReference.get().then((value) {
          SamPrevAmt = value.data()['Balance'];
          SamDocId = value.id;
        });
        DocumentReference documentReference3 = FirebaseFirestore.instance
            .collection('Accounts')
            .doc('uM2t4JstcmrqFU2gR9gB');
        documentReference3.get().then((value) {
          AnniePrevAmt = value.data()['Balance'];
          AnnieDocId = value.id;
        });
      }
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Name doesn't exist!",
      );
    }
  }

  Future<void> updateReceiverBalance() {
    print("Inside Reciever Sender");

    print(bal);
    print(SamPrevAmt);
    print(RamPrevAmt);
    if (name1 == "Sam" && (name2 == "Ram" || name2 == "Annie")) {
      print(SamPrevAmt);
      print("Inside Sam");
      SamPrevAmt = SamPrevAmt + bal;

      DocumentReference documentReference2 =
          FirebaseFirestore.instance.collection('Accounts').doc(SamDocId);

      return documentReference2.update({'Balance': SamPrevAmt}).then((value) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Transaction successful!",
        );
      }).catchError((error) => print("Failed to update user: $error"));
    } else if (name1 == "Ram" && (name2 == "Sam" || name2 == "Annie")) {
      print(RamPrevAmt);

      RamPrevAmt = RamPrevAmt + bal;

      DocumentReference documentReference1 =
          FirebaseFirestore.instance.collection('Accounts').doc(RamDocId);
      return documentReference1.update({'Balance': RamPrevAmt}).then((value) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Transaction successful!",
        );
      }).catchError((error) => print("Failed to update user: $error"));
    } else {
      AnniePrevAmt = AnniePrevAmt + bal;

      DocumentReference documentReference1 =
          FirebaseFirestore.instance.collection('Accounts').doc(RamDocId);
      return documentReference1.update({'Balance': AnniePrevAmt}).then((value) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Transaction successful!",
        );
      }).catchError((error) => print("Failed to update user: $error"));
    }
  }

  Future<void> updateSenderBalance() {
    if (name1 != null || name2 != null) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        text: "Enter all the fields !",
      );
    }
    print("Inside Update Sender");
    print(bal);
    print(SamPrevAmt);
    print(RamPrevAmt);
    if (name1 == "Sam") {
      if (name2 == "Ram") {
        print("Inside Sam");
        RamPrevAmt = RamPrevAmt - bal;
        DocumentReference documentReference2 =
            FirebaseFirestore.instance.collection('Accounts').doc(RamDocId);

        return documentReference2.update({'Balance': RamPrevAmt}).then((value) {
          print("User updated");
        }).catchError((error) => print("Failed to update user: $error"));
      } else {
        print(AnniePrevAmt);
        print("Inside Annie");
        AnniePrevAmt = AnniePrevAmt - bal;
        DocumentReference documentReference2 =
            FirebaseFirestore.instance.collection('Accounts').doc(AnnieDocId);
        return documentReference2
            .update({'Balance': AnniePrevAmt}).then((value) {
          print("User updated");
        }).catchError((error) => print("Failed to update user: $error"));
      }
    } else if (name1 == "Ram") {
      if (name2 == "Sam") {
        print(SamPrevAmt);
        SamPrevAmt = SamPrevAmt - bal;
        DocumentReference documentReference1 =
            FirebaseFirestore.instance.collection('Accounts').doc(SamDocId);
        return documentReference1.update({'Balance': SamPrevAmt}).then((value) {
          print("User updated");
        }).catchError((error) => print("Failed to update user: $error"));
      } else {
        print(AnniePrevAmt);
        print("Inside Annie");
        AnniePrevAmt = AnniePrevAmt - bal;
        DocumentReference documentReference2 =
            FirebaseFirestore.instance.collection('Accounts').doc(AnnieDocId);
        return documentReference2
            .update({'Balance': AnniePrevAmt}).then((value) {
          print("User updated");
        }).catchError((error) => print("Failed to update user: $error"));
      }
    } else {
      if (name2 == "Sam") {
        print(SamPrevAmt);
        SamPrevAmt = SamPrevAmt - bal;
        DocumentReference documentReference1 =
            FirebaseFirestore.instance.collection('Accounts').doc(SamDocId);
        return documentReference1.update({'Balance': SamPrevAmt}).then((value) {
          print("User updated");
        }).catchError((error) => print("Failed to update user: $error"));
      } else {
        print(RamPrevAmt);
        print("Inside Ram");
        RamPrevAmt = AnniePrevAmt - bal;
        DocumentReference documentReference2 =
            FirebaseFirestore.instance.collection('Accounts').doc(RamDocId);
        return documentReference2.update({'Balance': RamPrevAmt}).then((value) {
          print("User updated");
        }).catchError((error) => print("Failed to update user: $error"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        title: Text('BankPurse'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Accounts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text('No Accounts');
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                child: Column(
                  children: [
                    Card(
                      color: Colors.purple[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SizedBox(
                        width: 380,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  document['Account Holder']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  document['Balance'].toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  document['IFSC code'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  document['Bank Name'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  color: Colors.white,
                                  textColor: Colors.purple[900],
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)), //this right here
                                            child: Container(
                                              height: 300,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 8),
                                                      child: TextField(
                                                        controller:
                                                            accountHolderRecieved,
                                                        onChanged:
                                                            (String name2) {
                                                          getUserSent(name2);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Enter your Money Sender',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 8),
                                                      child: TextField(
                                                        controller:
                                                            accountHolderSent,
                                                        onChanged:
                                                            (String name1) {
                                                          getUserRecieved(
                                                              name1);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Enter your Reciever Name',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 8),
                                                      child: TextField(
                                                        controller: amount,
                                                        onChanged:
                                                            (String bal) {
                                                          getAmount(bal);
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Enter Amount to be transferred',
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 320.0,
                                                      // ignore: deprecated_member_use
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          readData();
                                                          updateSenderBalance();
                                                          updateReceiverBalance();
                                                        },
                                                        child: Text(
                                                          "Transfer",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color: const Color(
                                                            0xFF1BC0C5),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text('TRANSFER MONEY'),
                                ),
                              ),
                            ],
                          ), //Column
                        ), //Padding
                      ), //SizedBox
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
