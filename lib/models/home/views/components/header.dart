import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../controllers/home_controller.dart';

class Header extends GetView<HomeController> {
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileHeader(),
      desktop: _buildDesktopHeader(),
    );
  }
  Widget _buildDesktopHeader() {
    return AnimatedBuilder(
      animation: controller.heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -30 * (1 - controller.heroFadeAnimation.value)),
          child: Opacity(
            opacity: controller.heroFadeAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: controller.pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: controller.pulseAnimation.value,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                gradient: const RadialGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.6),
                                    blurRadius: 15 * controller.pulseAnimation.value,
                                    spreadRadius: 3 * controller.pulseAnimation.value,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Hamid Raza',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildAnimatedNavItem('Home', 0),
                      _buildAnimatedNavItem('Services', 1),
                      _buildAnimatedNavItem('Our Project', 2),
                      _buildAnimatedNavItem('About us', 3),
                      const SizedBox(width: 25),
                      _buildAnimatedButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileHeader() {
    return AppBar(
      title: Row(
        children: [
          AnimatedBuilder(
            animation: controller.pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: controller.pulseAnimation.value,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(colors: [Colors.blue, Colors.cyan]),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.6),
                        blurRadius: 15 * controller.pulseAnimation.value,
                        spreadRadius: 3 * controller.pulseAnimation.value,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          const Text('Hamid Raza'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Add mobile menu drawer functionality
          },
        ),
      ],
    );
  }

  Widget _buildAnimatedNavItem(String text, int index) {
    return AnimatedBuilder(
      animation: controller.heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -40 * (1 - controller.heroFadeAnimation.value)),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400 + (index * 150)),
            opacity: controller.heroFadeAnimation.value,
            child: MouseRegion(
              onEnter: (_) {},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButton() {
    return AnimatedBuilder(
      animation: controller.heroFadeAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.heroFadeAnimation.value,
          child: MouseRegion(
            onEnter: (_) {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.05)],
                ),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.8),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Text(
                'Contact us',
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}