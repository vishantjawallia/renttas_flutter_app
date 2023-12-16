import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../landlord/LanlordRegister.dart';
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
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.1, top: screenHeight * 0.1),
            child: Text(
              'Select \nuser type',
              style: GoogleFonts.kanit(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LanlordRegister()));
            },
            child: SizedBox(
              width: screenWidth * 0.95,
              height: screenHeight * 0.26,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 9),
                        child: SizedBox(
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.2,
                          child: Image(
                            image: AssetImage("assets/images/house-owner.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.10,),
                      Padding(
                        padding: EdgeInsets.only(
                           top: screenHeight * 0.1),
                        child: Column(
                          children: [
                            Text(
                              "Landlord",
                              style: GoogleFonts.kanit(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "CreateProperty and\n manage Property",
                              style: GoogleFonts.kanit(
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const TenantRegister()));
            },
            child: SizedBox(
              width: screenWidth * 0.95,
              height: screenHeight * 0.26,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 9),
                        child: SizedBox(
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.2,
                          child: Image(
                            image: AssetImage("assets/images/tandent.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.10,),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.1),
                        child: Column(
                          children: [
                            Text(
                              "Tenant",
                              style: GoogleFonts.kanit(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "Veiw Info Added \nby Your landlord",
                              style: GoogleFonts.kanit(
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
