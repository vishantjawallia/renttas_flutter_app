// ignore_for_file: unused_local_variable, use_super_parameters

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../landlord/LanlordRegisterNew.dart';
import '../tandent/TenantRegister.dart';

class TypeUser extends StatefulWidget {
  const TypeUser({Key? key}) : super(key: key);

  @override
  State<TypeUser> createState() => _TypeUserState();
}

class _TypeUserState extends State<TypeUser> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Text(
          "suser_type".tr(),
          // 'Select user type',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 100),
        child: Column(
          children: [
            // Row(
            //   children: [
            //     BackButton(),
            //     // const SizedBox(width: 0.0, height: 30),
            //     const Text(
            //       'Select user type',
            //       style: TextStyle(
            //         fontSize: 30,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(width: 0.0, height: 40),
            InkWell(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LanlordRegisterNew())),
              child: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(offset: Offset(0.5, 0.7), color: Colors.grey, blurRadius: 7),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Image(
                        image: AssetImage("assets/images/house-owner.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 20, height: 0.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "landlord".tr(),
                          // "Landlord",
                          style: GoogleFonts.kanit(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "landlord_dsc".tr(),
                          // "Create property and manage \nProperty",
                          style: GoogleFonts.kanit(
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 0.0, height: 18),
            InkWell(
              // borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TenantRegister())),
              child: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(offset: Offset(0.5, 0.7), color: Colors.grey, blurRadius: 7),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Image(
                        image: AssetImage("assets/images/tandent.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 20, height: 0.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "tenant".tr(),
                          style: GoogleFonts.kanit(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "tenant_dsc".tr(),
                          // "Veiw Info Added by Your landlord",
                          style: GoogleFonts.kanit(
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
