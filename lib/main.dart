import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamid Raza',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF0A0A0A),
      ),
      home: EnverLandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EnverLandingPage extends StatefulWidget {
  @override
  _EnverLandingPageState createState() => _EnverLandingPageState();
}

class _EnverLandingPageState extends State<EnverLandingPage>
    with TickerProviderStateMixin {
  late AnimationController _heroAnimationController;
  late AnimationController _servicesAnimationController;
  late AnimationController _portfolioAnimationController;
  late AnimationController _geometricAnimationController;
  late AnimationController _floatingAnimationController;
  late AnimationController _backgroundAnimationController;

  late Animation<double> _heroFadeAnimation;
  late Animation<Offset> _heroSlideAnimation;
  late Animation<double> _servicesScaleAnimation;
  late Animation<double> _portfolioRotationAnimation;
  late Animation<double> _geometricRotationAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _backgroundAnimation;

  final ScrollController _scrollController = ScrollController();
  bool _isServicesVisible = false;
  bool _isPortfolioVisible = false;

  @override
  void initState() {
    super.initState();

    // Hero animations with professional easing
    _heroAnimationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _heroFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroAnimationController,
        curve: Interval(0.0, 0.8, curve: Curves.easeOutExpo),
      ),
    );

    _heroSlideAnimation =
        Tween<Offset>(begin: Offset(-0.3, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _heroAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Services animations with bounce
    _servicesAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _servicesScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _servicesAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Portfolio animations
    _portfolioAnimationController = AnimationController(
      duration: Duration(milliseconds: 1800),
      vsync: this,
    );

    _portfolioRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _portfolioAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Geometric shapes animations
    _geometricAnimationController = AnimationController(
      duration: Duration(milliseconds: 8000),
      vsync: this,
    );

    _geometricRotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi)
        .animate(
          CurvedAnimation(
            parent: _geometricAnimationController,
            curve: Curves.linear,
          ),
        );

    // Floating animations with smoother curve
    _floatingAnimationController = AnimationController(
      duration: Duration(milliseconds: 6000),
      vsync: this,
    );

    _floatingAnimation = Tween<double>(begin: -15.0, end: 15.0).animate(
      CurvedAnimation(
        parent: _floatingAnimationController,
        curve: Curves.easeInOutSine,
      ),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _floatingAnimationController,
        curve: Curves.easeInOutSine,
      ),
    );

    // Background gradient animation
    _backgroundAnimationController = AnimationController(
      duration: Duration(milliseconds: 10000),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundAnimationController,
        curve: Curves.linear,
      ),
    );

    // Start animations with staggered timing
    Future.delayed(Duration(milliseconds: 300), () {
      _heroAnimationController.forward();
    });

    _geometricAnimationController.repeat();
    _floatingAnimationController.repeat(reverse: true);
    _backgroundAnimationController.repeat(reverse: true);

    // Scroll listener for section animations
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final size = renderBox.size;
      final offset = _scrollController.offset;

      // Services section animation trigger
      if (offset > size.height * 0.4 && !_isServicesVisible) {
        setState(() => _isServicesVisible = true);
        _servicesAnimationController.forward();
      }

      // Portfolio section animation trigger
      if (offset > size.height * 1.0 && !_isPortfolioVisible) {
        setState(() => _isPortfolioVisible = true);
        _portfolioAnimationController.forward();
      }
    }
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _servicesAnimationController.dispose();
    _portfolioAnimationController.dispose();
    _geometricAnimationController.dispose();
    _floatingAnimationController.dispose();
    _backgroundAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.5,
                colors: [
                  Color.lerp(
                    Color(0xFF1a1a2e),
                    Color(0xFF16213e),
                    _backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    Color(0xFF0f3460),
                    Color(0xFF1a1a2e),
                    _backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    Color(0xFF0a0a0a),
                    Color(0xFF0f0f23),
                    _backgroundAnimation.value,
                  )!,
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated background elements
                _buildAnimatedBackgroundElements(),
                // Main content
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      _buildHeader(),
                      _buildHeroSection(),
                      _buildWhySection(),
                      _buildServicesSection(),
                      _buildPortfolioSection(),
                      _buildContactSection(),
                      _buildFooter(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedBackgroundElements() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating gradient orbs
            Positioned(
              top:
                  100 +
                  (50 * math.sin(_backgroundAnimation.value * 2 * math.pi)),
              right:
                  100 +
                  (30 * math.cos(_backgroundAnimation.value * 2 * math.pi)),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.blue.withOpacity(0.1), Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom:
                  200 +
                  (40 * math.cos(_backgroundAnimation.value * 1.5 * math.pi)),
              left:
                  150 +
                  (60 * math.sin(_backgroundAnimation.value * 1.8 * math.pi)),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.purple.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top:
                  300 +
                  (25 * math.sin(_backgroundAnimation.value * 2.5 * math.pi)),
              left:
                  50 +
                  (35 * math.cos(_backgroundAnimation.value * 2.2 * math.pi)),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.cyan.withOpacity(0.06), Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -30 * (1 - _heroFadeAnimation.value)),
          child: Opacity(
            opacity: _heroFadeAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [Colors.blue, Colors.cyan],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.6),
                                    blurRadius: 15 * _pulseAnimation.value,
                                    spreadRadius: 3 * _pulseAnimation.value,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 12),
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
                      SizedBox(width: 25),
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

  Widget _buildAnimatedNavItem(String text, int index) {
    return AnimatedBuilder(
      animation: _heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -40 * (1 - _heroFadeAnimation.value)),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400 + (index * 150)),
            opacity: _heroFadeAnimation.value,
            child: MouseRegion(
              onEnter: (_) {},
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      animation: _heroFadeAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _heroFadeAnimation.value,
          child: MouseRegion(
            onEnter: (_) {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.1),
                    Colors.blue.withOpacity(0.05),
                  ],
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
                    offset: Offset(0, 8),
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

  Widget _buildHeroSection() {
    return Container(
      padding: EdgeInsets.all(50),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SlideTransition(
              position: _heroSlideAnimation,
              child: FadeTransition(
                opacity: _heroFadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimatedText(),
                    SizedBox(height: 25),
                    _buildAnimatedDescription(),
                    SizedBox(height: 40),
                    _buildAnimatedServiceButton(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: _buildAnimatedHeroImage()),
        ],
      ),
    );
  }

  Widget _buildAnimatedText() {
    return AnimatedBuilder(
      animation: _heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-50 * (1 - _heroFadeAnimation.value), 0),
          child: Opacity(
            opacity: _heroFadeAnimation.value,
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.white, Colors.blue[200]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'Build Your\nAwesome\nPlatform',
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.1,
                  letterSpacing: -0.5,
                  shadows: [
                    Shadow(
                      color: Colors.blue.withOpacity(0.3),
                      offset: Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedDescription() {
    return AnimatedBuilder(
      animation: _heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - _heroFadeAnimation.value), 0),
          child: Opacity(
            opacity: _heroFadeAnimation.value * 0.9,
            child: Text(
              'Hamid Raza studio is a digital studio that offers several services\nsuch as UI/UX Design to developers, we will provide the best\nservice for those of you who use our services.',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 17,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedServiceButton() {
    return AnimatedBuilder(
      animation: _heroFadeAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _heroFadeAnimation.value,
          child: MouseRegion(
            onEnter: (_) {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 40,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
              child: Text(
                'Our Services',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedHeroImage() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Enhanced floating shapes
              _buildFloatingShape(
                top: 60,
                left: -30,
                child: AnimatedBuilder(
                  animation: _geometricRotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _geometricRotationAnimation.value,
                      child: Container(
                        width: 80,
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.cyan],
                          ),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildFloatingShape(
                bottom: 120,
                left: 60,
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [Colors.white, Colors.blue[100]!],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.blue[800],
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Enhanced main image
              AnimatedBuilder(
                animation: _heroFadeAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _heroFadeAnimation.value,
                    child: Container(
                      width: 280,
                      height: 350,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange[400]!, Colors.orange[600]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 40,
                            offset: Offset(0, 20),
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 30,
                            offset: Offset(0, -15),
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Icon(
                                Icons.person,
                                size: 120,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingShape({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child2) {
        return Positioned(
          top: top != null ? top + (_floatingAnimation.value * 0.4) : null,
          bottom: bottom != null
              ? bottom + (_floatingAnimation.value * 0.3)
              : null,
          left: left != null ? left + (_floatingAnimation.value * 0.2) : null,
          right: right != null
              ? right + (_floatingAnimation.value * 0.25)
              : null,
          child: child,
        );
      },
    );
  }

  Widget _buildWhySection() {
    return AnimatedBuilder(
      animation: _heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 60 * (1 - _heroFadeAnimation.value)),
          child: Opacity(
            opacity: _heroFadeAnimation.value,
            child: Container(
              padding: EdgeInsets.all(50),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Colors.white, Colors.blue[200]!],
                          ).createShader(bounds),
                          child: Text(
                            'Why Hamid Raza Is The\nBest Choice?',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Watch this one minute video so you understand why you should\nuse our services!',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 17,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: _buildAnimatedVideoSection()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedVideoSection() {
    return MouseRegion(
      onEnter: (_) {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Colors.grey[900]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 30,
                  offset: Offset(0, 15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey[700]!, Colors.grey[800]!],
                  ),
                ),
                child: Center(
                  child: Icon(Icons.groups, size: 100, color: Colors.grey[500]),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue[700]!],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.6),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 40),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return AnimatedBuilder(
      animation: _servicesScaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * _servicesScaleAnimation.value),
          child: Opacity(
            opacity: _servicesScaleAnimation.value,
            child: Container(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _geometricRotationAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _geometricRotationAnimation.value * 0.3,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.white, Colors.blue[100]!],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.blue[800],
                                    size: 20,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 20),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [Colors.white, Colors.blue[200]!],
                            ).createShader(bounds),
                            child: Text(
                              'The Service We Provide\nFor You',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    children: [
                      _buildAnimatedServiceCard(
                        Icons.code,
                        'Development',
                        'Create a platform with the best\nand coolest quality from us.',
                        Colors.purple,
                        0,
                      ),
                      _buildAnimatedServiceCard(
                        Icons.palette,
                        'UI/UX Designer',
                        'We provide UI/UX Design services,\nand of course with the best quality',
                        Colors.red,
                        1,
                      ),
                      _buildAnimatedServiceCard(
                        Icons.design_services,
                        'Graphic Designer',
                        'We provide Graphic Design\nservices, with the best designers',
                        Colors.yellow,
                        2,
                      ),
                      _buildAnimatedServiceCard(
                        Icons.movie,
                        'Motion Graphic',
                        'Create a platform with the best\nand coolest quality from us.',
                        Colors.green,
                        3,
                      ),
                      _buildAnimatedServiceCard(
                        Icons.camera_alt,
                        'Photography',
                        'We provide Photography services,\nand of course with the best quality',
                        Colors.purple,
                        4,
                      ),
                      _buildAnimatedServiceCard(
                        Icons.videocam,
                        'Videography',
                        'Create a platform with the best\nand coolest quality from us.',
                        Colors.red,
                        5,
                      ),
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

  Widget _buildAnimatedServiceCard(
    IconData icon,
    String title,
    String description,
    Color color,
    int index,
  ) {
    return AnimatedBuilder(
      animation: _servicesScaleAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            50 *
                (1 - _servicesScaleAnimation.value) *
                (index % 2 == 0 ? 1 : -1),
          ),
          child: MouseRegion(
            onEnter: (_) {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[800]!),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                    animation: _floatingAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatingAnimation.value * 0.1),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(icon, color: color, size: 24),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPortfolioSection() {
    return AnimatedBuilder(
      animation: _portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 100 * (1 - _portfolioRotationAnimation.value)),
          child: Opacity(
            opacity: _portfolioRotationAnimation.value,
            child: Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Our Awesome Portofolio',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _geometricRotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _geometricRotationAnimation.value,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]!),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAnimatedPortfolioItem(200, 250, 0),
                      _buildAnimatedPortfolioItem(180, 220, 1),
                      _buildAnimatedPortfolioItem(200, 280, 2),
                    ],
                  ),
                  SizedBox(height: 40),
                  _buildAnimatedProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedPortfolioItem(double width, double height, int index) {
    return AnimatedBuilder(
      animation: _portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            30 *
                (1 - _portfolioRotationAnimation.value) *
                (index % 2 == 0 ? 1 : -1),
            0,
          ),
          child: Transform.scale(
            scale: 0.8 + (0.2 * _portfolioRotationAnimation.value),
            child: MouseRegion(
              onEnter: (_) {},
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _floatingAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatingAnimation.value * 0.2),
                        child: Icon(
                          Icons.web,
                          color: Colors.grey[600],
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedProgressIndicator() {
    return AnimatedBuilder(
      animation: _portfolioRotationAnimation,
      builder: (context, child) {
        return Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              width: 60 * _portfolioRotationAnimation.value,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 10),
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value * 0.8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactSection() {
    return AnimatedBuilder(
      animation: _portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _portfolioRotationAnimation.value)),
          child: Opacity(
            opacity: _portfolioRotationAnimation.value,
            child: Container(
              padding: EdgeInsets.all(40),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact us for the service\nyou want to use',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: MouseRegion(
                          onEnter: (_) {},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Text(
                              'Contact us',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return AnimatedBuilder(
      animation: _portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _portfolioRotationAnimation.value)),
          child: Opacity(
            opacity: _portfolioRotationAnimation.value,
            child: Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.5),
                                        blurRadius: 10 * _pulseAnimation.value,
                                        spreadRadius: 2 * _pulseAnimation.value,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Hamid Raza',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildAnimatedFooterLink('Support', 0),
                          SizedBox(width: 30),
                          _buildAnimatedFooterLink('Privacy Policy', 1),
                          SizedBox(width: 30),
                          _buildAnimatedFooterLink('Terms and Conditions', 2),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 800),
                    height: 1,
                    color: Colors.grey[800],
                    margin: EdgeInsets.symmetric(
                      horizontal: 100 * (1 - _portfolioRotationAnimation.value),
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _floatingAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatingAnimation.value * 0.1),
                        child: Text(
                          '© 2023 Hamid Raza, All Rights Reserved',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedFooterLink(String text, int index) {
    return AnimatedBuilder(
      animation: _portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            20 *
                (1 - _portfolioRotationAnimation.value) *
                (index % 2 == 0 ? 1 : -1),
            0,
          ),
          child: MouseRegion(
            onEnter: (_) {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Text(text, style: TextStyle(color: Colors.grey[400])),
            ),
          ),
        );
      },
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'core/app_bindings.dart';
// import 'core/theme/app_theme.dart';
// import 'models/home/views/home_view.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Hamid Raza',
//       debugShowCheckedModeBanner: false,
//       initialBinding: AppBindings(),
//       theme: AppTheme.darkTheme,
//       home: const HomeView(),
//     );
//   }
// }