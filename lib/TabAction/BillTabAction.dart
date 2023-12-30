import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renttas_flutter_app/landlord/LanlordProfile.dart';
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
  final List<String> weeks = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
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
  String selectedSubPropertyId = '';
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
        backgroundColor: const Color(0xff54854C),
        leading: const BackButton(),
        title: const Text('RENTTAS ', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 0.0, height: 10),
              Center(
                child: Container(
                  height: 20,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'When Do You Collect Rent',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 0.0, height: 24),

              if (showRentCycle) showDefultData(),

              if (!showRentCycle) showDataWiget(),

              const SizedBox(width: 0.0, height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Monthly Fixed Charges',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: <Widget>[
                      if (showPreviousBalance)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Previous Balance',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                                overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
                              ),
                              onPressed: () {
                                _previousBalance((updatedBalance) {
                                  setState(() {
                                    previousBalance = updatedBalance;
                                    showPreviousBalance = false;
                                  });
                                });
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 4),
                                  Text(
                                    'ADD',
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     _previousBalance((updatedBalance) {
                            //       setState(() {
                            //         previousBalance = updatedBalance;
                            //         showPreviousBalance = false;
                            //       });
                            //     });
                            //   },
                            //   child: Container(
                            //     padding: const EdgeInsets.only(left: 50),
                            //     child: Align(
                            //       alignment: Alignment.centerRight,
                            //       child: Container(
                            //         child: const Row(
                            //           children: [
                            //             Icon(Icons.add, color:  Color(0xff54854C)),
                            //             Text(
                            //               "Add",
                            //               style: TextStyle(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.w500,
                            //                 color: Colors.lightBlueAccent,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      if (!showPreviousBalance)
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Previous Balance',
                                style: TextStyle(fontSize: 16),
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
                                child: InkWell(
                                  child: SizedBox(
                                    width: 80,
                                    child: Text(
                                      "$previousBalance >",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
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
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Fixed Charges',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                                      overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
                                    ),
                                    onPressed: () {
                                      _fixedCharges((rentAmount) {
                                        rentFee = rentAmount;
                                      }, (maintenance) {
                                        maintenanceFee = maintenance;
                                      });
                                      showFixedCharges = false;
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add),
                                        SizedBox(width: 4),
                                        Text(
                                          'ADD',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     _fixedCharges((rentAmount) {
                                  //       rentFee = rentAmount;
                                  //     }, (maintenance) {
                                  //       maintenanceFee = maintenance;
                                  //     });
                                  //     showFixedCharges = false;
                                  //   },
                                  //   child: Container(
                                  //     padding: const EdgeInsets.only(left: 70),
                                  //     child: const InkWell(
                                  //         child: Text(
                                  //       '+Add ',
                                  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
                                  //     )),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      if (!showFixedCharges)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Rent Amount ',
                                    style: TextStyle(
                                      fontSize: 16,
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
                                    child: Row(
                                      children: [
                                        // const Icon(Icons.currency_rupee, color: Colors.grey),
                                        InkWell(
                                          child: SizedBox(
                                            width: 80,
                                            child: Text(
                                              "$rentFee >",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 14, bottom: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Maintenance Amount ',
                                    style: TextStyle(fontSize: 16),
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
                                    child: Row(
                                      children: [
                                        InkWell(
                                            child: SizedBox(
                                          width: 80,
                                          child: Text(
                                            "$maintenanceFee >",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ), //Monthly Fixed Charge
              const SizedBox(width: 0.0, height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: const Text(
                  'Other Fixed Charges',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            if (showElectricBill)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: const Text(
                                      'Electricity Bill type ',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                                      overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
                                    ),
                                    onPressed: () => _electricityBillType((electricBillCallBack) {
                                      setState(() => electricityBillType = electricBillCallBack);
                                    }),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add),
                                        SizedBox(width: 4),
                                        Text(
                                          'ADD',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     _electricityBillType((electricBillCallBack) {
                                  //       setState(() {
                                  //         electricityBillType = electricBillCallBack;
                                  //       });
                                  //     });
                                  //     print(electricityBillType);
                                  //   },
                                  //   child: Container(
                                  //     padding: const EdgeInsets.only(left: 60),
                                  //     child: const InkWell(
                                  //         child: Text(
                                  //       '+Add ',
                                  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
                                  //     )),
                                  //   ),
                                  // )
                                ],
                              ),
                            if (!showElectricBill)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: const Text(
                                      'Electricity Bill type ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _electricityBillType((electricBillCallBack) {
                                        setState(() {
                                          electricityBillType = electricBillCallBack;
                                        });
                                      });
                                      print(electricityBillType);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(),
                                      child: InkWell(
                                        child: Container(
                                          width: 100,
                                          child: Text(
                                            electricityBillType,
                                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            if (electricityBillType == "Submetered") showSubmeterEleData(),
                            if (electricityBillType == "FixedCharges") showFixedEleCharge(),
                            const SizedBox(height: 10),
                            if (showWaterBill)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Water Bill type ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                                      overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
                                    ),
                                    onPressed: () => _waterBillType((waterBIllCallBack) {
                                      waterBillType = waterBIllCallBack;
                                    }),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add),
                                        SizedBox(width: 4),
                                        Text(
                                          'ADD',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       _waterBillType((waterBIllCallBack) {
                                  //         waterBillType = waterBIllCallBack;
                                  //       });
                                  //     },
                                  //     child: Container(
                                  //       padding: const EdgeInsets.only(left: 97),
                                  //       child: const InkWell(
                                  //           child: Text(
                                  //         '+Add ',
                                  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
                                  //       )),
                                  //     ))
                                ],
                              ),
                            if (!showWaterBill)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Water Bill type ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _waterBillType((waterBIllCallBack) {
                                        waterBillType = waterBIllCallBack;
                                      });
                                    },
                                    child: InkWell(
                                      child: Container(
                                        width: 100,
                                        child: Text(
                                          waterBillType,
                                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            if (waterBillType == "Submetered") showSubmeterWaterData(),
                            if (waterBillType == "FixedCharges") showFixedWaterCharge(),
                            const SizedBox(height: 10),
                            if (showGasBill)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Gas Bill type ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  OutlinedButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                                      overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
                                    ),
                                    onPressed: () => _gasBillType(
                                      (gasBillCallBack) {
                                        gasBillType = gasBillCallBack;
                                      },
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add),
                                        SizedBox(width: 4),
                                        Text(
                                          'ADD',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            if (!showGasBill)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Gas Bill type ',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _gasBillType(
                                        (gasbillCallBack) {
                                          gasBillType = gasbillCallBack;
                                        },
                                      );
                                    },
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          gasBillType,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            if (gasBillType == "Submetered") showSubmeterGasData(),
                            if (gasBillType == "FixedCharges") showFixedGasCharge(),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 0.0, height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Text(
                  "Custom Charges",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              selectedItems.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: SingleChildScrollView(
                        child: Flexible(
                          fit: FlexFit.tight,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: selectedItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff54854C).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedItems[index].name.capitalizeFirstWord(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        selectedItems[index].value.capitalizeFirstWord(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : const SizedBox(),
              //Cutom Charges
              Container(
                // height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: double.infinity,
                // color: Colors.grey,
                child: const Text(
                  'Other Optional Charges',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              Container(
                width: 200,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                    overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
                  ),
                  onPressed: () {
                    setState(() {
                      showbottomsheet(context);
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 4),
                      Text(
                        'Custom Charges',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(bottom: 40, top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    List<String> nullParameters = [];
                    if (rentCycle.isEmpty) nullParameters.add("rentCycle");
                    if (electricityBillType.isEmpty) nullParameters.add("electricityBillType");
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
                      String message = "Please FillUp the  following parameters : ${nullParameters.join(", ")}";
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Null Parameters'),
                            content: Text(message),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
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
                      actionCalculation(previousBalance, rentFee, maintenanceFee, rentCycle, paymentDay, paymentRequired, electricityBillType, FixedChargeele, waterBillType, FixedChargewater,
                          gasBillType, FixedChargegas, selectedItems);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff54854C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPropertyId = prefs.getString('selectedPropertyId') ?? '';
      selectedSubPropertyId = prefs.getString('selectedSubPropertyId') ?? '';
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
                const Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "Rent Cycle important dates",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 18),
                  child: const Text(
                    'When do you collect rent',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      // fontWeight: FontWeight.w600,
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
                                    margin: const EdgeInsets.only(top: 20, left: 18),
                                    padding: const EdgeInsets.all(8),
                                    height: 35,
                                    width: 65,
                                    color: index == selectedCycleIndex ? const Color(0xff54854C) : Colors.black,
                                    child: Text(
                                      rentCycles[index],
                                      style: const TextStyle(color: Colors.white),
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
                  margin: const EdgeInsets.only(top: 30, left: 18),
                  child: const Text(
                    'Payment Day for the Month Rent Cycle',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
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
                                    margin: const EdgeInsets.only(top: 20, left: 18),
                                    padding: const EdgeInsets.all(8),
                                    height: 35,
                                    color: index == selectedIndexDays ? const Color(0xff54854C) : Colors.black,
                                    child: Text(
                                      "${dayNames[index]}Days",
                                      style: const TextStyle(color: Colors.white),
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
                  margin: const EdgeInsets.only(top: 30, left: 18),
                  child: const Text(
                    'Rent Payment Required by',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
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
                                selectedIndexRentPayment = index; // Update selectedIndex with the tapped index
                                paymentRequired = int.parse(paymentDaysList[index]);
                                print('Selected Text: $paymentRequired');
                              });
                            },
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 20, left: 18),
                                padding: const EdgeInsets.all(8),
                                height: 35,
                                color: index == selectedIndexRentPayment ? const Color(0xff54854C) : Colors.black,
                                child: Text(
                                  "+${paymentDaysList[index]}Days",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
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
                  margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: const Color(0xff54854C), padding: const EdgeInsets.all(13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {
                      setState(() {
                        showRentCycle = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 18),
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
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        "Add Previous Balance",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15, left: 18),
                      child: const Text(
                        'Add rent dues or outstanding balance',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
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
                                margin: const EdgeInsets.only(top: 20, left: 18),
                                padding: const EdgeInsets.all(8),
                                height: 35,
                                width: 90,
                                color: index == selectedIndexPreviousBalance ? const Color(0xff54854C) : Colors.black,
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
                            margin: const EdgeInsets.only(top: 10, left: 8),
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
                          return const SizedBox(height: 10);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      margin: const EdgeInsets.all(10.0),
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
                                previousBalance = double.parse(advanceAmount.text);
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
                          updatePreviousBalance(previousBalance); // Invoke the callback function
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff54854C),
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

  Future<void> _fixedCharges(Function(double) rentAmountCallback, Function(double) maintenanceCallback) async {
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("How much do you charge for Blab",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 8),
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
                      margin: const EdgeInsets.only(top: 10, left: 8),
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
                      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: const EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (rentController.text.isNotEmpty) {
                              rentFee = double.parse(rentController.text);
                              rentAmountCallback(rentFee);
                            }
                            if (maintenanceController.text.isNotEmpty) {
                              maintenanceFee = double.parse(maintenanceController.text);
                              maintenanceCallback(maintenanceFee);
                            }
                            showFixedCharges = false;
                          });

                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff54854C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
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

  Future<void> _electricityBillType(Function(String) electricBillCallBack) async {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 35,
                        color: Colors.grey,
                      )),
                  const Padding(
                    padding: EdgeInsets.all(18),
                    child: Text("How electricity is charged from tenants",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
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
                      margin: const EdgeInsets.only(right: 10, left: 10),
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
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              child: const Text(
                                'Government/Company Metered',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Row(
                            children: [
                              Container(
                                  width: 220,
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'Tenants directly pay electricity\n bill to Government/Company ',
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  )),
                              Container(
                                margin: const EdgeInsets.only(left: 40, top: 20),
                                child: const Icon(
                                  Icons.arrow_right_alt,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                      margin: const EdgeInsets.only(right: 10, left: 10),
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
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              child: const Text(
                                'Sub-metered',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Row(
                            children: [
                              Container(
                                  width: 220,
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'Tenants pay you the electricity \n usage charges calculated based \n on the units consumed ',
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  )),
                              Container(
                                margin: const EdgeInsets.only(left: 40, top: 20),
                                child: const Icon(
                                  Icons.arrow_right_alt,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                      margin: const EdgeInsets.only(right: 10, left: 10),
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
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              child: const Text(
                                'Fixed Charges',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Row(
                            children: [
                              Container(
                                  width: 220,
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'You charge a fixed amount \n for electricity',
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 20, left: 40),
                                child: const Icon(
                                  Icons.arrow_right_alt,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showElectricBill = false;
                      });
                      Navigator.of(context).pop();
                      electricityBillType = "No Charges";
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
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
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              child: const Text(
                                'No Charges',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Row(
                            children: [
                              Container(
                                  width: 220,
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'You Do Not charge \n for electricity',
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 20, left: 40),
                                child: const Icon(
                                  Icons.arrow_right_alt,
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 0.0, height: 40),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _waterBillType(Function(String) waterBIllCallBack) async {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(18),
                        child: Text(
                          "How Water is charged from tenants",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () => showWaterBill = false,
                          );
                          Navigator.of(context).pop();
                          waterBillType = 'GovernmentMetered';
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          height: 100,
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 10,
                            child: Column(children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'Government/Company Metered',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: [
                                  Container(
                                      width: 220,
                                      margin: const EdgeInsets.only(top: 10, left: 10),
                                      child: const Text(
                                        'Tenants directly pay Water\n bill to Government/Company ',
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(left: 40, top: 20),
                                    child: const Icon(
                                      Icons.arrow_right_alt,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                          margin: const EdgeInsets.only(right: 10, left: 10),
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
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'submetered',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: [
                                  Container(
                                      width: 220,
                                      margin: const EdgeInsets.only(top: 10, left: 10),
                                      child: const Text(
                                        'Tenants pay you the Water \n usage charges calculated based \n on the units consumed ',
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(left: 40, top: 20),
                                    child: const Icon(
                                      Icons.arrow_right_alt,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                          margin: const EdgeInsets.only(right: 10, left: 10),
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
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'Fixed Charges',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: [
                                  Container(
                                      width: 220,
                                      margin: const EdgeInsets.only(top: 10, left: 10),
                                      child: const Text(
                                        'You charge a fixed amount \n for Water',
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20, left: 40),
                                    child: const Icon(
                                      Icons.arrow_right_alt,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showWaterBill = false;
                          });
                          Navigator.of(context).pop();
                          waterBillType = "No Charges";
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10, left: 10),
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
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'No Charges',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: [
                                  Container(
                                      width: 220,
                                      margin: const EdgeInsets.only(top: 10, left: 10),
                                      child: const Text(
                                        'You Do Not charge \n for electricity',
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20, left: 40),
                                    child: const Icon(
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
                  )),
              const SizedBox(width: 0.0, height: 20),
            ],
          );
        });
  }

  Future<void> _gasBillType(Function(String) gasbillCallBack) async {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(18),
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
                          margin: const EdgeInsets.only(right: 10, left: 10),
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
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'Government/Company Metered',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: [
                                  Container(
                                      width: 220,
                                      margin: const EdgeInsets.only(top: 10, left: 10),
                                      child: const Text(
                                        'Tenants directly pay Gas\n bill to Government/Company ',
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(left: 40, top: 20),
                                    child: const Icon(
                                      Icons.arrow_right_alt,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                          margin: const EdgeInsets.only(right: 10, left: 10),
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
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'Sub-metered',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: [
                                  Container(
                                      width: 220,
                                      margin: const EdgeInsets.only(top: 10, left: 10),
                                      child: const Text(
                                        'Tenants pay you the Gas \n usage charges calculated based \n on the units consumed ',
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(left: 40, top: 20),
                                    child: const Icon(
                                      Icons.arrow_right_alt,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                          margin: const EdgeInsets.only(right: 10, left: 10),
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
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'Fixed Charges',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: [
                                  Container(
                                      width: 220,
                                      margin: const EdgeInsets.only(top: 10, left: 10),
                                      child: const Text(
                                        'You charge a fixed amount \n for Gas',
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20, left: 40),
                                    child: const Icon(
                                      Icons.arrow_right_alt,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showGasBill = false;
                          });
                          Navigator.of(context).pop();
                          gasBillType = "No Charges";
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10, left: 10),
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
                                  margin: const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    'No Charges',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: [
                                  Container(
                                      width: 220,
                                      margin: const EdgeInsets.only(top: 10, left: 10),
                                      child: const Text(
                                        'You Do Not charge \n for electricity',
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20, left: 40),
                                    child: const Icon(
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
                  )),
              const SizedBox(width: 0.0, height: 20),
            ],
          );
        });
  }

  Widget showDefultData() {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rent Cycle ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                    overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
                  ),
                  onPressed: () {
                    rentCycle = rentCycles[selectedCycleIndex];
                    paymentDay = int.parse(dayNames[selectedIndexDays]);
                    paymentRequired = int.parse(paymentDaysList[selectedIndexRentPayment]);
                    _electricBill();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 4),
                      Text(
                        'ADD',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showDataWiget() {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rent Cycle',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () => _electricBill(),
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        "$rentCycle >",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Day ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () => _electricBill(),
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        "$paymentDay Days >",
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Required by ',
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () => _electricBill(),
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        "+$paymentRequired Days >",
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void actionCalculation(double previousBalance, double rentFee, double maintenanceFee, String rentCycle, int paymentDay, int paymentRequired, String electricityBillType, double electricCharge,
      String waterBillType, double waterCharges, String gasBillType, double gasCharges, List<ViewBloodHospitalModel> selectedItems) {
    double finalPreviousBalance = previousBalance;
    if (previousBalanceType == 'Pending') {
      finalPreviousBalance = -previousBalance;
    }
    double totalBalance = finalPreviousBalance + rentFee + maintenanceFee + electricCharge + waterCharges + gasCharges;
    DateTime now = DateTime.now();
    DateTime rentEndDatas = DateTime(now.year, now.month + 1, 0);
    DateTime rentStartDates = DateTime(now.year, now.month, paymentDay);
    DateTime rentCollectBys = rentStartDates.add(Duration(days: paymentRequired));
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
            subpropertyId: selectedSubPropertyId,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '* Sub Meter',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
              overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
            ),
            onPressed: () {
              // fixedChargeElectricBill((fixchargeEleCallback) {
              //   FixedChargeele = fixchargeEleCallback;
              // });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 4),
                Text(
                  'ADD',
                  style: TextStyle(),
                ),
              ],
            ),
          )
        ],
      ),
    );
    // Row(
    //   children: [
    //     Container(
    //       padding: const EdgeInsets.only(right: 40, left: 10),
    //       child: const Text(
    //         'SubMeter',
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //     GestureDetector(
    //       onTap: () {
    //         // _waterBillType((waterBIllCallBack) {
    //         //   waterBillType = waterBIllCallBack;
    //         // });
    //       },
    //       child: Container(
    //         padding: const EdgeInsets.only(left: 145),
    //         child: const InkWell(
    //             child: Text(
    //           '+Add ',
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
    //         )),
    //       ),
    //     )
    //   ],
    // );
  }

  Widget showFixedEleCharge() {
    if (showFiexedElctricCharge) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '* Fixed Charge',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            OutlinedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
              ),
              onPressed: () {
                fixedChargeElectricBill((fixchargeEleCallback) {
                  FixedChargeele = fixchargeEleCallback;
                });
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 4),
                  Text(
                    'ADD',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     fixedChargeElectricBill((fixchargeEleCallback) {
            //       FixedChargeele = fixchargeEleCallback;
            //     });
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.only(left: 120),
            //     child: const InkWell(
            //       child: Text(
            //         '+Add ',
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Fixed Charge',
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                fixedChargeElectricBill((fixchargeEleCallback) {
                  FixedChargeele = fixchargeEleCallback;
                });
              },
              child: InkWell(
                child: Container(
                  width: 90,
                  child: Text(
                    FixedChargeele.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget showSubmeterGasData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '* Sub Meter',
            style: TextStyle(fontSize: 16),
          ),
          OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
              overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 4),
                Text(
                  'ADD',
                  style: TextStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Row(
    //   children: [
    //     Container(
    //       padding: const EdgeInsets.only(right: 40, left: 10),
    //       child: const Text(
    //         'SubMeter',
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //     GestureDetector(
    //       onTap: () {
    //         // _waterBillType((waterBIllCallBack) {
    //         //   waterBillType = waterBIllCallBack;
    //         // });
    //       },
    //       child: Container(
    //         padding: const EdgeInsets.only(left: 145),
    //         child: const InkWell(
    //             child: Text(
    //           '+Add ',
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
    //         )),
    //       ),
    //     )
    //   ],
    // );
  }

  Widget showFixedGasCharge() {
    if (showFiexedGasCharge) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '* Fixed Charge',
              style: TextStyle(fontSize: 16),
            ),
            OutlinedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
              ),
              onPressed: () {
                fixedChargeGasBill((fixedChargeGasBillCallback) {
                  FixedChargegas = fixedChargeGasBillCallback;
                });
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 4),
                  Text(
                    'ADD',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      // return Row(
      //   children: [
      //     Container(
      //       padding: const EdgeInsets.only(right: 40, left: 10),
      //       child: const Text(
      //         'FixedCharge',
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         fixedChargeGasBill((fixedChargeGasBillCallback) {
      //           FixedChargegas = fixedChargeGasBillCallback;
      //         });
      //       },
      //       child: Container(
      //         padding: const EdgeInsets.only(left: 120),
      //         child: const InkWell(
      //           child: Text(
      //             '+Add ',
      //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Fixed Charge',
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                fixedChargeGasBill((fixedChargeGasBillCallback) {
                  FixedChargegas = fixedChargeGasBillCallback;
                });
              },
              child: InkWell(
                child: SizedBox(
                  width: 90,
                  child: Text(
                    FixedChargegas.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget showSubmeterWaterData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '* Sub Meter',
            style: TextStyle(fontSize: 16),
          ),
          OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
              overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 4),
                Text(
                  'ADD',
                  style: TextStyle(),
                ),
              ],
            ),
          )
        ],
      ),
    );
    // return Row(
    //   children: [
    //     Container(
    //       padding: const EdgeInsets.only(right: 40, left: 10),
    //       child: const Text(
    //         'SubMeter',
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //     GestureDetector(
    //         onTap: () {
    //           // _waterBillType((waterBIllCallBack) {
    //           //   waterBillType = waterBIllCallBack;
    //           // });
    //         },
    //         child: Container(
    //           padding: const EdgeInsets.only(left: 145),
    //           child: const InkWell(
    //               child: Text(
    //             '+Add ',
    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
    //           )),
    //         ))
    //   ],
    // );
  }

  Widget showFixedWaterCharge() {
    if (showFiexedWaterCharge) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '* Fixed Charge',
              style: TextStyle(fontSize: 16),
            ),
            OutlinedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(const Color(0xff54854C)),
                overlayColor: MaterialStateProperty.all(const Color(0xff54854C).withOpacity(0.1)),
              ),
              onPressed: () {
                fixedChargeWaterBill((fixedChargeWaterBillCallback) {
                  FixedChargeele = fixedChargeWaterBillCallback;
                });
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 4),
                  Text(
                    'ADD',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     fixedChargeWaterBill((fixedChargeWaterBillCallback) {
            //       FixedChargeele = fixedChargeWaterBillCallback;
            //     });
            //   },
            //   child: const SizedBox(
            //     width: 90,
            //     child: Text(
            //       '+Add ',
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
            //     ),
            //   ),
            // )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Fixed Charge',
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              onTap: () {
                fixedChargeWaterBill((fixedChargeWaterBillCallback) {
                  FixedChargewater = fixedChargeWaterBillCallback;
                });
              },
              child: InkWell(
                child: Container(
                  width: 90,
                  child: Text(
                    FixedChargewater.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),
            )
          ],
        ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("How much do you charge",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 8),
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
                      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: const EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (fiexedCharegasController.text.isNotEmpty) {
                              FixedChargegas = double.parse(fiexedCharegasController.text);
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
                        child: const Text(
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("How much do you charge",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 8),
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
                      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: const EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (fiexedCharewaterController.text.isNotEmpty) {
                              FixedChargewater = double.parse(fiexedCharewaterController.text);
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
                        child: const Text(
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("How much do you charge",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 8),
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
                      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: const EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (fiexedChareeleController.text.isNotEmpty) {
                              FixedChargeele = double.parse(fiexedChareeleController.text);
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
                        child: const Text(
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("How much do you charge for Blab",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 8),
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
                      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      height: 80,
                      padding: const EdgeInsets.all(13),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (rentController.text.isNotEmpty) {
                              rentFee = double.parse(rentController.text);
                              FixedEleChargeChoseCallback(rentFee);
                            }
                            if (maintenanceController.text.isNotEmpty) {
                              maintenanceFee = double.parse(maintenanceController.text);
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
                        child: const Text(
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
              padding: const EdgeInsetsDirectional.only(
                start: 20,
                end: 10,
                bottom: 30,
                top: 8,
              ),
              child: Wrap(
                // direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Text Content"),
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
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                                // bottom: MediaQuery.of(context)
                                //     .viewInsets
                                //     .bottom,
                              ),
                              child: SizedBox(
                                // height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                //   color: Colors.amber,
                                child: TextFormField(
                                  cursorColor: const Color.fromARGB(255, 3, 61, 109),
                                  controller: namecontroller,
                                  decoration: const InputDecoration(
                                      hintText: 'Ex: Water Bill',
                                      label: Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Change Name",
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 61, 109)),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                                // bottom: MediaQuery.of(context)
                                //     .viewInsets
                                //     .bottom,
                              ),
                              child: SizedBox(
                                // height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                //   color: Colors.amber,
                                child: TextFormField(
                                  cursorColor: const Color.fromARGB(255, 3, 61, 109),
                                  controller: valuecontroller,
                                  decoration: const InputDecoration(
                                      hintText: 'Ex: Water Bill',
                                      label: Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Change Value",
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 61, 109)),
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
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                    child: Center(
                      child: SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: MaterialButton(
                          color: Colors.purple,
                          onPressed: () {
                            setstate(() {
                              selectedItems.add(ViewBloodHospitalModel(id: listlenth.toString(), name: namecontroller.text, value: valuecontroller.text));
                            });

                            setstate(() {});

                            Navigator.pop(context);
                            setState(() {});
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

  factory ViewBloodHospitalModel.fromJson(Map<String, dynamic> json) => ViewBloodHospitalModel(
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
