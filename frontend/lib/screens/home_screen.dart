import '../widgets/player_name_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../providers/auth_provider.dart';

String? globalPlayerName;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _requirePlayerNameAndNavigate(String route) async {
      if (globalPlayerName == null || globalPlayerName!.isEmpty) {
        final name = await showPlayerNameDialog(context);
        if (name == null || name.isEmpty) return;
        globalPlayerName = name;
      }
      context.go(route);
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF06B6D4).withOpacity(0.4),
                const Color(0xFF0891B2).withOpacity(0.4),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFF06B6D4).withOpacity(0.6),
                width: 2,
              ),
            ),
          ),
        ),
        title: Stack(
          alignment: Alignment.center,
          children: [
            Row(
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
                const Spacer(),
                
                Image.asset(
                  'images/AppBar_Ico_3.jpg',
                  height: 80,
                  errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.image, size: 80, color: Colors.white),
                ),
                const SizedBox(width: 16),
                
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
            Text(
              'CẢNH BÁO CÁC CHIÊU TRÒ LỪA ĐẢO QUA KHÔNG GIAN MẠNG',
              style: GoogleFonts.montserrat(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFFFD60A),
                height: 1.2,
                letterSpacing: 0.5,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A), // Deep blue
              Color(0xFF3B82F6), // Blue
              Color(0xFF8B5CF6), // Purple
              Color(0xFF6B21A8), // Deep purple
            ],
            stops: [0.0, 0.33, 0.66, 1.0],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 3 >= 300 
                      ? MediaQuery.of(context).size.width / 3 
                      : MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildMenuCard(
                        context,
                        'Thi một mình',
                        Icons.person_rounded,
                        Colors.blue,
                        () => _requirePlayerNameAndNavigate('/quiz?mode=single'),
                      ),
                      const SizedBox(height: 20),
                      _buildMenuCard(
                        context,
                        'Tạo cuộc thi',
                        Icons.add_circle_rounded,
                        Colors.green,
                        () => _requirePlayerNameAndNavigate('/create-room'),
                      ),
                      const SizedBox(height: 20),
                      _buildMenuCard(
                        context,
                        'Tham gia cuộc thi',
                        Icons.group_add_rounded,
                        Colors.orange,
                        () => _requirePlayerNameAndNavigate('/join-room'),
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
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    const Color(0xFF06B6D4).withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: _buildCreditSection(context),
            ),
          ],
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

  Widget _buildCreditSection(BuildContext context) {
    return Container(

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Ứng dụng được phát triển bởi:\nCông an Phường An Hội Tây\nChi Đoàn Công An',
                  style: GoogleFonts.montserrat(
                    fontSize: 9,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
