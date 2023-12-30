// ignore_for_file: prefer_interpolation_to_compose_strings, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import '../Accounts/AccountsReport.dart';
import 'Collaboraters.dart';
import 'Setting.dart';
import 'ViewAllBusiness.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 1,
        backgroundColor: Colors.grey.shade300,
        // backgroundColor: Colors.grey.shade300,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
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
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Inventory\nManagement",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomItem(
                            itemname: "Settings",
                            icon: Icons.settings,
                          ),
                          const DividerWidget(),
                          CustomItem(
                            itemname: "Reports",
                            icon: Icons.report,
                          ),
                          const DividerWidget(),
                          CustomItem(
                            itemname: "My Bussiness",
                            icon: Icons.streetview,
                          ),
                          const DividerWidget(),
                          CustomItem(
                            itemname: "Collaborations",
                            icon: Icons.collections,
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomItem(
                            itemname: "Rate Us",
                            icon: Icons.star_rate,
                          ),
                          const DividerWidget(),
                          CustomItem(
                            itemname: "Share with Firends",
                            icon: Icons.share,
                          ),
                          const DividerWidget(),
                          CustomItem(
                            itemname: "Privacy Policy",
                            icon: Icons.policy,
                          ),
                          const DividerWidget(),
                          CustomItem(
                            itemname: "Terms of Service",
                            icon: Icons.terminal_sharp,
                          ),
                          const DividerWidget(),
                          CustomItem(
                            itemname: "Logout",
                            icon: Icons.power_settings_new_sharp,
                          ),
                        ],
                      )),
                )
              ],
            ),
          )),
    );
  }
}

class CustomItem extends StatelessWidget {
  String itemname;
  IconData icon;
  CustomItem({super.key, required this.icon, required this.itemname});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (itemname == "Settings") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const settingsview(),
            ),
          );
        } else if (itemname == "Reports") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => accountsreport(
                userid: '',
              ),
            ),
          );
        } else if (itemname == "My Bussiness") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const viewallbuisness(),
            ),
          );
        } else if (itemname == "Collaborations") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const collabratesview(),
            ),
          );
        }
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 12),
                Text(
                  itemname,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54)
          ],
        ),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Divider(
        color: Colors.grey,
      ),
    );
  }
}
