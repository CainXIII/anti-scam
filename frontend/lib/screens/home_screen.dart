import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF667eea).withOpacity(0.3),
                const Color(0xFF764ba2).withOpacity(0.3),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFF5B4EFF).withOpacity(0.5),
                width: 2,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Image.asset(
              'images/AppBar_Ico_1.jpg',
              height: 80,
              errorBuilder: (context, error, stackTrace) => 
                const Icon(Icons.image, size: 80, color: Colors.white),
            ),
            const SizedBox(width: 12),
            
            Image.asset(
              'images/AppBar_Ico_2.jpg',
              height: 80,
              errorBuilder: (context, error, stackTrace) => 
                const Icon(Icons.image, size: 80, color: Colors.white),
            ),
            const SizedBox(width: 16),
            
            // Main text
            Expanded(
              child: Text(
                'CẢNH BÁO CÁC CHIÊU TRÒ LỪA ĐẢO QUA KHÔNG GIAN MẠNG',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            
            Image.asset(
              'images/AppBar_Ico_3.jpg',
              height: 80,
              errorBuilder: (context, error, stackTrace) => 
                const Icon(Icons.image, size: 80, color: Colors.white),
            ),
            const SizedBox(width: 16), 
            
            // Sub text (left aligned)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'CÔNG AN PHƯỜNG AN HỘI TÂY\nCHI ĐOÀN CÔNG AN',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.left,
                maxLines: 2,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF2D55), Color(0xFFFF6B9D)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF2D55).withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.white, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '${authProvider.user?.playAttempts ?? 0}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF5B4EFF), Color(0xFF9D50BB)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5B4EFF).withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        authProvider.logout();
                        context.go('/login');
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F1A), // Dark background
              Color(0xFF1A0033), // Deep purple
              Color(0xFF0F0F1A),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildMenuCard(
                  context,
                  'Quiz Solo',
                  Icons.person_rounded,
                  Colors.blue,
                  () => context.go('/quiz?mode=single'),
                ),
                const SizedBox(height: 20),
                _buildMenuCard(
                  context,
                  'Tạo cuộc thi',
                  Icons.add_circle_rounded,
                  Colors.green,
                  () => context.go('/create-room'),
                ),
                const SizedBox(height: 20),
                _buildMenuCard(
                  context,
                  'Tham gia cuộc thi',
                  Icons.group_add_rounded,
                  Colors.orange,
                  () => context.go('/join-room'),
                ),
                const SizedBox(height: 20),
                _buildMenuCard(
                  context,
                  'Tài liệu tham khảo',
                  Icons.library_books_rounded,
                  Colors.purple,
                  () => context.go('/documents'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    // Gradient colors based on the original color
    final gradientColors = _getGradientColors(color);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(icon, size: 32, color: Colors.white),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors(Color color) {
    if (color == Colors.blue) {
      return [const Color(0xFFFF2D55), const Color(0xFFFF6B9D)];
    } else if (color == Colors.green) {
      return [const Color(0xFF5B4EFF), const Color(0xFF9D50BB)];
    } else if (color == Colors.orange) {
      return [const Color(0xFF00F2FF), const Color(0xFF4FACFE)];
    } else if (color == Colors.purple) {
      return [const Color(0xFFFFD60A), const Color(0xFFFFA500)];
    }
    return [color, color.withOpacity(0.7)];
  }
}
