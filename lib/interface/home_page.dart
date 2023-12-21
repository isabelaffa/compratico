import 'package:flutter/material.dart';
import 'package:shopping_list/helper/category.dart';
import 'package:shopping_list/interface/creator_page.dart';
import 'package:shopping_list/interface/use_guide.dart';
import '../helper/shopping.dart';
import '../interface/create_item.dart';

//duas constantes para ordenar
enum OrderOptions { orderAZ, orderZA, orderCategory }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShoppingItemHelper helper = ShoppingItemHelper();
  CategoryHelper categoryHelper = CategoryHelper();

  List<ShoppingItem> shoppingItems = [];

  late ShoppingItem _lastRemoved;
  late int _lastRemovedPos;

  @override
  void initState() {
    super.initState();

    _getAllShoppingItems();
    // ShoppingItem si = ShoppingItem();
    // si.item = "Arroz";
    // si.amount = 2;
    // si.brand = "Prato Fino";
    // si.checked = 0;
    //
    // helper.saveShoppingItem(si);
    //
    // helper.getAllShoppingItems().then((list) => {
    //   print(list)
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Color(0xFFEDF6F9),
        centerTitle: true,
        actions: [
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderAZ,
                child: Text('Ordenar de A-Z'),
              ),
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderZA,
                child: Text('Ordenar de Z-A'),
              ),
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderCategory,
                child: Text('Ordenar por Categoria'),
              ),
            ],
            onSelected: _orderList,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateItemPage();
          // helper.alterTable();
        },
        backgroundColor: Color(0xFF83C5BE),
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white,),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("images/icon.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("Bem-vindo(a) ao Comprático!"),
                  Text("Seu app de lista de compras")
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: const Text('Adicione um novo item'),
              onTap: () {
                _showCreateItemPage();
              },
            ),
            ListTile(
              leading: Icon(Icons.article_outlined),
              title: const Text('Manual de Uso'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UseGuidePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.face_retouching_natural),
              title: const Text('Conheça a criadora do app'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatorPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 320),
            IconButton(
              onPressed: () {
                _printAllItems();
              },
              icon: Icon(Icons.bug_report_outlined),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: shoppingItems.length,
                    itemBuilder: (context, index) {
                      return _shoppingItemCard(context, index);
                    }
                )
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _shoppingItemCard(BuildContext context, int index) {
    return GestureDetector(
      onLongPress: () {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return _showEditDialog(item: shoppingItems[index]);
            });
      },
      child: Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Color.fromRGBO(255, 103, 0, 1),
          child: Align(
              alignment: Alignment(-0.9, 0.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("DELETAR",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              )),
        ),
        direction: DismissDirection.startToEnd,
        child: CheckboxListTile(
          activeColor: Color(0xFFE29578),
          title: Text(
              "${shoppingItems[index].item} ${shoppingItems[index].brand!.isNotEmpty ? " | " : ""} ${shoppingItems[index].brand}",
              overflow: TextOverflow.ellipsis,
              style: shoppingItems[index].checked == 1
                ? TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)
                : TextStyle(),
          ),
          subtitle: Text(
              "Quantidade: ${shoppingItems[index].amount.toString() ?? ''}",
              style: shoppingItems[index].checked == 1
                  ? TextStyle(color: Colors.black26)
                  : TextStyle(),
          ),
          value: shoppingItems[index].checked == 0 ? false : true,
          secondary: getCategoryDecoration(shoppingItems[index].category, shoppingItems[index].checked),
          onChanged: (c) {
            setState(() {
              shoppingItems[index].checked = c == true ? 1 : 0;
              helper.updateShoppingItem(shoppingItems[index]);
              // _getAllShoppingItems();
            });
          },
        ),
        onDismissed: (direction) {
          setState(() {
            helper.deleteShoppingItem(shoppingItems[index].id!);
            _getAllShoppingItems();
          });
        },
      ),
    );
  }

  Widget _showEditDialog({required ShoppingItem item}) {
    final TextEditingController itemController = TextEditingController(text: item.item);
    final TextEditingController brandController = TextEditingController(text: item.brand);
    final TextEditingController amountController = TextEditingController(text: item.amount.toString());

    return SimpleDialog(
      title: const Text('Editar Item'),
      backgroundColor: Color(0xFFEDF6F9),
      elevation: 10,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: TextField(
            controller: itemController,
            decoration: defaultDecoration("Item"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: defaultDecoration("Quantidade"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: TextField(
            controller: brandController,
            decoration: defaultDecoration("Marca (opcional)"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Color(0xFFFF8680),
                child: Icon(Icons.arrow_back),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  final updatedItem = item;
                  updatedItem.item = itemController.text;
                  updatedItem.brand = brandController.text;
                  updatedItem.amount = int.parse(amountController.text);

                  helper.updateShoppingItem(updatedItem);

                  Navigator.pop(context);
                  _getAllShoppingItems();
                },
                backgroundColor: Color(0xFF97C294),
                child: Icon(Icons.check),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCreateItemPage() async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateItemPage(),
      ),
    );

    if (newItem != null) {
      await helper.saveShoppingItem(newItem);
      _getAllShoppingItems();
    }
  }

  void _getAllShoppingItems() {
    if (mounted) {
      helper.getAllShoppingItems().then((list) {
        setState(() {
          shoppingItems = list;
        });
      });
    }
  }

  void _printAllItems() {
    if (mounted) {
      final list = helper.getAllShoppingItems().then((list) {
        for (ShoppingItem item in list) {
          print(item.toString());
        }
      });
    }
  }

  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderAZ:
        shoppingItems.sort((a,b){
          return a.item!.toLowerCase().compareTo(b.item!.toLowerCase());
        });
        break;
      case OrderOptions.orderZA:
        shoppingItems.sort((a,b){
          return b.item!.toLowerCase().compareTo(a.item!.toLowerCase());
        });
        break;
      case OrderOptions.orderCategory:
        shoppingItems.sort((a,b){
          return a.category!.toLowerCase().compareTo(b.category!.toLowerCase());
        });
        break;
    }
    setState(() {});
  }

  CircleAvatar getCategoryDecoration(String? category, int? checked) {
    late IconData icon;
    late Color color;

    if (checked == 1) {
      return const CircleAvatar(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black54,
        child: Icon(
          Icons.check,
          size: 16,
        ),
      );
    } else {
      Map<String, dynamic> decoration =
          categoryHelper.getCategoryDecoration(category ?? "");
      icon = decoration['icon'];
      color = decoration['color'];

      return CircleAvatar(
        backgroundColor: color,
        foregroundColor: Colors.white,
        child: Icon(
          icon,
          size: 16,
        ),
      );
    }
  }
}
