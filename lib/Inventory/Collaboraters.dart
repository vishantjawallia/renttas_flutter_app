// ignore_for_file: prefer_const_constructors, sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Color(0xff54854C),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Collaburaters"),
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
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage("https://i.pinimg.com/originals/5c/87/b3/5c87b3c0466f830a480ba2214af2c73d.png"),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ab@123 ',
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Ab@gmail.com',
                            style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const Flexible(fit: FlexFit.tight, child: SizedBox()),
                    const Column(
                      children: [
                        Text(
                          'Owner',
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Active',
                          style: TextStyle(color: Color(0xff54854C), fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
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
                              onChanged: (bool? value) => setState(() => valuefirst = value!),
                            ),
                            const Text(
                              'Product',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              'Report',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              'Qutation',
                              style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                                  'Transaction',
                                  style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                                  style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                                  style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                                  style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                                  style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                                  style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
        backgroundColor: Color(0xff54854C),
        onPressed: () {
          showbottomsheetinvitecollab(context);
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
                  // const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          "Filter",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
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
                    activeColor: Color(0xff54854C),
                    selected: false,
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: _groupValue1,
                    title: const Text("Active Collaburaters"),
                    onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                    activeColor: Color(0xff54854C),
                    selected: false,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: _groupValue1,
                    title: const Text("InActive Collaburaters"),
                    onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                    activeColor: Color(0xff54854C),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Flexible(
                          child: Text(
                            "Invite collaburaters",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                        const SizedBox(width: 50),
                        const Flexible(fit: FlexFit.tight, child: SizedBox()),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
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
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(child: Icon(Icons.qr_code_scanner_outlined, size: 200)),
                    const Center(
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        "Share this code with your partner or \nbusiness personso they can accessthis \nbusiness",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "8JUTGYESX",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    const SizedBox(height: 15),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff54854C),
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
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Color(0xff54854C)),
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
                          color: Colors.grey.shade200,
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
                                color: Colors.black,
                              ),
                              Center(
                                child: TextButton(
                                  child: const Text(
                                    'SEND INVITATION',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
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
              ),
            );
          },
        );
      },
    );
  }
}
