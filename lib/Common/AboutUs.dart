// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final String htmlText = '''
  <p>Welcome to Rent Shakti!</p>

<p>At Rent Shakti, we are a leading and innovative rental solutions provider, committed to making the rental process seamless and stress-free for both tenants and landlords. Our mission is to bridge the gap between tenants seeking their ideal rental homes and property owners looking for trustworthy and responsible occupants.</p>

<p>Our platform is designed to cater to a diverse range of rental needs, from apartments and houses to commercial spaces. Whether you're a student, young professional, family, or business owner, Rent Shakti has a comprehensive database of properties to suit your requirements.</p>

<p>What sets us apart:</p>

<p>1. Extensive Property Listings: Our platform boasts an extensive database of rental properties across various locations. We believe in offering a wide selection of options to our clients, allowing them to find the perfect rental that aligns with their preferences and budget.</p>

<p>2. User-Friendly Interface: We understand the importance of a smooth user experience. Our user-friendly website and mobile app make it easy for tenants to search, explore, and compare properties effortlessly.</p>

<p>3. Verified Listings: Trust and transparency are at the core of our values. Each property listing on our platform undergoes a thorough verification process to ensure accuracy and authenticity. We strive to eliminate any surprises and ensure that tenants get what they see in the listing.</p>

<p>4. Dedicated Customer Support: Our customer support team is always ready to assist you throughout your rental journey. Whether you have questions about a property, need help with paperwork, or have any other concerns, our team is just a call or message away.</p>

<p>5. Tenant and Landlord Services: Our commitment doesn't end with connecting tenants to their dream rentals. We also offer a range of services for landlords, including property advertising, tenant screening, and rental management, to make the rental process hassle-free for them as well.</p>

<p>At Rent Shakti, we envision a future where the rental process is efficient, transparent, and convenient for everyone involved. We are constantly evolving and striving to improve our services based on user feedback and the latest technological advancements.</p>

<p>Thank you for choosing Rent Shakti as your rental partner. We look forward to assisting you in finding your ideal rental property or helping you manage your rental investments. Happy renting!<br>
</p>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: const Color(0xff54854C),
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Html(data: htmlText),
      ),
    );
  }
}
