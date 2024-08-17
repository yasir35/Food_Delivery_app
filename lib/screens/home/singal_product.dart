import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/widgets/count.dart';
import 'package:food_app/widgets/product_unit.dart';

class SingleProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final Function onTap;
  final String productId;
  final ProductModel productUnit;

  const SingleProduct({
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productUnit,
    required this.onTap,
    required this.productPrice,
  });

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  String? unitData;
  String? firstValue;

  @override
  void initState() {
    super.initState();
    firstValue = widget.productUnit.productUnit.isNotEmpty
        ? widget.productUnit.productUnit.first
        : null;
    unitData = firstValue;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 230,
            width: 165,
            decoration: BoxDecoration(
              color: const Color(0xffd9dad9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => widget.onTap(),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(
                      widget.productImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.productPrice}\$/${unitData ?? firstValue}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: ProductUnit(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: widget.productUnit.productUnit
                                            .map<Widget>((data) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 10, horizontal: 10),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      unitData = data;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    data,
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                      );
                                    },
                                  );
                                },
                                title: unitData ?? firstValue ?? '',
                              ),
                            ),
                            const SizedBox(width: 5),
                            Count(
                              productId: widget.productId,
                              productImage: widget.productImage,
                              productName: widget.productName,
                              productPrice: widget.productPrice,
                              productUnit: unitData ?? firstValue ?? '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
