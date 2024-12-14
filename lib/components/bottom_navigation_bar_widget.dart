import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        // border: Border(
        //   top: BorderSide(
        //     color: Color.fromARGB(255, 163, 17, 7),
        //     width: 1,
        //   ), // Border di atas
        // ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.transparent,
        onTap: onTap,
        elevation: 0, // Menghilangkan bayangan
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.tv, 1),
            label: 'TV Series',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 2),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = currentIndex == index;

    return Padding(
      padding: EdgeInsets.only(
          top: isSelected ? 0 : 15.0), // Posisikan lebih tinggi jika aktif
      child: Column(
        children: [
          Icon(
            iconData,
            color: isSelected
                ? Colors.red[900]
                : Colors.grey, // Warna ikon berubah saat aktif
            size: isSelected ? 30 : 24, // Ukuran lebih besar jika aktif
          ),
        ],
      ),
    );
  }
}
