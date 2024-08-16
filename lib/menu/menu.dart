class MenuItem {
  final String imageAsset;
  final String name;
  final int price;
  final String description;
  int quantity;

  MenuItem({
    required this.imageAsset,
    required this.name,
    required this.price,
    required this.description,
    this.quantity = 0,
  });
}

final List<MenuItem> menuItems = [
  MenuItem(
    imageAsset: 'assets/image/menu/kentang_goreng.jpg',
    name: 'Kentang Goreng',
    price: 10000,
    description:
        'Kentang goreng renyah dengan taburan gariam, sempurna sebagai camilan atau pendamping makanan utama.',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/cappuccino.jpg',
    name: 'Cappuccino',
    price: 15000,
    description:
        'Minuman kopi yang terdiri dari espresso, susu panas, dan buih susu, sering kali ditaburi bubuk cokelat atau kayu manis.',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/nasi_goreng.jpg',
    name: 'Nasi Goreng',
    price: 20000,
    description: 'Nasi goreng spesial dengan ayam, telur, dan sayuran.',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/mie_ayam.jpg',
    name: 'Mie Ayam',
    price: 15000,
    description: 'Mie ayam dengan kuah kaldu yang lezat dan daging ayam.',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/telur_dadar.jpg',
    name: 'Telur Dadar',
    price: 5000,
    description: 'Telur dadar yang lebar dan bervolume lezat.',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/nasi_putih.jpg',
    name: 'Nasi Putih',
    price: 3000,
    description: 'Nasi putih anget.',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/sup_ayam.jpg',
    name: 'Sup Ayam Jagung',
    price: 10000,
    description:
        'Sup hangat dan bergizi dengan potongan ayam dan jagung manis, sering disajikan dengan roti atau kerupuk.',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/carbonara.jpg',
    name: 'Carbonara',
    price: 35000,
    description:
        'Hidangan pasta dengan berbagai pilihan saus, seperti spaghetti bolognese (saus daging tomat), fettuccine alfredo (saus krim), dan carbonara (saus krim dengan bacon dan telur).',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/onion_rings.jpg',
    name: 'Onion Rings',
    price: 20000,
    description:
        'Irisan bawang bombay yang dilapisi tepung berbumbu dan digoreng hingga garing, disajikan dengan saus pendamping.',
  ),
  MenuItem(
    imageAsset: 'assets/image/menu/garlic_bread.jpg',
    name: 'Garlic Bread',
    price: 25000,
    description:
        'Roti panggang dengan mentega dan bawang putih yang harum, bisa menjadi pendamping sup atau hidangan utama.',
  ),
];
