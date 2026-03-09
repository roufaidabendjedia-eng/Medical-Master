import 'dart:async';

import 'package:flutter/material.dart';

import 'role_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static const _primary = Color(0xFF1AA39A);
  static const _textDark = Color(0xFF0F2A3C);
  static const _textSoft = Color(0xFF6B7B88);

  late final PageController _pageController;
  int _currentIndex = 0;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      title: 'Medics',
      subtitle: 'La santé simplifiée',
      imageUrl: '',
      isSplash: true,
    ),
    _OnboardingPageData(
      title: 'Consultez uniquement avec un médecin de confiance',
      subtitle: 'Choisissez un spécialiste qui vous correspond.',
      imageUrl: 'assets/6e30bb0372fd68401659db9087a05971.jpg',
      isSplash: false,
    ),
    _OnboardingPageData(
      title: 'Trouvez beaucoup de spécialistes au même endroit',
      subtitle: 'Accédez aux meilleurs profils en quelques secondes.',
      imageUrl: 'assets/humberto-chavez-FVh_yqLR9eA-unsplash.jpg',
      isSplash: false,
    ),
    _OnboardingPageData(
      title: 'Connectez-vous à notre consultation en ligne',
      subtitle: 'Discutez avec un médecin en toute sérénité.',
      imageUrl: 'assets/humberto-chavez-FVh_yqLR9eA-unsplash.jpg',
      isSplash: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) {
        return;
      }
      if (_currentIndex == 0) {
        _goNext();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentIndex >= _pages.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RoleScreen()),
      );
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  void _skip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RoleScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                final page = _pages[index];
                if (page.isSplash) {
                  return _buildSplashPage(page);
                }
                return _buildInfoPage(page, index);
              },
            ),
            if (_currentIndex > 0 && _currentIndex < _pages.length)
              Positioned(
                top: 8,
                right: 16,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: _textSoft, fontSize: 14),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSplashPage(_OnboardingPageData page) {
    return GestureDetector(
      onTap: _goNext,
      child: Container(
        color: _primary,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  Icons.health_and_safety,
                  color: _primary,
                  size: 52,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Medics',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Votre santé, notre priorité',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPage(_OnboardingPageData page, int index) {
    final infoIndex = index - 1;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageHeight = (constraints.maxHeight * 0.55).clamp(
            220.0,
            380.0,
          );
          return Column(
            children: [
              SizedBox(
                height: imageHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    color: const Color(0xFFF4F8FB),
                    padding: const EdgeInsets.all(12),
                    child: page.imageUrl.startsWith('assets/')
                        ? Image.asset(page.imageUrl, fit: BoxFit.contain)
                        : Image.network(
                            page.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, _, __) {
                              return Container(
                                color: const Color(0xFFF0F4F7),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image,
                                  color: Color(0xFF9CB5C6),
                                  size: 48,
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      page.title,
                      style: const TextStyle(
                        color: _textDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      page.subtitle,
                      style: const TextStyle(color: _textSoft, height: 1.4),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIndicators(infoIndex),
                        GestureDetector(
                          onTap: _goNext,
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: _primary,
                            ),
                            child: Icon(
                              infoIndex == 2
                                  ? Icons.check
                                  : Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIndicators(int activeIndex) {
    return Row(
      children: List.generate(3, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.only(right: index == 2 ? 0 : 6),
          height: 6,
          width: isActive ? 18 : 6,
          decoration: BoxDecoration(
            color: isActive ? _primary : const Color(0xFFD7E3EA),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.isSplash,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isSplash;
}
