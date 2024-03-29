import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_app/datas/cart_product.dart';
import 'package:loja_app/datas/product_data.dart';
import 'package:loja_app/models/cart_model.dart';
import 'package:loja_app/models/user_model.dart';
import 'package:loja_app/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  String size;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: widget.product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${widget.product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5
                      ),
                    children: widget.product.sizes.map((s){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            widget.size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: s == widget.size ? primaryColor : Colors.grey[500],
                                width: 3
                            )
                          ),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                      onPressed: widget.size != null ?
                        (){
                            if(UserModel.of(context).isLoggedIn()){
                              //adcicionar ao carrinho
                              CartProduct cartProduct = CartProduct();
                              cartProduct.size = widget.size;
                              cartProduct.quantidade = 1;
                              cartProduct.pid = widget.product.id;
                              cartProduct.category = widget.product.category;

                              CartModel.of(context).addCartItem(cartProduct);
                            }else{
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => LoginScreen())
                              );
                            }
                        } : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho"
                        : "Entre para Comprar",
                    style: TextStyle(fontSize: 18),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                ),
                Text(widget.product.description,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
