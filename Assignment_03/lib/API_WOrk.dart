import 'package:flutter/material.dart';
import 'models/productModel.dart';
import 'productController.dart';
import 'widget/ProductCard.dart';

class ApiWork extends StatefulWidget {
  const ApiWork({super.key});

  @override
  State<ApiWork> createState() => _ApiWorkState();
}

class _ApiWorkState extends State<ApiWork> {
  final Productcontroller productcontroller = Productcontroller();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     productcontroller.fetchProducts();
  //
  //   });
  //
  // }


  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    print('Loading products...');
    await productcontroller.fetchProducts();
    print('Products loaded: ${productcontroller.products.length}');
    setState(() {});
  }

  // Future<void> loadProducts() async {
  //   await productcontroller.fetchProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {




    void productDialog({Data? product}) {
      TextEditingController productNameController =
      TextEditingController(text: product?.productName ?? '');
      TextEditingController productQtyController =
      TextEditingController(text: product?.qty?.toString() ?? '');
      TextEditingController productImageController =
      TextEditingController(text: product?.img ?? '');
      TextEditingController productUnitPriceController =
      TextEditingController(text: product?.unitPrice?.toString() ?? '');
      TextEditingController productTotalPriceController =
      TextEditingController(text: product?.totalPrice?.toString() ?? '');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(product == null ? 'Add Product' : 'Edit Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: productNameController,
                  decoration: InputDecoration(labelText: 'Product name'),
                ),
                TextField(
                  controller: productQtyController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: productImageController,
                  decoration: InputDecoration(labelText: 'Product Image URL'),
                ),
                TextField(
                  controller: productUnitPriceController,
                  decoration: InputDecoration(labelText: 'Unit Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: productTotalPriceController,
                  decoration: InputDecoration(labelText: 'Total Price'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () async {
                        if (product == null) {
                          // ADD
                          await productcontroller.createProduct(
                            name: productNameController.text,
                            image: productImageController.text,
                            qty: int.tryParse(productQtyController.text) ?? 0,
                            unitPrice:
                            int.tryParse(productUnitPriceController.text) ?? 0,
                            totalPrice:
                            int.tryParse(productTotalPriceController.text) ?? 0,
                          );
                        } else {
                          // EDIT (Update)
                          await productcontroller.updateProduct(
                            id: product.sId!,
                            name: productNameController.text,
                            image: productImageController.text,
                            qty: int.tryParse(productQtyController.text) ?? 0,
                            unitPrice:
                            int.tryParse(productUnitPriceController.text) ?? 0,
                            totalPrice:
                            int.tryParse(productTotalPriceController.text) ?? 0,
                          );
                        }

                        Navigator.pop(context);
                        await loadProducts();  // Refresh grid
                      },
                      child: Text(product == null ? 'Add Product' : 'Update Product'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Crud'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: productcontroller.products.isEmpty
          ? Center(child: Text('No products available'))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemCount: productcontroller.products.length,
        itemBuilder: (context, index) {
          var product = productcontroller.products[index];
          return ProductCard(
            product: product,
            onEdit: () => productDialog(product: product),
            onDelete: () async {
              await productcontroller.DeleteProducts(product.sId.toString());
              await loadProducts();
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: Icon(Icons.add),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => productDilouge(),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}


