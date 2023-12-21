// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import 'Dashboard.dart';

class collabratesview extends StatefulWidget {
  const collabratesview({super.key});

  @override
  State<collabratesview> createState() => _collabratesviewState();
}

class _collabratesviewState extends State<collabratesview> {
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    //BestTutorSite _site = BestTutorSite.javatpoint;
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //  color: grey[300],
        //   ),
        // ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const inentorydashboard())),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Collaburaters"),
                      // Text(
                      //   "ab@gmail.com",
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // )
                    ],
                  ),
                ),
                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                InkWell(
                  onTap: () => showbottomsheet(context),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.filter_alt,
                      size: 24,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.recycling,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage("https://i.pinimg.com/originals/5c/87/b3/5c87b3c0466f830a480ba2214af2c73d.png"))),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ab@123 ',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Ab@gmail.com',
                            style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    const Column(
                      children: [
                        Text(
                          'Owner',
                          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Active',
                          style: TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              value: valuefirst,
                              onChanged: (bool? value) {
                                setState(() {
                                  valuefirst = value!;
                                });
                              },
                            ),
                            const Text(
                              'Product',
                              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              value: valuesecond,
                              onChanged: (bool? value) {
                                setState(() {
                                  valuesecond = value!;
                                });
                              },
                            ),
                            const Text(
                              'Store',
                              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              activeColor: Colors.black,
                              value: valuefirst,
                              onChanged: (bool? value) {
                                setState(() {
                                  valuefirst = value!;
                                });
                              },
                            ),
                            const Text(
                              'Report',
                              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              activeColor: Colors.black,
                              value: valuefirst,
                              onChanged: (bool? value) {
                                setState(() {
                                  valuefirst = value!;
                                });
                              },
                            ),
                            const Text(
                              'Qutation',
                              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  activeColor: Colors.black,
                                  value: valuefirst,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      valuefirst = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Transaction',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  activeColor: Colors.black,
                                  value: valuefirst,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      valuefirst = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'PRate',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  activeColor: Colors.black,
                                  value: valuefirst,
                                  onChanged: (bool? value) => setState(() => valuefirst = value!),
                                ),
                                const Text(
                                  'Setting',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  activeColor: Colors.black,
                                  value: valuefirst,
                                  onChanged: (bool? value) => setState(() => valuefirst = value!),
                                ),
                                const Text(
                                  'Collaburate',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  activeColor: Colors.black,
                                  value: valuefirst,
                                  onChanged: (bool? value) => setState(() => valuefirst = value!),
                                ),
                                const Text(
                                  'SRate',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.black,
                                  activeColor: Colors.black,
                                  value: valuefirst,
                                  onChanged: (bool? value) => setState(() => valuefirst = value!),
                                ),
                                const Text(
                                  'Both',
                                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        onPressed: () {
          showbottomsheetinvitecollab(context);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const qutationview()));
        },
      ),
    );
  }

  int _groupValue1 = -1;
  showbottomsheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setstate) {
            return SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 10, bottom: 30, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Flexible(
                        child: Text(
                          "Filter",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 50),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.close_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RadioListTile(
                    value: 0,
                    groupValue: _groupValue1,
                    title: const Text("All Collaburaters"),
                    onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                    activeColor: Colors.blue,
                    selected: false,
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: _groupValue1,
                    title: const Text("Active Collaburaters"),
                    onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                    activeColor: Colors.blue,
                    selected: false,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: _groupValue1,
                    title: const Text("InActive Collaburaters"),
                    onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                    activeColor: Colors.blue,
                    selected: false,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  showbottomsheetinvitecollab(context) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, setstate) {
            return SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(start: 20, end: 10, bottom: 30, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Flexible(
                        child: Text(
                          "Invite collaburaters",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      const SizedBox(width: 50),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.close_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Scan QR code to join current buisness",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(child: Icon(Icons.qr_code_scanner_outlined, size: 200)),
                  const Center(
                    child: Text(
                      "OR",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      "Share this code with your partner or \n business personso they can accessthis \n business",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "8JUTGYESX",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  const SizedBox(height: 15),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      height: 50,
                      width: 250,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.book_sharp,
                              size: 24,
                              color: Colors.white,
                            ),
                            TextButton(
                              child: const Text(
                                'COPY CODE',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange,
                      ),
                      height: 50,
                      width: 250,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.attach_email_sharp,
                              size: 24,
                              color: Colors.white,
                            ),
                            Center(
                              child: TextButton(
                                child: const Text(
                                  'SEND INVITATION',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.orange),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
