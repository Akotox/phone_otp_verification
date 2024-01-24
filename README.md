<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This Flutter package is a comprehensive solution designed for applications requiring country selection with phone codes and OTP (One-Time Password) verification. It offers a seamless and efficient user experience with an array of customizable features, making it an ideal choice for any Flutter application that needs robust authentication and country selection functionality.


## Features

- **List of Countries with Names and Phone Codes:** An extensive list of countries, complete with names and international phone codes.

- **Alphabetical Grouping of Countries:** Countries are organized alphabetically for easy navigation and selection.

- **Search Functionality:** Quickly find countries using the powerful search feature.

- **Retrieve Full Phone Number:** Captures the full phone number, including the country code, before OTP verification.

- **Elegant OTP Verification Interface:** A beautifully designed interface for OTP verification, enhancing user engagement.

- **Easy OTP Sending and Verification Hook:** Simplifies the process of sending and verifying OTPs, allowing for seamless integration with your backend systems.

- **Callback Function After OTP Verification:** Provides a callback function for additional actions post-OTP verification.

- **Dark Mode and Light Mode Support:** Ensures compatibility with different user interface themes.

- **Highly Customizable:** Options to add a logo and custom text, allowing for branding consistency.

- **Easy Integration:** Designed for straightforward integration with any Flutter application.

## Getting Started

[Youtube](https://firebasestorage.googleapis.com/v0/b/authenification-25740.appspot.com/o/thumbnail.png?alt=media&token=f866e52e-5905-4efc-b3b2-aa30f7a9bc9e)(https://www.youtube.com/watch?v=icUYAXjOvOw&ab_channel=horizondev)

To use this package in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  phone_otp_verification: ^1.0.3
```

## Usage

import 'package:phone_otp_verification/phone_verification.dart';

// Minimal usage code here

```dart
    PhoneVerification(
      isFirstPage: true,
      onSend: (String value) {
        print('Phone number: $value');
      },
      onVerification: (String value) {
        print('OTP: $value');
      },
    )
```

// Custom usage code here

```dart
    PhoneVerification(
      isFirstPage: true,
      enableLogo: false,
      themeColor: Colors.green,
      onSend: (String value) {
        print('Phone number: $value');
      },
      onVerification: (String value) {
        print('OTP: $value');
      },
    )
```

## Additional Information

### More About the Package

Our Flutter Country Picker & OTP Verification Package is designed to streamline the process of implementing country selection and OTP verification in your Flutter applications. The package is meticulously crafted to ensure ease of use, high performance, and flexibility, making it a valuable addition to a wide range of Flutter projects.

To learn more about the package, explore its features, and understand its capabilities in depth, please visit our [official documentation](https://discord.gg/stmfH6pMKK). The documentation provides detailed information about each component, along with usage examples and tips for customization.

### Contributing

We openly welcome contributions from the developer community. Whether it's improving the code, fixing bugs, or enhancing documentation, your input is valuable. To contribute, please follow these steps:

1. Fork the repository on GitHub.
2. Create a new branch for your changes.
3. Make your changes in the branch.
4. Submit a pull request with a clear description of the improvements.

Before contributing, please read our [Contributing Guidelines](https://discord.gg/stmfH6pMKK) for more details on the process and coding standards.

### Filing Issues

Encountering an issue or have a suggestion? We encourage you to file issues through our GitHub [Issues Page](https://github.com/Akotox/phone_otp_verification/issues). When filing an issue, please provide the following:

- A clear and descriptive title.
- A detailed description of the issue or suggestion.
- Steps to reproduce the issue (if applicable).
- Any relevant code snippets or error messages.

### Support and Response

Our team is committed to providing support for the package users. While we strive to respond to issues and pull requests promptly, please allow a reasonable amount of time for a response. For immediate support or specific queries, you can also reach out to us via [official support channel](https://discord.gg/stmfH6pMKK).

### Stay Updated

To stay updated with the latest releases, features, and updates, please follow us on [GitHub](https://github.com/WilinxGroup) or subscribe to our newsletter.

We appreciate your interest in our package and look forward to your valuable contributions and feedback!

