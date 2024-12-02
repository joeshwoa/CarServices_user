import 'dart:developer';
import 'dart:io';
import 'package:autoflex/controllers/home/carController.dart';
import 'package:autoflex/controllers/home/cart_controller.dart';
import 'package:autoflex/models/cartItem.dart' as item;
import 'package:autoflex/models/invoice.dart';
import 'package:autoflex/models/item_model.dart';
import 'package:autoflex/models/orders.dart';
import 'package:autoflex/models/vehicle.dart' as Vehicle;
import 'package:autoflex/services/Home/cartServices.dart';
import 'package:autoflex/services/orders/ordersServices.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/shared_preference.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OrdersController extends GetxController {
  var ordering = <Datum>[].obs;
  var ordered = <Datum>[].obs;

  var loading = false.obs;
  var slots = [
    {"id": 1, "from": "12 AM", "to": "1 AM"},
    {"id": 2, "from": "1 AM", "to": "2 AM"},
    {"id": 3, "from": "2 AM", "to": "3 AM"},
    {"id": 4, "from": "3 AM", "to": "4 AM"},
    {"id": 5, "from": "4 AM", "to": "5 AM"},
    {"id": 6, "from": "5 AM", "to": "6 AM"},
    {"id": 7, "from": "6 AM", "to": "7 AM"},
    {"id": 8, "from": "7 AM", "to": "8 AM"},
    {"id": 9, "from": "8 AM", "to": "9 AM"},
    {"id": 10, "from": "9 AM", "to": "10 AM"},
    {"id": 11, "from": "10 AM", "to": "11 AM"},
    {"id": 12, "from": "11 AM", "to": "12 PM"},
    {"id": 13, "from": "12 PM", "to": "1 PM"},
    {"id": 14, "from": "1 PM", "to": "2 PM"},
    {"id": 15, "from": "2 PM", "to": "3 PM"},
    {"id": 16, "from": "3 PM", "to": "4 PM"},
    {"id": 17, "from": "4 PM", "to": "5 PM"},
    {"id": 18, "from": "5 PM", "to": "6 PM"},
    {"id": 19, "from": "6 PM", "to": "7 PM"},
    {"id": 20, "from": "7 PM", "to": "8 PM"},
    {"id": 21, "from": "8 PM", "to": "9 PM"},
    {"id": 22, "from": "9 PM", "to": "10 PM"},
    {"id": 23, "from": "10 PM", "to": "11 PM"},
    {"id": 24, "from": "11 PM", "to": "12 AM"}
  ].obs;
  var vehicles = <Vehicle.Vehicle>[].obs;
  final cartController = Get.find<CartController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    if (Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
        .isLoggedIn
        .value) {
      await getOrdersList();
    }
  }

  Future<Orders?> getOrdersList() async {
    try {
      loading.value = true;
      Orders? getOrdersRequest = await OrdersServices.getOrders('pending');
      ordering.value = getOrdersRequest!.data!;
      ordered.clear();
      getOrdersRequest = await OrdersServices.getOrders('completed');
      ordered.value = getOrdersRequest!.data!;
      getOrdersRequest = await OrdersServices.getOrders('cancelled');
      ordered.value.addAll(getOrdersRequest!.data!);
      loading.value = false;
      inspect(ordered.value);
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> buildPDF(orderID) async {
    loading.value = true;
    final pw.Document pdf = pw.Document();
    late final File pdfFile;

    var arabicFontForLetters = pw.Font.ttf(await rootBundle.load("assets/fonts/Hacen-Tunisia.ttf"));
    var arabicFontForNumbers = pw.Font.ttf(await rootBundle.load("assets/fonts/Rubik-Bold.ttf"));

    final Invoice invoice = await OrdersServices.getInvoiceData(orderID)??Invoice(data: Data(items: []));

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                'INVOICE',
                style: pw. TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('867FDF')),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(color: PdfColor.fromHex('D5D6DA')),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text('Invoice ID:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 4),
                        pw.Text('#${invoice.data!.id}', style: pw.TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text('Order ID:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 4),
                        pw.Text('#${invoice.data!.items![0].id}', style: pw.TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 4),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text('Invoice Date:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 4),
                        pw.Text('${invoice.data!.createdAt!.day}-${invoice.data!.createdAt!.month}-${invoice.data!.createdAt!.year}', style: pw.TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text('Order Date:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(width: 4),
                        pw.Text('${invoice.data!.items![0].date!.day}-${invoice.data!.items![0].date!.month}-${invoice.data!.items![0].date!.year}', style: pw.TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 40),
              pw.Table(
                  border: pw.TableBorder.all(
                      width: 1,
                      color: PdfColor.fromHex('D5D6DA')
                  ),
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text('Payment Method', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('867FDF'))),
                          )
                        ],
                        decoration: pw.BoxDecoration(
                            color: PdfColor.fromHex('F2F6FF')
                        )
                    ),
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(2),
                          child: pw.Text(invoice.data!.paymentMethod??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                        )
                      ],
                    )
                  ]
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                  border: pw.TableBorder.all(
                      width: 1,
                      color: PdfColor.fromHex('D5D6DA')
                  ),
                  children: [
                    pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text('Service Name', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('867FDF'))),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text('Price', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('867FDF'))),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text('Quantity', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('867FDF'))),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text('Subtotal', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('867FDF'))),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text('Tax Amount', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('867FDF'))),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text('Grand Total', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('867FDF'))),
                          ),
                        ],
                        decoration: pw.BoxDecoration(
                            color: PdfColor.fromHex('F2F6FF')
                        )
                    ),
                    for(int i = 0; i < invoice.data!.items!.length; i++)...[
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text(invoice.data!.items![i].name??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForLetters), textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text(invoice.data!.items![i].price??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text(invoice.data!.items![i].qty.toString(), style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text(invoice.data!.items![i].formattedTotal??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text(invoice.data!.items![i].formattedTaxAmount??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(2),
                            child: pw.Text(invoice.data!.items![i].formattedGrandTotal??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                          ),
                        ],
                      ),
                      for(int y = 0; y < invoice.data!.items![i].addOns!.length; y++)...[
                        pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Text(invoice.data!.items![i].addOns![y].name??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForLetters), textDirection: pw.TextDirection.rtl, textAlign: pw.TextAlign.left),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Text(invoice.data!.items![i].addOns![y].price.toString(), style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Text(invoice.data!.items![i].addOns![y].qty.toString(), style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Text(invoice.data!.items![i].addOns![y].formattedTotal??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Text(invoice.data!.items![i].addOns![y].formattedTaxAmount??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2),
                                child: pw.Text(invoice.data!.items![i].addOns![y].formattedGrandTotal??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                              ),
                            ]
                        )
                      ]
                    ]
                  ]
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(4),
                    width: 220,
                    color: PdfColor.fromHex('F2F6FF'),
                    child: pw.Column(
                        children: [
                          pw.Row(
                              children: [
                                pw.Text('Subtotal', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.Spacer(),
                                pw.Text('-', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(width: 12),
                                pw.SizedBox(
                                  width: 80,
                                  child: pw.Text(invoice.data!.formattedSubTotal??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                                ),
                              ]
                          ),
                          pw.SizedBox(
                              height: 6
                          ),
                          pw.Row(
                              children: [
                                pw.Text('Shipping Handling', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.Spacer(),
                                pw.Text('-', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(width: 12),
                                pw.SizedBox(
                                  width: 80,
                                  child: pw.Text(invoice.data!.formattedShippingAmount??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                                ),
                              ]
                          ),
                          pw.SizedBox(
                              height: 6
                          ),
                          pw.Row(
                              children: [
                                pw.Text('Tax', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.Spacer(),
                                pw.Text('-', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(width: 12),
                                pw.SizedBox(
                                  width: 80,
                                  child: pw.Text(invoice.data!.formattedTaxAmount??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                                ),

                              ]
                          ),
                          pw.SizedBox(
                              height: 6
                          ),
                          pw.Row(
                              children: [
                                pw.Text('Discount', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.Spacer(),
                                pw.Text('-', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(width: 12),
                                pw.SizedBox(
                                  width: 80,
                                  child: pw.Text(invoice.data!.formattedDiscountAmount??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                                ),

                              ]
                          ),
                          pw.SizedBox(
                              height: 6
                          ),
                          pw.Divider(color: PdfColor.fromHex('D5D6DA')),
                          pw.SizedBox(
                              height: 6
                          ),
                          pw.Row(
                              children: [
                                pw.Text('Grand Total', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.Spacer(),
                                pw.Text('-', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(width: 12),
                                pw.SizedBox(
                                  width: 80,
                                  child: pw.Text(invoice.data!.formattedGrandTotal??'', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: arabicFontForNumbers)),
                                ),

                              ]
                          ),
                        ]
                    ),
                  )
              ),
            ],
          ); // Center
        }));

    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    pdfFile = File(appDocDirectory.path+'/'+'AutoFlex_Invoice_${invoice.data!.id}_Order_${invoice.data!.items![0].id}.pdf');
    await pdfFile.writeAsBytes(await pdf.save());// Page
    DocumentFileSavePlus().saveFile(pdfFile.readAsBytesSync(), "AutoFlex_Invoice_${invoice.data!.id}_Order_${invoice.data!.items![0].id}.pdf", "appliation/pdf");
    loading.value = false;
    toast(message: 'Invoice saved in '+appDocDirectory.path+'/'+'AutoFlex_Invoice_${invoice.data!.id}_Order_${invoice.data!.items![0].id}.pdf'+' successfully');
  }

  Future<String?> addOrders(method) async {
    try {
      loading.value = true;
      item.AddCartItem? savePaymentRequest =
          await CartService.savePayment(method: method);
      inspect(savePaymentRequest!.message);
    
      if (savePaymentRequest!.message == 'Payment method saved successfully.'||savePaymentRequest!.message!.contains('بنجاح')) {
        item.AddCartItem? checkoutRequest =
            await CartService.checkout(method: method);
        print('order details?');
        inspect(checkoutRequest!.message);
        loading.value = false;
     
        if (checkoutRequest!.message == 'Order saved successfully'||checkoutRequest!.message!.contains('بنجاح')) {
          toast(message: checkoutRequest!.message.toString());
          
          cartController.grandTotal.value = 0.0;
          return "ordered successfully";
        }
      } else {
        loading.value = false;
        return savePaymentRequest.message;
      }
      // }
    } catch (e) {
      if (kDebugMode) {
        loading.value = false;
        print(e);
      }
    }
    return null;
  }

  Future<dynamic> cancelOrder(orderId) async {
    loading.value = true;
    dynamic? cancelOrderResquest =
        await OrdersServices.cancelOrder(orderId: orderId);
    inspect(cancelOrderResquest['message']);
  
    if (cancelOrderResquest['message'] == 'Order canceled successfully.'||cancelOrderResquest['message'].contains('بنجاح')) {
      await getOrdersList();
      loading.value = false;
      toast(message: cancelOrderResquest['message']!);
    }
  }
}
