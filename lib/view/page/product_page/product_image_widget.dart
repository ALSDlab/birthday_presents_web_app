import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myk_market_app/data/model/product_model.dart';
import 'package:myk_market_app/data/model/sales_model.dart';
import 'package:myk_market_app/utils/marketing_expression.dart';

import '../../../utils/image_load_widget.dart';

class ProductImageWidget extends StatelessWidget {
  final ProductModel product;
  SalesModel? salesContent;

  ProductImageWidget({super.key, required this.product, this.salesContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageLoadWidget(
                width: ((MediaQuery.of(context).size.width >= 1200)
                        ? 1200
                        : MediaQuery.of(context).size.width) *
                    0.5,
                height: ((MediaQuery.of(context).size.width >= 1200)
                        ? 1200
                        : MediaQuery.of(context).size.width) *
                    0.3,
                imageUrl: product.representativeImage,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              (salesContent != null) ? salesContent!.salesName : '',
              style: TextStyle(fontSize: 8.w, color: Colors.red),
            ),
            Text(
              product.title,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11.w),
            ),
            // 가격 표시
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (salesContent == null)
                    ? Text(
                        '${product.price}원',
                        style: TextStyle(fontSize: 11.w),
                      )
                    : Text(
                        '${product.price}원',
                        style: TextStyle(
                            fontSize: 10.w,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                const SizedBox(
                  width: 5,
                ),
                Visibility(
                  visible: (salesContent != null),
                  child: Text(
                    '${(salesContent != null) ? deCalculatedPrice(product.price, salesContent!) : product.price}원',
                    style: TextStyle(fontSize: 11.w),
                  ),
                )
              ],
            )
          ],
        ),
        MarketingExpression(
            visible: (product.salesId >= 0),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)),
            child: (product.salesId == 0)
                ? Image.asset(
                    'assets/gifs/hot_expression.gif',
                    width: (kIsWeb) ? 70 : 50,
                    height: (kIsWeb) ? 70 : 50,
                    fit: BoxFit.cover,
                  )
                :
                // (0 < product.salesId && product.salesId <= 100) ?
                Text(
                    (salesContent != null)
                        ? (salesContent!.salesAmount > 0 &&
                                salesContent!.salesRate <= 0)
                            ? ' ${salesContent!.salesAmount}원 할인 '
                            : ' ${salesContent!.salesRate}% 세일'
                        : '',
                    style: const TextStyle(
                        color: Colors.white,
                        backgroundColor: Color(0xffb158ff)),
                  )
            // : Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         (salesContent!.salesAmount > 0 &&
            //                 salesContent!.salesRate <= 0)
            //             ? ' ${salesContent!.salesAmount}원 할인 '
            //             : '${salesContent!.salesRate}% 세일',
            //         style: const TextStyle(
            //             color: Colors.white,
            //             backgroundColor: Colors.red),
            //       ),
            //       Image.asset(
            //         'assets/gifs/hot_expression.gif',
            //         width: (kIsWeb) ? 70 : 50,
            //         height: (kIsWeb) ? 70 : 50,
            //         fit: BoxFit.cover,
            //       )
            //     ],
            //   )
            )
      ],
    );
  }

  String deCalculatedPrice(String originalPrice, SalesModel saleContent) {
    num resultPrice = int.parse(originalPrice.replaceAll(',', ''));
    if (saleContent!.salesRate <= 0 && saleContent.salesAmount > 0) {
      resultPrice = resultPrice - saleContent.salesAmount;
    } else if (saleContent.salesRate > 0 && saleContent.salesAmount <= 0) {
      resultPrice = (resultPrice * (100 - saleContent.salesRate) / 100).round();
    }
    return NumberFormat('###,###,###,###').format(resultPrice);
  }
}
