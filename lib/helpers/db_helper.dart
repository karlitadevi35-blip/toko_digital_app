import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('toko_digital.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE master_products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        image_url TEXT NOT NULL
      )
    ''');

    await db.execute('''
  CREATE TABLE local_cart (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    price REAL NOT NULL,
    quantity INTEGER NOT NULL,
    image_url TEXT NOT NULL
  )
''');

    // Katalog Kopi & Minuman Kekinian + Link Foto Teruji
    await db.insert('master_products', {
      'name': 'Es Kopi Susu Aren',
      'price': 18000.0,
      'image_url': 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&auto=format&fit=crop'
    });
    await db.insert('master_products', {
      'name': 'Iced Matcha Latte',
      'price': 22000.0,
      'image_url': 'https://tse4.mm.bing.net/th/id/OIP.O-oV353WtvKEUeetCJ3kcQHaO0?r=0&pid=Api&h=220&P=0'
    });
    await db.insert('master_products', {
      'name': 'Iced Americano',
      'price': 15000.0,
      'image_url': 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=500&auto=format&fit=crop'
    });
    await db.insert('master_products', {
      'name': 'Chocolate Signature',
      'price': 20000.0,
      'image_url': 'https://tse2.mm.bing.net/th/id/OIP.--7dsB_i0VieNyRllSW3XAHaHa?r=0&pid=Api&h=220&P=0'
    });
    await db.insert('master_products', {
      'name': 'Bobalicious Milk Tea',
      'price': 24000.0,
      'image_url': 'https://tse1.mm.bing.net/th/id/OIP.fwKjRlaUWomaDdcPundUUAHaEc?r=0&pid=Api&h=220&P=0'
    });
    await db.insert('master_products', {
      'name': 'Caramel Macchiato',
      'price': 25000.0,
      'image_url': 'https://tse3.mm.bing.net/th/id/OIP.Vzgs6cCUsEmXm5UUxVpWlgHaHa?r=0&pid=Api&h=220&P=0'
    });
  }

  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final result = await db.query('master_products');
    return result.map((json) => Product.fromMap(json)).toList();
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await instance.database;
    final result = await db.query('local_cart');
    return result.map((json) => CartItem.fromMap(json)).toList();
  }

  Future<int> insertCart(CartItem item) async {
    final db = await instance.database;
    return await db.insert('local_cart', item.toMap());
  }

  Future<int> updateCartQuantity(int id, int quantity) async {
    final db = await instance.database;
    return await db.update(
      'local_cart',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCartItem(int id) async {
    final db = await instance.database;
    return await db.delete(
      'local_cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}