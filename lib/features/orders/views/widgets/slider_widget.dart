import 'package:flutter/material.dart';

class SlideToStartWidget extends StatefulWidget {
  final String pickAndDeliveryStatus;
  final VoidCallback onSlideCompleted;

  const SlideToStartWidget({
    Key? key,
    required this.onSlideCompleted,
    required this.pickAndDeliveryStatus,
  }) : super(key: key);

  @override
  _SlideToStartWidgetState createState() => _SlideToStartWidgetState();
}

class _SlideToStartWidgetState extends State<SlideToStartWidget> {
  double _sliderPosition = 10.0; // Start position of the slider
  // To handle the sliding state

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final sliderWidth = screenWidth * 0.8; // 80% of screen width
    const buttonSize = 50.0;

    return Container(
      width: sliderWidth + 20,
      height: buttonSize + 20,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Text(
                "Slide to ${getNextStatus(status: widget.pickAndDeliveryStatus)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200), // Animation duration
            curve: Curves.easeOut, // Animation curve
            top: 10,
            left: _sliderPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _sliderPosition = (details.localPosition.dx - buttonSize / 2)
                      .clamp(0.0, sliderWidth - buttonSize);
                });
              },
              onHorizontalDragEnd: (details) {
                if (_sliderPosition >= sliderWidth - buttonSize) {
                  widget.onSlideCompleted();
                  // Reset position with animation
                  setState(() {
                    _sliderPosition = 10.0;
                  });
                } else {
                  // Reset position with animation
                  setState(() {
                    _sliderPosition = 10.0;
                  });
                }
              },
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getNextStatus({required String status}) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Confirm';
      case 'confirmed':
        return 'Start';
      case 'started':
        return 'Arrive';
      case 'arrived':
        return 'Success';
      default:
        return 'Unknown';
    }
  }
}
