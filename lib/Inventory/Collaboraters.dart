// ignore_for_file:  sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';

class CollabratesView extends StatefulWidget {
  const CollabratesView({super.key});

  @override
  State<CollabratesView> createState() => _CollabratesViewState();
}

class _CollabratesViewState extends State<CollabratesView> {
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: const Color(0xff54854C),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ab@123 ',
                          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ab@gmail.com',
                          style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Column(
                    children: [
                      Text(
                        'Owner',
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Active',
                        style: const TextStyle(color: Color(0xff54854C), fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
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
                          Text(
                            'Product',
                            style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                          Text(
                            'Store',
                            style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                          Text(
                            'Report',
                            style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                          Text(
                            'Qutation',
                            style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              Text(
                                'Transaction',
                                style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              Text(
                                'PRate',
                                style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              Text(
                                'Setting',
                                style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              Text(
                                'Collaburate',
                                style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              Text(
                                'SRate',
                                style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
                              Text(
                                'Both',
                                style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w600),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color(0xff54854C),
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
                  // SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Filter",
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
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
                    title: Text("All Collaburaters"),
                    onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                    activeColor: const Color(0xff54854C),
                    selected: false,
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: _groupValue1,
                    title: Text("Active Collaburaters"),
                    onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                    activeColor: const Color(0xff54854C),
                    selected: false,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: _groupValue1,
                    title: Text("InActive Collaburaters"),
                    onChanged: (newValue) => setstate(() => _groupValue1 = newValue as int),
                    activeColor: const Color(0xff54854C),
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
                        Flexible(
                          child: Text(
                            "Invite collaburaters",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
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
                    Center(
                      child: Text(
                        "Scan QR code to join current buisness",
                        style: const TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(child: Icon(Icons.qr_code_scanner_outlined, size: 200)),
                    Center(
                      child: Text(
                        "OR",
                        style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        "Share this code with your partner or \nbusiness personso they can accessthis \nbusiness",
                        style: const TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "8JUTGYESX",
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    const SizedBox(height: 15),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff54854C),
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
                                child: Text(
                                  'COPY CODE',
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
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
                                  child: Text(
                                    'SEND INVITATION',
                                    style: const TextStyle(color: Colors.black, fontSize: 16),
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
