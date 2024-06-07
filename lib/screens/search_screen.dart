import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import '../utils/text_highlighter.dart'; // Import thư viện text_highlighter

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40.0), // Khoảng cách từ đầu màn hình
            Container(
              width: 380.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Đổ bóng theo hướng x, y
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) => provider.searchAddress(value),
                decoration: const InputDecoration(
                  hintText: 'Enter keyword',
                  prefixIcon: Icon(Icons.search, size: 24.0), // Điều chỉnh kích thước biểu tượng
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10.0), // Khoảng cách giữa thanh tìm kiếm và danh sách kết quả
            Expanded(
              child: ListView.builder(
                itemCount: provider.results.length,
                itemBuilder: (context, index) {
                  final result = provider.results[index];
                  return ListTile(
                    leading: Icon(Icons.location_on), // Icon định vị
                    title: TextHighlighter.highlightText(result.title, provider.searchQuery),
                    trailing: IconButton(
                      icon: Icon(Icons.directions),
                      onPressed: () => provider.openGoogleMaps(result.coordinates),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
