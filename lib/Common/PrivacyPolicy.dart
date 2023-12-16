import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final String htmlText = '''
  

<p>At Rent Shakti, we are committed to protecting the privacy of our users' personal information. This Privacy Policy outlines the types of information we collect, how we use it, and the choices you have regarding your data. By accessing or using our services, you consent to the practices described in this Privacy Policy.</p>

<p>1. Information we collect:<br>
a. Personal Information: We may collect personal information such as your name, address, email address, phone number, and payment information when you register for an account or use our services.<br>
b. Usage Information: We may collect information about how you use our website and services, including your search queries, browsing history, and interactions with other users.<br>
c. Cookies and Similar Technologies: We use cookies and similar tracking technologies to collect information about your interactions with our website and to enhance your user experience.</p>

<p>2. How we use your information:<br>
a. Provide Services: We use your personal information to provide and improve our services, process your transactions, and respond to your inquiries and requests.<br>
b. Communication: We may use your contact information to send you important updates, promotions, and other relevant information related to our services. You can opt-out of marketing communications at any time.<br>
c. Analytics: We may use usage data to analyze trends, track user behavior, and improve the functionality of our website.<br>
d. Compliance: We may use your information to comply with legal obligations and enforce our terms of service.</p>

<p>3. Sharing of Information:<br>
a. With Third Parties: We may share your information with trusted third-party service providers who assist us in delivering our services (e.g., payment processors, customer support platforms).<br>
b. With Other Users: Some information may be visible to other users, such as your public profile information and property listings.<br>
c. Legal Requirements: We may disclose your information if required by law or to protect our rights, privacy, safety, or property.</p>

<p>4. Data Security:<br>
We employ industry-standard security measures to protect your personal information from unauthorized access, loss, or misuse. However, no data transmission over the internet or storage method can be guaranteed to be 100% secure. You acknowledge that any information you provide to us is at your own risk.</p>

<p>5. Your Choices:<br>
a. Account Settings: You can review and update your account information at any time by logging into your account.<br>
b. Cookies: Most web browsers allow you to control cookies through their settings preferences. However, disabling cookies may impact certain features of our website.</p>

<p>6. Children's Privacy:<br>
Our services are not directed to children under the age of 13, and we do not knowingly collect personal information from children. If you believe we have inadvertently collected information from a child, please contact us immediately.</p>

<p>7. Changes to the Privacy Policy:<br>
We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. The updated policy will be posted on our website with the revised date.</p>

<p>8. Contact Us:<br>
If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at [Contact Email/Address/Phone].</p>

<p>Please read this Privacy Policy carefully and ensure that you understand its terms before using our services. By using Rent Shakti's services, you agree to be bound by this Privacy Policy.<br>
</p>
  ''';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove the back button
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
          title: Text('Privacy Policy for Renttas'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Html(data: htmlText),
        ),
      ),
    );
  }
}
