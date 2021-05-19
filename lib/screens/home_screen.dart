import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bankingapp/screens/all_accounts.dart';
import 'package:bankingapp/screens/view_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        title: Center(child: Text('BankPurse')),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(5),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 8),
        child: ListView(
          children: [
            Container(
              child: Center(
                /** Card Widget **/
                child: Card(
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.purple[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SizedBox(
                    width: 380,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Text(
                              'Welcome!',
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Center(
                            child: Text(
                              'Transfer money on the go!',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ), //Column
                    ), //Padding
                  ), //SizedBox
                ), //Card
              ),
            ),
            Container(
              child: Image.asset(
                'assets/images/payMoney.gif',
                height: 300,
                width: 200,
              ),
            ),
            Container(
              child: Center(
                child: RaisedButton(
                  child: Text('QUICK TRANSFER'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => allaccounts()));
                    /* DocumentSnapshot variable = await FirebaseFirestore.instance
                      .collection('Accounts')
                      .doc('uM2t4JstcmrqFU2gR9gB')
                      .get();
                  print(variable['Account Holder']);*/
                  },
                ),
              ),
            ),
            Container(
              child: Center(
                child: RaisedButton(
                  child: Text('VIEW USER'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => viewUser()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
