library phone_otp_verification;

import 'package:flutter/material.dart';
import 'package:phone_otp_verification/data/countries_list.dart';
import 'package:phone_otp_verification/models/country_model.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification(
      {super.key,
      this.otpVerificationWidget,
      required this.isFirstPage,
      this.enableLogo,
      this.logoPath,
      this.themeColor,
      this.backgroundColor,
      this.textColor,
      this.hintColor,
      required this.onSend,
      required this.onVerification,
      this.resend,
      this.otpTitleText,
      this.style,
      this.initialPageText,
      this.initialPageTextStyle});
  final Widget? otpVerificationWidget;
  final bool isFirstPage;
  final bool? enableLogo;
  final String? logoPath;
  final String? otpTitleText;
  final String? initialPageText;
  final Color? themeColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Widget? resend;
  final ValueChanged<String> onSend;
  final ValueChanged<String> onVerification;
  final TextStyle? style;
  final TextStyle? initialPageTextStyle;
  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final PageController controller = PageController(initialPage: 0);
  late final ScrollController scrollController;
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController searchQuery = TextEditingController();
  int pageIndex = 0;

  Country country = Country(
    country: 'United States',
    phoneCode: '+1',
  );

  bool search = false;

  String? verificationCode;

  Map<String, List<Country>> allCountries = groupCountries(countries);
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  List<Country> searchResults = [];

  List<Country>? searchCountries(String query) {
    if (query.isEmpty) {
      return [];
    }

    return countries
        .where((country) =>
            country.country.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.backgroundColor ?? Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: widget.backgroundColor == Colors.black
                  ? Colors.white
                  : Colors.black),
          backgroundColor: widget.backgroundColor ?? Colors.white,
          elevation: 0,
          title: pageIndex == 0 || pageIndex == 1
              ? const SizedBox.shrink()
              : !search
                  ? Text(
                      'Region',
                      style: TextStyle(
                          fontSize: 18,
                          color: widget.textColor ?? Colors.black),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: searchQuery,
                        onChanged: (query) {
                          setState(() {
                            searchResults = searchCountries(query)!;
                          });
                        },
                        cursorHeight: 15,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
          leading: GestureDetector(
            onTap: () {
              if (pageIndex == 0 && widget.isFirstPage == true) {
                Navigator.pop(context);
              } else {
                setState(() {
                  pageIndex = 0;
                });
                if (controller.hasClients && mounted) {
                  controller.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                }
              }
            },
            child: pageIndex != 0
                ? const Icon(Icons.arrow_back_ios)
                : !widget.isFirstPage
                    ? const Icon(Icons.close)
                    : const SizedBox.shrink(),
          ),
          actions: [
            pageIndex == 2
                ? Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          search = !search;
                          searchQuery.clear();
                          searchResults = [];
                        });
                      },
                      child: Icon(!search ? Icons.search : Icons.close),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 50),
                  widget.enableLogo == null || widget.enableLogo == false
                      ? const SizedBox.shrink()
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            child: widget.logoPath != null &&
                                    widget.enableLogo == true
                                ? Image(
                                    image: AssetImage(widget.logoPath ?? ''),
                                    height: 100,
                                    width: 100,
                                  )
                                : const Icon(
                                    Icons.image_rounded,
                                    size: 50,
                                    color: Colors.green,
                                  ),
                          )),
                  widget.enableLogo == null || widget.enableLogo == false
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 30),
                  Center(
                      child: Text(
                    widget.initialPageText ?? 'Login Via Phone Number',
                    style: widget.initialPageTextStyle ??
                        TextStyle(
                            fontSize: 16,
                            color: widget.textColor ?? Colors.black),
                  )),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pageIndex = 2;
                      });
                      if (controller.hasClients && mounted) {
                        controller.animateToPage(2,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Region',
                          style: TextStyle(
                              color: widget.textColor ?? Colors.black),
                        ),
                        const SizedBox(width: 35),
                        Text(
                          '${country.country} ( ${country.phoneCode} )',
                          style: TextStyle(
                              color: widget.textColor ?? Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  ),
                  TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {});
                    },
                    style: TextStyle(color: widget.textColor ?? Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter a phone number',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SizedBox(
                            width: 80,
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                  color: widget.textColor ?? Colors.black),
                            )),
                      ),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: widget.hintColor ?? Colors.grey.shade400),
                      suffixIcon: phoneNumber.text.length < 7
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () => widget
                                  .onSend(country.phoneCode + phoneNumber.text),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 18,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            widget.themeColor ?? Colors.green,
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Send",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            widget.textColor ?? Colors.black),
                                  )),
                                ),
                              ),
                            ),
                      border: InputBorder.none,
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 30),
                  const Center(
                      child: Text(
                    'The above phone number will only be used for login verification. Please confirm your country code and enter your phone number.',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  )),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      if (phoneNumber.text.length < 7) {
                        return;
                      } else {
                        setState(() {
                          pageIndex = 1;
                        });
                        if (controller.hasClients && mounted) {
                          controller.animateToPage(1,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOut);
                        }
                      }
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: phoneNumber.text.length > 7
                            ? widget.themeColor ?? Colors.green.shade600
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        'Agree & Continue',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            widget.otpVerificationWidget == null
                ? pageIndex == 1
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            const SizedBox(
                              height: 90,
                            ),
                            widget.enableLogo == null ||
                                    widget.enableLogo == false
                                ? const SizedBox.shrink()
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey.shade200,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      child: widget.logoPath != null &&
                                              widget.enableLogo == true
                                          ? Image(
                                              image: AssetImage(
                                                  widget.logoPath ?? ''),
                                              height: 100,
                                              width: 100,
                                            )
                                          : const Icon(
                                              Icons.image_rounded,
                                              size: 50,
                                              color: Colors.green,
                                            ),
                                    )),
                            const SizedBox(height: 30),
                            Center(
                              child: Text(
                                  widget.otpTitleText ?? "Enter Your Code",
                                  style: widget.style ??
                                      TextStyle(
                                          fontSize: 20,
                                          color:
                                              widget.themeColor ?? Colors.green,
                                          fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                                "Enter the code sent to your phone number, if you did not send recieve the code, click resend",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal)),
                            const SizedBox(
                              height: 20,
                            ),
                            OtpTextField(
                              numberOfFields: 6,
                              borderColor: Colors.grey,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              focusedBorderColor:
                                  widget.themeColor ?? Colors.green,
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: widget.textColor ?? Colors.black,
                                  fontWeight: FontWeight.bold),
                              showFieldAsBox: false,
                              borderWidth: 2.0,
                              onCodeChanged: (String code) {},
                              onSubmit: (String code) {
                                verificationCode = code;
                                if (mounted) {
                                  if (verificationCode == null) {
                                    return;
                                  } else {
                                    widget.onVerification(verificationCode!);
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            widget.resend == null
                                ? const SizedBox.shrink()
                                : widget.resend!,
                            GestureDetector(
                              onTap: () {
                                if (verificationCode == null) {
                                  return;
                                } else {
                                  widget.onVerification(verificationCode!);
                                }
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: verificationCode != null &&
                                          verificationCode!.length == 6
                                      ? widget.themeColor ??
                                          Colors.green.shade600
                                      : Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                    child: Text(
                                  'Verify and Login',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: widget.backgroundColor ?? Colors.white,
                      )
                : widget.otpVerificationWidget!,
            searchResults.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        Country pickedCountry = searchResults[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              search = !search;
                              searchQuery.clear();
                              searchResults = [];
                              country = pickedCountry;
                              pageIndex = 0;
                            });
                            if (scrollController.hasClients && mounted) {
                              controller.animateToPage(0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.fastOutSlowIn);
                            }
                          },
                          title: Text(
                            pickedCountry.country,
                            style: TextStyle(
                                color: widget.textColor ?? Colors.black),
                          ),
                          trailing: Text(
                            pickedCountry.phoneCode,
                            style: TextStyle(
                                color: widget.textColor ?? Colors.black),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: allCountries.values.fold(
                          0,
                          (previousValue, element) =>
                              previousValue! +
                              element.length +
                              1), // +1 for the header
                      itemBuilder: (context, index) {
                        int count = 0;
                        for (var letter in allCountries.keys) {
                          int size = allCountries[letter]!.length + 1;
                          if (index < count + size) {
                            if (index == count) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
                                child: Text(letter,
                                    style: TextStyle(
                                        color: widget.textColor ?? Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              );
                            }
                            Country pickedCountry =
                                allCountries[letter]![index - count - 1];
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  country = pickedCountry;
                                  pageIndex = 0;
                                });

                                if (controller.hasClients && mounted) {
                                  controller.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.fastOutSlowIn);
                                }
                              },
                              title: Text(
                                pickedCountry.country,
                                style: TextStyle(
                                    color: widget.textColor ?? Colors.black),
                              ),
                              trailing: Text(
                                pickedCountry.phoneCode,
                                style: TextStyle(
                                    color: widget.textColor ?? Colors.black),
                              ),
                            );
                          }
                          count += size;
                        }
                        return const SizedBox
                            .shrink(); // Fallback, should not reach here
                      },
                    )),
          ],
        ));
  }
}
