import 'package:flutter/material.dart';

class ServiceCarousel extends StatefulWidget {
  const ServiceCarousel({super.key});

  @override
  State<ServiceCarousel> createState() => _ServiceCarouselState();
}

class _ServiceCarouselState extends State<ServiceCarousel> with SingleTickerProviderStateMixin {
  final List<CarouselItem> _items = [
    CarouselItem(title: 'Floral decoration', image: 'assets/images/carousel_1.jpg'),
    CarouselItem(title: 'Party', image: 'assets/images/carousel_2.jpg'),
    CarouselItem(title: 'Wedding', image: 'assets/images/carousel_3.jpg'),
    CarouselItem(title: 'Corporate', image: 'assets/images/carousel_4.jpg'),
  ];

  late double _page;
  late double _childSize;
  late int _centerIndex;
  final int _lengthMultiplier = 10;
  final double _opacityMultiplier = 1.0; // Reduced opacity effect
  double _dragStartX = 0;
  double _dragPosition = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _centerIndex = (_items.length * _lengthMultiplier) ~/ 2;
    _page = _centerIndex.toDouble();
    _childSize = 240; // Keep the larger size
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _dragStartX = details.localPosition.dx;
      _dragPosition = _page;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
    
    final double dragDistance = details.localPosition.dx - _dragStartX;
    final double dragUpdate = -dragDistance / (_childSize * 1.2) * 1.5; 
    
    setState(() {
      _page = (_dragPosition + dragUpdate).clamp(
        0.0,
        (_items.length * _lengthMultiplier - 1).toDouble(),
      );
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
      _page = _page.round().toDouble();
    });
  }

  List<Widget> _buildStackChildren() {
    final int increasedLength = _items.length * _lengthMultiplier;
    // Removed intermediate list, build ordered stack directly
    List<Widget> leftCards = [];
    List<Widget> rightCards = [];
    Widget? centerCard;
    
    final int pageInt = _page.round();

    for (int stackIndex = 0; stackIndex < increasedLength; stackIndex++) {
      final itemIndex = stackIndex % _items.length;
      final item = _items[itemIndex];
      final bool isActive = stackIndex == pageInt;
      final double diff = (stackIndex - _page);
      final double diffAbs = diff.abs();

      // Process cards within 2 positions + buffer
      if (diffAbs > 2.5) continue;

      // Adjusted Scaling - Less aggressive
      final double scale = (1 - diffAbs * 0.15).clamp(0.0, 1.0);
      
      // Adjusted horizontal translation for wider fan
      final double translateX = diff * _childSize * 0.30; 
      final double translateY = diffAbs * 5.0; // Slightly less vertical offset
      
      // Adjusted Opacity - Less fading
      double opacity = (1.0 - diffAbs / 2.5 * _opacityMultiplier).clamp(0.3, 1.0); // Clamp minimum opacity
      
      // Increased Rotation

      Widget card = Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Perspective
          ..translate(translateX, translateY/*, translateZ*/)
          ..scale(scale)
          
        ,
        child: Opacity(
          opacity: opacity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: _childSize,
                height: _childSize * 1.46, 
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isActive ? 0.25 : 0.15),
                      blurRadius: isActive ? 15 : 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      item.image,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      // Keep gradient overlay for text readability
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.6),
                          ],
                          stops: const [0.5, 0.7, 1.0], // Adjust stops
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isActive ? 20 : 16, 
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (isActive) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Text(
                                'View Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Removed the extra dark overlay for inactive cards
            ],
          ),
        ),
      );

      // Add card to the correct list based on position
      if (isActive) {
        centerCard = card;
      } else if (diff < 0) {
        leftCards.add(card);
      } else {
        rightCards.add(card);
      }
    }

    // Combine lists: left cards, then reversed right cards, then center card on top
    return [...leftCards, ...rightCards.reversed, if (centerCard != null) centerCard];
  }

  @override
  Widget build(BuildContext context) {
    // Larger child size, clamped
    _childSize = (MediaQuery.of(context).size.width * 0.45).clamp(220.0, 260.0);

    return Container(
      height: _childSize * 2.2, 
      padding: const EdgeInsets.symmetric(vertical: 60), 
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: _onHorizontalDragEnd,
       
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none, 
            children: _buildStackChildren(),
          ),
        ),
      ),
    );
  }
}

class CarouselItem {
  final String title;
  final String image;

  CarouselItem({required this.title, required this.image});
} 