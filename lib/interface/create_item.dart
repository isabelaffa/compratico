import 'package:flutter/material.dart';
import 'package:shopping_list/helper/shopping.dart';
import 'package:shopping_list/helper/category.dart';

String? category = "food";
CategoryHelper helper = CategoryHelper();

class CreateItemPage extends StatefulWidget {
  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final _itemFocus = FocusNode();
  final _amountFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void saveItem() {
    ShoppingItem newItem = ShoppingItem();

    newItem.item = itemController.text;
    newItem.amount = int.parse(amountController.text);
    newItem.brand = brandController.text;
    newItem.category = category;
    newItem.checked = 0;

    Navigator.pop(context, newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEDF6F9),
        title: Text("Novo Item", style: TextStyle(fontSize: 20),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (itemController.text == '') {
            FocusScope.of(context).requestFocus(_itemFocus);
          } else if (amountController.text == ''){
            FocusScope.of(context).requestFocus(_amountFocus);
          } else {
            saveItem();
          }
        },
        child: Icon(Icons.check),
        backgroundColor: Color(0xFF2A9D8F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35,),
                  child: getCategoryIcon(category),
                ),
              ),
              TextField(
                focusNode: _itemFocus,
                controller: itemController,
                decoration: defaultDecoration("Item"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  focusNode: _amountFocus,
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: defaultDecoration("Quantidade"),
                ),
              ),
              TextField(
                controller: brandController,
                decoration: defaultDecoration("Marca (opcional)"),
              ),
              Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text("Categoria", style: TextStyle(fontSize: 16, color: Color(0xFF595959))),
                      )),
                  SizedBox(
                    height: 35,
                    child: RadioListTile(
                        title: Text("Alimentos"),
                        value: "food",
                        groupValue: category,
                        activeColor: Color(0xFFE29578),
                        onChanged: (String? value) {
                          setState(() {
                            category = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 35,
                    child: RadioListTile(
                        title: Text("Bebidas"),
                        value: "beverages",
                        groupValue: category,
                        activeColor: Color(0xFFE29578),
                        onChanged: (String? value) {
                          setState(() {
                            category = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 35,
                    child: RadioListTile(
                        title: Text("Higiene Pessoal"),
                        value: "hygiene",
                        groupValue: category,
                        activeColor: Color(0xFFE29578),
                        onChanged: (String? value) {
                          setState(() {
                            category = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 35,
                    child: RadioListTile(
                        title: Text("Limpeza"),
                        value: "cleaning",
                        groupValue: category,
                        activeColor: Color(0xFFE29578),
                        onChanged: (String? value) {
                          setState(() {
                            category = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 35,
                    child: RadioListTile(
                        title: Text("Congelados"),
                        value: "frozen",
                        groupValue: category,
                        activeColor: Color(0xFFE29578),
                        onChanged: (String? value) {
                          setState(() {
                            category = value;
                          });
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration defaultDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Color(0xFF264653)),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF264653)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF264653)),
    ),
  );
}

Container getCategoryIcon(String? category) {
  Map<String, dynamic> decoration = helper.getCategoryDecoration(category ?? "");
  IconData icon = decoration['icon'];
  Color color = decoration['color'];

  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    child: Icon(
      icon,
      color: Colors.white,
      size: 30,
    ),
  );
}
