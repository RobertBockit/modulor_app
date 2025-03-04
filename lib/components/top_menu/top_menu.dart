import 'package:flutter/material.dart';

class TopMenu extends StatefulWidget {
  final ScrollController scrollController;
  final bool forceCollapsed;

  const TopMenu({
    Key? key,
    required this.scrollController,
    this.forceCollapsed = false,
  }) : super(key: key);

  @override
  _TopMenuState createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.forceCollapsed) return;

    final offset = widget.scrollController.offset;
    final bool isNowScrolled = offset > 30;
    if (_isScrolled != isNowScrolled) {
      setState(() {
        _isScrolled = isNowScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Если forceCollapsed == true, считаем, что TopMenu уже сжат
    final bool isScrolled = widget.forceCollapsed || _isScrolled;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: isScrolled ? 4.0 : 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Если не сжат – показываем баннер
                  if (!isScrolled)
                    Image.asset(
                      'assets/topbar.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  const SizedBox(height: 5),
                  // Поисковая строка
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Search for items',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Локация
                  Row(
                    children: const [
                      Icon(Icons.location_pin, color: Colors.black, size: 16),
                      SizedBox(width: 3),
                      Text(
                        'Locker Humboldt Uni',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
