import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NextRentBillCycle.dart';

class BillTabAction extends StatefulWidget {
  const BillTabAction({Key? key}) : super(key: key);

  @override
  State<BillTabAction> createState() => _BillTabActionState();
}

List<ViewBloodHospitalModel> selectedItems = [];

class _BillTabActionState extends State<BillTabAction> {
  TextEditingController advanceAmount = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController fiexedChareeleController = TextEditingController();
  TextEditingController fiexedCharewaterController = TextEditingController();
  TextEditingController fiexedCharegasController = TextEditingController();

  bool showRentCycle = true;
  bool showPreviousBalance = true;
  bool monthlyData = true;
  bool showFixedCharges = true;
  bool showElectricBill = true;
  bool showWaterBill = true;
  bool showGasBill = true;
  bool showFiexedElctricCharge = true;
  bool showFiexedWaterCharge = true;
  bool showFiexedGasCharge = true;
  bool showSubMeterElctricCharge = true;

  int selectedCycleIndex = 0;
  int selectedIndexPreviousBalance = 0;
  int selectedIndexDays = 0;
  int selectedIndexRentPayment = 1;
  int paymentDay = 1;
  int paymentRequired = 3;

  double previousBalance = 0.0;
  double rentFee = 0.0;
  double maintenanceFee = 0.0;
  double FixedChargeele = 0.0;
  double FixedChargewater = 0.0;
  double FixedChargegas = 0.0;

  String electricityBillType = '';
  String waterBillType = '';
  String gasBillType = '';
  String rentCycle = '';
  String previousBalanceType = '';

  final List<String> rentCycles = ["Monthly"];
  final List<String> weeks = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  final List<String> balance = ['Monthly', 'Pending', 'NoBalance'];
  final List<String> dayNames = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
  ];
  final List<String> paymentDaysList = ['3', '5', '7', '10'];

  String selectedPropertyId = '';
  String selectedSubProptyId = '';
  String userId = '';

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.green,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text('RENTTAS ', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 20,
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'When Do You Collect Rent',
              style: TextStyle(color: Colors.grey, fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (showRentCycle) showDefultData(),
                if (!showRentCycle) showDataWiget(),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 5),
                  padding: EdgeInsets.only(left: 15),
                  height: 20,
                  width: double.infinity,
                  // color: Colors.grey,
                  child: Text(
                    'Monthly Fixed Charges',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      if (showPreviousBalance)
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10, left: 10),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 50, left: 10),
                                child: Text(
                                  'Previous Balance ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _previousBalance((updatedBalance) {
                                    setState(() {
                                      previousBalance = updatedBalance;
                                      showPreviousBalance = false;
                                    });
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.add,
                                              color: Colors.blueAccent),
                                          Text(
                                            "Add",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlueAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!showPreviousBalance)
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10, left: 10),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 50, left: 10),
                                child: Text(
                                  'Previous Balance ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _previousBalance((updatedBalance) {
                                    setState(() {
                                      previousBalance = updatedBalance;
                                      showPreviousBalance = false;
                                    });
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      child: InkWell(
                                        child: Text(
                                          previousBalance.toString() + " >",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (showFixedCharges)
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 70, left: 10),
                                    child: Text(
                                      'Fixed Charges ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _fixedCharges((rentAmount) {
                                        rentFee = rentAmount;
                                      }, (maintenance) {
                                        maintenanceFee = maintenance;
                                      });
                                      showFixedCharges = false;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 70),
                                      child: InkWell(
                                          child: Text(
                                        '+Add ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightBlueAccent),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      if (!showFixedCharges)
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 70, left: 10),
                                    child: Text(
                                      'Rent Amount ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _fixedCharges((rentAmount) {
                                        rentFee = rentAmount;
                                      }, (maintenance) {
                                        maintenanceFee = maintenance;
                                      });
                                      showFixedCharges = false;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Icon(Icons.currency_rupee,
                                              color: Colors.grey),
                                          InkWell(
                                              child: Text(
                                            rentFee.toString() + " >",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 5, left: 10),
                                    child: Text(
                                      'Maintenance Amount ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _fixedCharges((rentAmount) {
                                        rentFee = rentAmount;
                                      }, (maintenance) {
                                        maintenanceFee = maintenance;
                                      });
                                      showFixedCharges = false;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.currency_rupee,
                                              color: Colors.grey),
                                          InkWell(
                                              child: Text(
                                            maintenanceFee.toString() + " >",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                    ],
                  ),
                ), //Monthly Fixed Charge
                Container(
                  margin: EdgeInsets.only(top: 10, left: 5),
                  padding: EdgeInsets.only(left: 15),
                  height: 20,
                  width: double.infinity,
                  // color: Colors.grey,
                  child: Text(
                    'Other Fixed Charges',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 5, right: 10),
                  width: double.infinity,
                  child: Card(
                    // color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          top: 10,
                          left: 10,
                        ),
                        child: Column(
                          children: [
                            if (showElectricBill)
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 40, left: 10),
                                    child: Text(
                                      'Electricity Bill type ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _electricityBillType(
                                            (electricBillCallBack) {
                                          setState(() {
                                            electricityBillType =
                                                electricBillCallBack;
                                          });
                                        });
                                        print(electricityBillType);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(left: 60),
                                          child: InkWell(
                                              child: Text(
                                            '+Add ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.lightBlueAccent),
                                          ))))
                                ],
                              ),
                            if (!showElectricBill)
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 40, left: 10),
                                    child: Text(
                                      'Electricity\n Bill type ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _electricityBillType(
                                            (electricBillCallBack) {
                                          setState(() {
                                            electricityBillType =
                                                electricBillCallBack;
                                          });
                                        });
                                        print(electricityBillType);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(),
                                          child: InkWell(
                                              child: Text(
                                            electricityBillType,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ))))
                                ],
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            if (electricityBillType == "Submetered")
                              showSubmeterEleData(),
                            if (electricityBillType == "FixedCharges")
                              showFixedEleCharge(),
                            SizedBox(
                              height: 10,
                            ),
                            if (showWaterBill)
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 40, left: 10),
                                    child: Text(
                                      'Water Bill type ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _waterBillType((waterBIllCallBack) {
                                          waterBillType = waterBIllCallBack;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 97),
                                        child: InkWell(
                                            child: Text(
                                          '+Add ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlueAccent),
                                        )),
                                      ))
                                ],
                              ),
                            if (!showWaterBill)
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 40, left: 10),
                                    child: Text(
                                      'Water\nBill type ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _waterBillType((waterBIllCallBack) {
                                          waterBillType = waterBIllCallBack;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 12),
                                        child: InkWell(
                                            child: Text(
                                          waterBillType,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        )),
                                      ))
                                ],
                              ),
                            if (waterBillType == "Submetered")
                              showSubmeterWaterData(),
                            if (waterBillType == "FixedCharges")
                              showFixedWaterCharge(),
                            SizedBox(
                              height: 10,
                            ),
                            if (showGasBill)
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 40, left: 10),
                                    child: Text(
                                      'Gas Bill type ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _gasBillType((gasBillCallBack) {
                                          gasBillType = gasBillCallBack;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 115),
                                        child: InkWell(
                                            child: Text(
                                          '+Add ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlueAccent),
                                        )),
                                      ))
                                ],
                              ),
                            if (!showGasBill)
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 40, left: 10),
                                    child: Text(
                                      'Gas\nBill type ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _gasBillType((gasbillCallBack) {
                                          gasBillType = gasbillCallBack;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: InkWell(
                                            child: Text(
                                          gasBillType,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        )),
                                      ))
                                ],
                              ),
                            if (gasBillType == "Submetered")
                              showSubmeterGasData(),
                            if (gasBillType == "FixedCharges")
                              showFixedGasCharge(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Custom Charges"),
                ),
                selectedItems.length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink[50],
                              borderRadius: BorderRadius.circular(15)),

                          //  margin: EdgeInsets.only(top: 10, left: 5),
                          padding: EdgeInsets.only(left: 15),
                          height: 80,
                          width: double.infinity,
                          // color: Colors.grey,
                          child: ListView.builder(
                              itemCount: selectedItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        selectedItems[index].name,
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      Flexible(
                                          fit: FlexFit.tight,
                                          child: SizedBox()),
                                      Text(
                                        selectedItems[index].value,
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    : SizedBox(),
                //Cutom Charges
                Container(
                  margin: EdgeInsets.only(top: 10, left: 5),
                  padding: EdgeInsets.only(left: 15),
                  height: 20,
                  width: double.infinity,
                  // color: Colors.grey,
                  child: Text(
                    'Other Optional Charges',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      showbottomsheet(context);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 5),
                    padding: EdgeInsets.only(left: 15),
                    height: 20,
                    width: double.infinity,
                    // color: Colors.grey,
                    child: Text(
                      '+ Custom Charges',
                      style: TextStyle(
                          fontSize: 16, color: Colors.lightBlueAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                List<String> nullParameters = [];
                if (rentCycle.isEmpty) nullParameters.add("rentCycle");
                if (electricityBillType.isEmpty)
                  nullParameters.add("electricityBillType");
                if (waterBillType.isEmpty) nullParameters.add("waterBillType");
                if (gasBillType.isEmpty) nullParameters.add("gasBillType");

                String message = "All parameters are not null.\n"
                    "previousBalance: $previousBalance\n"
                    "rentFee: $rentFee\n"
                    "maintenanceFee: $maintenanceFee\n"
                    "rentCycle: $rentCycle\n"
                    "paymentDay: $paymentDay\n"
                    "paymentRequired: $paymentRequired\n"
                    "electricityBillType: $electricityBillType\n"
                    "waterBillType: $waterBillType\n"
                    "gasBillType: $gasBillType";
                print(message);
                if (nullParameters.isNotEmpty) {
                  String message =
                      "Please FillUp the  following parameters : ${nullParameters.join(", ")}";
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Null Parameters'),
                        content: Text(message),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return;
                } else {
                  actionCalculation(
                      previousBalance,
                      rentFee,
                      maintenanceFee,
                      rentCycle,
                      paymentDay,
                      paymentRequired,
                      electricityBillType,
                      FixedChargeele,
                      waterBillType,
                      FixedChargewater,
                      gasBillType,
                      FixedChargegas,
                      selectedItems);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubProptyId = prefs.getString('selectedSubProptyId') ?? '';
      userId = prefs.getString('userId') ?? '';
    });
  }

  Future<void> _electricBill() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // enableDrag: true,
          // isScrollControlled: true,
          child: Container(
            // color: Colors.deepOrange,
            height: 1000,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    "Rent Cycle important dates",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 10),
                  child: Text(
                    'When do you collect rent',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                            children: List.generate(
                              rentCycles.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCycleIndex = index;
                                    rentCycle = rentCycles[index];
                                    print('Selected TextDays: $rentCycle');
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 18),
                                    padding: const EdgeInsets.all(8),
                                    height: 35,
                                    width: 65,
                                    color: index == selectedCycleIndex
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    child: Text(
                                      rentCycles[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 10),
                  child: Text(
                    'Payment Day for the Month Rent Cycle',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                            children: List.generate(
                              dayNames.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndexDays = index;
                                    paymentDay = int.parse(dayNames[index]);
                                    print('Selected Text: $paymentDay');
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 18),
                                    padding: const EdgeInsets.all(8),
                                    height: 35,
                                    color: index == selectedIndexDays
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    child: Text(
                                      dayNames[index] + "Days",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 10),
                  child: Text(
                    'Rent Payment Required by',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          paymentDaysList.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndexRentPayment =
                                    index; // Update selectedIndex with the tapped index
                                paymentRequired =
                                    int.parse(paymentDaysList[index]);
                                print('Selected Text: $paymentRequired');
                              });
                            },
                            child: Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, left: 18),
                                padding: const EdgeInsets.all(8),
                                height: 35,
                                color: index == selectedIndexRentPayment
                                    ? Colors.blueAccent
                                    : Colors.black,
                                child: Text(
                                  "+" + paymentDaysList[index] + "Days",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: EdgeInsets.all(13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {
                      setState(() {
                        showRentCycle = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _previousBalance(Function(double) updatePreviousBalance) async {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        "Add Previous Balance",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, left: 10),
                      child: Text(
                        'Add rent dues or outstanding balance',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          balance.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndexPreviousBalance = index;
                                previousBalanceType = balance[index];
                                print("Selected Text");
                                print(previousBalance);
                                print('Selected Text: $previousBalanceType');
                              });
                            },
                            child: Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, left: 18),
                                padding: const EdgeInsets.all(8),
                                height: 35,
                                width: 90,
                                color: index == selectedIndexPreviousBalance
                                    ? Colors.blueAccent
                                    : Colors.black,
                                child: Text(
                                  balance[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        if (previousBalanceType != 'NoBalance') {
                          return Container(
                            margin: EdgeInsets.only(top: 10, left: 8),
                            child: TextFormField(
                              controller: advanceAmount,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.money),
                                hintText: 'Make Payment?',
                                labelText: 'Advance Amount *',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          );
                        } else {
                          return SizedBox(height: 10);
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (previousBalanceType == 'NoBalance') {
                            setState(() {
                              previousBalance = 0.0;
                              showPreviousBalance = false;
                            });
                          } else {
                            if (advanceAmount.text.isNotEmpty) {
                              setState(() {
                                previousBalance =
                                    double.parse(advanceAmount.text);
                                showPreviousBalance = false;
                              });
                            } else {
                              setState(() {
                                previousBalance = 0.0;
                                showPreviousBalance = false;
                              });
                            }
                          }

                          Navigator.of(context).pop();
                          updatePreviousBalance(
                              previousBalance); // Invoke the callback function
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _fixedCharges(Function(double) rentAmountCallback,
      Function(double) maintenanceCallback) async {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("How much do you charge for Blab",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 8),
                      child: TextFormField(
                        controller: rentController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.money),
                          //  hintText: 'Make Payment?',
                          labelText: 'Rent Amount *',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 8),
                      child: TextFormField(
                        controller: maintenanceController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.mediation),
                          //  hintText: 'Make Payment?',
                          labelText: 'Maintenance Amount *',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (rentController.text.isNotEmpty) {
                              rentFee = double.parse(rentController.text);
                              rentAmountCallback(rentFee);
                            }
                            if (maintenanceController.text.isNotEmpty) {
                              maintenanceFee =
                                  double.parse(maintenanceController.text);
                              maintenanceCallback(maintenanceFee);
                            }
                            showFixedCharges = false;
                          });

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ))
          ]);
        });
  }

  Future<void> _electricityBillType(
      Function(String) electricBillCallBack) async {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return ListView(shrinkWrap: true, children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 35,
                          color: Colors.grey,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("How electricity is charged from tenants",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showElectricBill = false;
                        });
                        Navigator.of(context).pop();
                        electricityBillType = "GovernmentMetered";
                        print(electricityBillType);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Government/Company Metered',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'Tenants directly pay electricity\n bill to Government/Company ',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 40, top: 20),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showElectricBill = false;
                        });
                        Navigator.of(context).pop();
                        electricityBillType = "Submetered";
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 150,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Sub-metered',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'Tenants pay you the electricity \n usage charges calculated based \n on the units consumed ',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 40, top: 20),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showElectricBill = false;
                        });
                        Navigator.of(context).pop();
                        electricityBillType = "FixedCharges";
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Fixed Charges',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'You charge a fixed amount \n for electricity',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 40),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showElectricBill = false;
                        });
                        Navigator.of(context).pop();
                        electricityBillType = "NoCharges";
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'No Charges',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'You Do Not charge \n for electricity',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 40),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ))
          ]);
        });
  }

  Future<void> _waterBillType(Function(String) waterBIllCallBack) async {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return ListView(shrinkWrap: true, children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("How Water is charged from tenants",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showWaterBill = false;
                        });
                        Navigator.of(context).pop();
                        waterBillType = 'GovernmentMetered';
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Government/Company Metered',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'Tenants directly pay Water\n bill to Government/Company ',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 40, top: 20),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showWaterBill = false;
                        });
                        Navigator.of(context).pop();
                        ;
                        waterBillType = 'Submetered';
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 150,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'submetered',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'Tenants pay you the Water \n usage charges calculated based \n on the units consumed ',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 40, top: 20),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showWaterBill = false;
                        });
                        Navigator.of(context).pop();
                        waterBillType = 'FixedCharges';
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Fixed Charges',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'You charge a fixed amount \n for Water',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 40),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showWaterBill = false;
                        });
                        Navigator.of(context).pop();
                        waterBillType = "NoCharges";
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'No Charges',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'You Do Not charge \n for electricity',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 40),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ))
          ]);
        });
  }

  Future<void> _gasBillType(Function(String) gasbillCallBack) async {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return ListView(shrinkWrap: true, children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("How Gas is charged from tenants",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showGasBill = false;
                        });
                        Navigator.of(context).pop();
                        gasBillType = "GovernmentMetered";
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Government/Company Metered',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'Tenants directly pay Gas\n bill to Government/Company ',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 40, top: 20),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showGasBill = false;
                        });
                        Navigator.of(context).pop();
                        gasBillType = "Submetered";
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 150,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Sub-metered',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'Tenants pay you the Gas \n usage charges calculated based \n on the units consumed ',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 40, top: 20),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showGasBill = false;
                        });
                        Navigator.of(context).pop();
                        gasBillType = "FixedCharges";
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Fixed Charges',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'You charge a fixed amount \n for Gas',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 40),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showGasBill = false;
                        });
                        Navigator.of(context).pop();
                        gasBillType = "NoCharges";
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        //    alignment: Alignment.center,
                        height: 100,

                        width: double.infinity,
                        child: Card(
                          // color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 10,
                          child: Column(children: <Widget>[
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'No Charges',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Row(
                              children: [
                                Container(
                                    width: 220,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      'You Do Not charge \n for electricity',
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.left,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 40),
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ))
          ]);
        });
  }

  Widget showDefultData() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 10, left: 5, right: 10),
      width: double.infinity,
      child: Card(
        // color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 90, left: 10),
                  child: Text(
                    'Rent Cycle ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    rentCycle = rentCycles[selectedCycleIndex];
                    paymentDay = int.parse(dayNames[selectedIndexDays]);
                    paymentRequired =
                        int.parse(paymentDaysList[selectedIndexRentPayment]);
                    _electricBill();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 70),
                    child: InkWell(
                        child: Text(
                      '+Add ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget showDataWiget() {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 50, left: 10),
                    child: Text(
                      'Rent Cycle ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _electricBill();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 70),
                      child: InkWell(
                          child: Text(
                        rentCycle + " >",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 90, left: 10),
                    child: Text(
                      'Payment Day ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _electricBill();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: InkWell(
                          child: Text(
                        paymentDay.toString() + "Days >",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 30, left: 10),
                    child: Text(
                      'Payment Required\n by ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _electricBill();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                          child: Text(
                        "+" + paymentRequired.toString() + "Days >",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void actionCalculation(
      double previousBalance,
      double rentFee,
      double maintenanceFee,
      String rentCycle,
      int paymentDay,
      int paymentRequired,
      String electricityBillType,
      double electricCharge,
      String waterBillType,
      double waterCharges,
      String gasBillType,
      double gasCharges,
      List<ViewBloodHospitalModel> selectedItems) {
    double finalPreviousBalance = previousBalance;
    if (previousBalanceType == 'Pending') {
      finalPreviousBalance = -previousBalance;
    }
    double totalBalance = finalPreviousBalance +
        rentFee +
        maintenanceFee +
        electricCharge +
        waterCharges +
        gasCharges;
    DateTime now = DateTime.now();
    DateTime rentEndDatas = DateTime(now.year, now.month + 1, 0);
    DateTime rentStartDates = DateTime(now.year, now.month, paymentDay);
    DateTime rentCollectBys =
        rentStartDates.add(Duration(days: paymentRequired));
    DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
    String rentEndData = dateFormat.format(rentEndDatas).toString();
    String rentStartDate = dateFormat.format(rentStartDates).toString();
    String rentCollectBy = dateFormat.format(rentCollectBys).toString();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NextRentBillCycle(
            landlordId: userId,
            propertyId: selectedPropertyId,
            subpropertyId: selectedSubProptyId,
            rentCycle: rentCycle,
            rentStartData: rentStartDate,
            collectdBy: rentCollectBy,
            rentEndDate: rentEndData,
            perviousBalance: finalPreviousBalance,
            rentAmount: rentFee,
            maintenanceAmount: maintenanceFee,
            totalAmount: totalBalance,
            electricityType: electricityBillType,
            electricCharge: electricCharge,
            waterBillType: waterBillType,
            waterBillCharge: waterCharges,
            gasBillType: gasBillType,
            gasBillCharge: gasCharges,
            selectedItems: selectedItems),
      ),
    );
  }

  Widget showSubmeterEleData() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(right: 40, left: 10),
          child: Text(
            'SubMeter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
            onTap: () {
              // _waterBillType((waterBIllCallBack) {
              //   waterBillType = waterBIllCallBack;
              // });
            },
            child: Container(
              padding: EdgeInsets.only(left: 145),
              child: InkWell(
                  child: Text(
                '+Add ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent),
              )),
            ))
      ],
    );
  }

  Widget showFixedEleCharge() {
    if (showFiexedElctricCharge) {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 40, left: 10),
            child: Text(
              'FixedCharge',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
              onTap: () {
                fixedChargeElectricBill((fixchargeEleCallback) {
                  FixedChargeele = fixchargeEleCallback;
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 120),
                child: InkWell(
                    child: Text(
                  '+Add ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                )),
              ))
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 40, left: 10),
            child: Text(
              'FixedCharge',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
              onTap: () {
                fixedChargeElectricBill((fixchargeEleCallback) {
                  FixedChargeele = fixchargeEleCallback;
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: InkWell(
                    child: Text(
                  FixedChargeele.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )),
              ))
        ],
      );
    }
  }

  Widget showSubmeterGasData() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(right: 40, left: 10),
          child: Text(
            'SubMeter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
            onTap: () {
              // _waterBillType((waterBIllCallBack) {
              //   waterBillType = waterBIllCallBack;
              // });
            },
            child: Container(
              padding: EdgeInsets.only(left: 145),
              child: InkWell(
                  child: Text(
                '+Add ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent),
              )),
            ))
      ],
    );
  }

  Widget showFixedGasCharge() {
    if (showFiexedGasCharge) {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 40, left: 10),
            child: Text(
              'FixedCharge',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
              onTap: () {
                fixedChargeGasBill((fixedChargeGasBillCallback) {
                  FixedChargegas = fixedChargeGasBillCallback;
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 120),
                child: InkWell(
                    child: Text(
                  '+Add ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                )),
              ))
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 40, left: 10),
            child: Text(
              'FixedCharge',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
              onTap: () {
                fixedChargeGasBill((fixedChargeGasBillCallback) {
                  FixedChargegas = fixedChargeGasBillCallback;
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: InkWell(
                    child: Text(
                  FixedChargegas.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )),
              ))
        ],
      );
    }
  }

  Widget showSubmeterWaterData() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(right: 40, left: 10),
          child: Text(
            'SubMeter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
            onTap: () {
              // _waterBillType((waterBIllCallBack) {
              //   waterBillType = waterBIllCallBack;
              // });
            },
            child: Container(
              padding: EdgeInsets.only(left: 145),
              child: InkWell(
                  child: Text(
                '+Add ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent),
              )),
            ))
      ],
    );
  }

  Widget showFixedWaterCharge() {
    if (showFiexedWaterCharge) {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 40, left: 10),
            child: Text(
              'FixedCharge',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
              onTap: () {
                fixedChargeWaterBill((fixedChargeWaterBillCallback) {
                  FixedChargeele = fixedChargeWaterBillCallback;
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 120),
                child: InkWell(
                    child: Text(
                  '+Add ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                )),
              ))
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 40, left: 10),
            child: Text(
              'FixedCharge',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
              onTap: () {
                fixedChargeWaterBill((fixedChargeWaterBillCallback) {
                  FixedChargewater = fixedChargeWaterBillCallback;
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: InkWell(
                    child: Text(
                  FixedChargewater.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )),
              ))
        ],
      );
    }
  }

  fixedChargeGasBill(Function(double) fixedChargeGasBillCallback) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("How much do you charge",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 8),
                      child: TextFormField(
                        controller: fiexedCharegasController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.money),
                          //  hintText: 'Make Payment?',
                          labelText: 'Bill Amount *',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (fiexedCharegasController.text.isNotEmpty) {
                              FixedChargegas =
                                  double.parse(fiexedCharegasController.text);
                              fixedChargeGasBillCallback(FixedChargegas);
                            }
                            showFiexedGasCharge = false;
                          });

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ))
          ]);
        });
  }

  fixedChargeWaterBill(Function(double) fixedChargeWaterBillCallback) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("How much do you charge",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 8),
                      child: TextFormField(
                        controller: fiexedCharewaterController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.money),
                          //  hintText: 'Make Payment?',
                          labelText: 'Bill Amount *',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (fiexedCharewaterController.text.isNotEmpty) {
                              FixedChargewater =
                                  double.parse(fiexedCharewaterController.text);
                              fixedChargeWaterBillCallback(FixedChargewater);
                            }
                            showFiexedWaterCharge = false;
                          });

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ))
          ]);
        });
  }

  fixedChargeElectricBill(Function(double) fixchargeEleCallback) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("How much do you charge",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 8),
                      child: TextFormField(
                        controller: fiexedChareeleController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.money),
                          //  hintText: 'Make Payment?',
                          labelText: 'Bill Amount *',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (fiexedChareeleController.text.isNotEmpty) {
                              FixedChargeele =
                                  double.parse(fiexedChareeleController.text);
                              fixchargeEleCallback(FixedChargeele);
                            }
                            showFiexedElctricCharge = false;
                          });

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ))
          ]);
        });
  }

  FixedEleChargeChose(Function(double) FixedEleChargeChoseCallback) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text("How much do you charge for Blab",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 8),
                      child: TextFormField(
                        controller: rentController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.money),
                          //  hintText: 'Make Payment?',
                          labelText: 'Rent Amount *',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (rentController.text.isNotEmpty) {
                              rentFee = double.parse(rentController.text);
                              FixedEleChargeChoseCallback(rentFee);
                            }
                            if (maintenanceController.text.isNotEmpty) {
                              maintenanceFee =
                                  double.parse(maintenanceController.text);
                              FixedEleChargeChoseCallback(maintenanceFee);
                            }
                            showFixedCharges = false;
                          });

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ))
          ]);
        });
  }

  int listlenth = 1;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController valuecontroller = new TextEditingController();
  showbottomsheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setstate) {
            return SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(
                start: 20,
                end: 10,
                bottom: 30,
                top: 8,
              ),
              child: Wrap(
                // direction: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Text Content"),
                      ],
                    ),
                  ),
                  ...List.generate(
                    listlenth,
                    (index) {
                      return Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                                // bottom: MediaQuery.of(context)
                                //     .viewInsets
                                //     .bottom,
                              ),
                              child: Container(
                                // height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                //   color: Colors.amber,
                                child: TextFormField(
                                  cursorColor: Color.fromARGB(255, 3, 61, 109),
                                  controller: namecontroller,
                                  decoration: InputDecoration(
                                      hintText: 'Ex: Water Bill',
                                      label: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Change Name",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 3, 61, 109)),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                                // bottom: MediaQuery.of(context)
                                //     .viewInsets
                                //     .bottom,
                              ),
                              child: Container(
                                // height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                //   color: Colors.amber,
                                child: TextFormField(
                                  cursorColor: Color.fromARGB(255, 3, 61, 109),
                                  controller: valuecontroller,
                                  decoration: InputDecoration(
                                      hintText: 'Ex: Water Bill',
                                      label: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Change Value",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 3, 61, 109)),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),

                          // RawMaterialButton(
                          //   constraints:
                          //       BoxConstraints.tightFor(width: 30, height: 30),
                          //   elevation: 0,
                          //   onPressed: () {
                          //     setstate(() {
                          //       listlenth++;
                          //     });
                          //   },
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(100)),
                          //   fillColor: Colors.grey.shade300,
                          //   child: Icon(
                          //     Icons.add,
                          //     color: Colors.black,
                          //     size: 15,
                          //   ),
                          // ),
                          // RawMaterialButton(
                          //   constraints:
                          //       BoxConstraints.tightFor(width: 30, height: 30),
                          //   elevation: 0,
                          //   onPressed: () {
                          //     setstate(() {
                          //       selectedItems.add(ViewBloodHospitalModel(
                          //           id: listlenth.toString(),
                          //           name: namecontroller.text,
                          //           value: valuecontroller.text));
                          //     });
                          //     Navigator.pop(context);
                          //   },
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(100)),
                          //   fillColor: Colors.grey.shade300,
                          //   child: Icon(
                          //     Icons.check,
                          //     color: Colors.black,
                          //     size: 15,
                          //   ),
                          // )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Center(
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: MaterialButton(
                          color: Colors.purple,
                          onPressed: () {
                            setstate(() {
                              selectedItems.add(ViewBloodHospitalModel(
                                  id: listlenth.toString(),
                                  name: namecontroller.text,
                                  value: valuecontroller.text));
                            });

                            setstate(() {});

                            Navigator.pop(context);
                            setState(() {});
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }
}

// class CustomWidget extends StatelessWidget {
//   const CustomWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
class ViewBloodHospitalModel {
  ViewBloodHospitalModel({
    required this.id,
    required this.name,
    required this.value,
  });

  String id;
  String name;
  String value;

  factory ViewBloodHospitalModel.fromJson(Map<String, dynamic> json) =>
      ViewBloodHospitalModel(
        id: json["id"],
        name: json["name"],
        value: "value",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
      };
}
