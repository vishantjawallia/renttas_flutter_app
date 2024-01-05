// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TermCondition extends StatefulWidget {
  const TermCondition({Key? key}) : super(key: key);

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  final String htmlText = '''
   <p>1. Service Description: A clear description of the rent management service provided by Rent Shakti, including the scope of services, features, and benefits offered.<br>
2. Fees and Payments: Details about the fees associated with the service, including any upfront charges, subscription fees, or transaction costs. The payment schedule and accepted payment methods should also be outlined.<br>
3. Rental Agreement: If Rent Shakti assists in managing rental properties, the terms and conditions related to rental agreements should be included. This may cover topics such as lease terms, rent collection procedures, security deposits, and lease termination policies.<br>
4. Data Privacy and Security: Information on how Rent Shakti handles and protects your personal and financial data should be stated, ensuring compliance with relevant data protection laws and regulations.<br>
5. Responsibilities and Obligations: Both the customer's and Rent Shakti's responsibilities should be clearly defined to avoid misunderstandings or disputes.<br>
6. Termination and Cancellation: The process for terminating the service or canceling the subscription should be outlined, along with any applicable penalties or refund policies.<br>
7. Liability and Indemnification: A clause that explains the limitations of liability for both parties and any provisions for indemnification in case of legal issues.<br>
8. Governing Law: The jurisdiction under which any disputes or legal matters will be governed should be specified.<br>
9. Modifications to Terms: A statement indicating that the terms and conditions are subject to change and how customers will be notified of any updates.<br>
10. Customer Support: Information about the customer support channels available and the response time for resolving issues or inquiries.</p>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54854C),
        title: Text('Term & Condition'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Html(data: htmlText),
      ),
    );
  }
}
