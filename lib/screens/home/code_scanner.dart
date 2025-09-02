import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gluteno/classes/colors.dart';
import 'package:gluteno/utils/responsive_size_helper.dart';
import 'package:gluteno/widgets/app_text.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';

class CodeScanner extends StatefulWidget {
  const CodeScanner({super.key});

  @override
  State<CodeScanner> createState() => _CodeScannerState();
}

class _CodeScannerState extends State<CodeScanner>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final MobileScannerController scannerController = MobileScannerController();
  bool isScanning = true;

  static const String baseUrl = 'https://graduationprojectbackend.onrender.com';

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    scannerController.start();
  }

  @override
  void dispose() {
    animationController.dispose();
    scannerController.dispose();
    super.dispose();
  }

  void onBarcodeDetected(BarcodeCapture capture) async {
    if (!isScanning) return;

    final String? code = capture.barcodes.first.rawValue;
    if (code != null) {
      setState(() => isScanning = false);
      animationController.stop();
      scannerController.stop();

      try {
        final response = await http.get(
          Uri.parse("$baseUrl/api/products/barcode/$code"),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          final List<dynamic> products = jsonDecode(response.body);

          if (products.isNotEmpty) {
            final product = products[0];
            showProductDialog(product);
          } else {
            showError("No product found for this barcode.");
          }
        } else {
          showError("Failed to fetch data.");
        }
      } catch (_) {
        showError("Server connection failed.");
      }
    }
  }

  void showProductDialog(dynamic product) {
    String name = product['name'];
    String description = product['description'];
    double price = product['price'].toDouble();
    String type = product['type'];
    String imageUrl = product['imageUrl'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomAppText(
          text: name,
          fontSize: 18,
          color: AppColors.textColor,
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(imageUrl, height: 150),
                  const SizedBox(height: 10),
                  CustomAppText(
                    text: "Name : $name\n",
                    fontSize: 12,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomAppText(
                    text: "Description : $description \n",
                    fontSize: 12,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomAppText(
                    text: "Price: \$${price.toStringAsFixed(2)}\n",
                    fontSize: 12,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomAppText(
                    text: "Type : $type\n",
                    fontSize: 12,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 300), () {
                setState(() {
                  isScanning = true;
                  animationController.repeat();
                  scannerController.start();
                });
              });
            },
            child: const CustomAppText(
              text: "Close",
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const CustomAppText(
              text: "Error",
              fontSize: 14,
              color: Colors.red,
            ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 300), () {
                setState(() {
                  isScanning = true;
                  animationController.repeat();
                  scannerController.start();
                });
              });
            },
            child: const CustomAppText(
              text: "Close",
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: responsiveHeight(context, 100)),
            CustomAppText(
              text: "Product Scanner",
              fontSize: 20,
              hasPadding: true,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: responsiveHeight(context, 50)),
            Container(
              height: responsiveHeight(context, 400),
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.brown.shade200, width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: MobileScanner(
                  controller: scannerController,
                  onDetect: onBarcodeDetected,
                ),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 20)),
            CustomAppText(
              text: "Scan the product barcode",
              fontSize: 16,
              hasPadding: true,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            CustomAppText(
              text: "Make sure the barcode is fully visible and in focus",
              fontSize: 12,
              hasPadding: true,
              textAlign: TextAlign.center,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
