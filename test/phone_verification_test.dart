import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_otp_verification/phone_verification.dart';

void main() {
  testWidgets('PhoneVerification widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
       MaterialApp(
        home: PhoneVerification(
          enableLogo: false,
          isFirstPage: true, onSend: (String value) {  }, onVerification: (String value) {  },),
      ),
    );

    // Verify that the initial page is displayed
    expect(find.text('Login Via Phone Number'), findsOneWidget);
    expect(find.text('Region'), findsOneWidget);
    expect(find.text('Phone'), findsOneWidget);
    expect(find.text('Enter a phone number'), findsOneWidget);
    expect(find.text('Agree & Continue'), findsOneWidget);

    // Tap on the 'Agree & Continue' button
    await tester.tap(find.text('Agree & Continue'));
    await tester.pump();

    // Verify that the OTP verification page is displayed
    expect(find.text('Enter OTP'), findsOneWidget);
    expect(find.text('Verify'), findsOneWidget);

    // TODO: Add more test cases as needed

  });

}
