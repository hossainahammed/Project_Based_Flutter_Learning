import 'package:flutter/material.dart';

import '../models/productModel.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Data product;


  const ProductCard({
    super.key,required this.onEdit,required this.onDelete, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 140,
            child: Image.network(
              height: 100,
              fit: BoxFit.cover,
              'data:image/jpeg;base64,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',
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  product.productName.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,),
                ),
                Text(
                  'Price : ${product.unitPrice} | QTY :  ${product.qty}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: onEdit, icon: Icon(Icons.edit,color: Colors.orange,)),
                SizedBox(width: 5,),
                IconButton(onPressed: onDelete, icon: Icon(Icons.delete,color: Colors.red,)),
              ],
            ),
          )
        ],
      ),
    );
  }
}