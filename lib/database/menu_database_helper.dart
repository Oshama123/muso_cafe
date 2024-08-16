import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MenuDatabaseHelper {
  static final MenuDatabaseHelper instance = MenuDatabaseHelper._instance();
  static Database? _db;

  MenuDatabaseHelper._instance();

  final String table = 'menu';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnPrice = 'price';
  final String columnImageUrl = 'image_url';
  final String columnDescription = 'description';

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'menu_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnPrice REAL NOT NULL,
      $columnImageUrl TEXT NOT NULL,
      $columnDescription TEXT NOT NULL
    )
  ''');
    _addSampleMenuItems(db);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.db;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.db;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.db;
    int id = row[columnId];
    return await db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.db;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> queryMenuItems() async {
    return await queryAll();
  }

  void _addSampleMenuItems(Database db) async {
    List<Map<String, dynamic>> menuItems = [
      {
        'name': 'Pizza',
        'price': 25000.0,
        'image_url':
            'https://www.foodandwine.com/thmb/Wd4lBRZz3X_8qBr69UOu2m7I2iw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-cheese-pizza-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg',
        'description': 'Pizza klasik dengan keju mozzarella dan saus tomat.'
      },
      {
        'name': 'Burger',
        'price': 20000.0,
        'image_url':
            'https://www.foodandwine.com/thmb/Wd4lBRZz3X_8qBr69UOu2m7I2iw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-cheese-burger-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg',
        'description':
            'Burger daging sapi dengan selada, tomat, dan saus burger.'
      },
      {
        'name': 'Pasta',
        'price': 15000.0,
        'image_url':
            'https://www.foodandwine.com/thmb/Wd4lBRZz3X_8qBr69UOu2m7I2iw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-pasta-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg',
        'description': 'Pasta dengan saus tomat dan keju parmesan.'
      },
    ];

    for (var item in menuItems) {
      await db.insert(table, item);
    }

    print('Sample menu items added');
  }
}
