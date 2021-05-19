import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:cool_alert/cool_alert.dart';

class viewUser extends StatefulWidget {
  @override
  _viewUserState createState() => _viewUserState();
}

class _viewUserState extends State<viewUser> {
  final User = TextEditingController();
  String name, UserId, UserName, UserBank, UserCode;
  int UserAmt;
  getUser(name) {
    this.name = name;
  }

  displayData() {
    if (name == "Sam") {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Accounts')
          .doc('t2hy7D9MtJVdl4em36e8');
      documentReference.get().then((value) {
        UserAmt = value.data()['Balance'];
        UserBank = value.data()['Bank Name'];
        UserCode = value.data()['IFSC code'];
        UserName = value.data()['Account Holder'];
        UserId = value.id;
        CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            title: "Name: $UserName\n\n",
            text: "Bank Name: $UserBank\n\n"
                "IFSC Code: $UserCode\n\n"
                "Document Id: $UserId\n\n"
                "Balance: $UserAmt\n\n");
      });
    } else if (name == "Ram") {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Accounts')
          .doc('uM2t4JstcmrqFU2gR9gB');
      documentReference.get().then((value) {
        UserAmt = value.data()['Balance'];
        UserBank = value.data()['Bank Name'];
        UserCode = value.data()['IFSC code'];
        UserName = value.data()['Account Holder'];
        UserId = value.id;
        CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            title: "Name: $UserName\n\n",
            text: "Bank Name: $UserBank\n\n"
                "IFSC Code: $UserCode\n\n"
                "Document Id: $UserId\n\n"
                "Balance: $UserAmt\n\n");
      });
    } else if (name == "Annie") {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Accounts')
          .doc('R3msRrNVHMxJsxjR1CkH');
      documentReference.get().then((value) {
        UserAmt = value.data()['Balance'];
        UserBank = value.data()['Bank Name'];
        UserCode = value.data()['IFSC code'];
        UserName = value.data()['Account Holder'];
        UserId = value.id;
        CoolAlert.show(
            context: context,
            type: CoolAlertType.info,
            title: "Name: $UserName\n\n",
            text: "Bank Name: $UserBank\n\n"
                "IFSC Code: $UserCode\n\n"
                "Document Id: $UserId\n\n"
                "Balance: $UserAmt\n\n");
      });
    } else if (name == " " || name == null) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Enter field",
      );
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Name does not exist",
      );
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
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return Text('No Accounts');
            }

            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Align(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: TextField(
                          controller: User,
                          cursorColor: Colors.purple,
                          style: TextStyle(color: Colors.white),
                          onChanged: (String name) {
                            getUser(name);
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Enter your Account Holder',
                            labelStyle: TextStyle(color: Colors.purple[300]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          displayData();
                        },
                        child: Text('View'),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Transfer Money!'),
                      ),
                    ),
                  ),
                ]);
          }),
    );
  }
}
