//
// // ─── Theme ────────────────────────────────────────────────────────────────────
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
// class AppTheme {
//   static const Color primaryBlue = Color(0xFF1565C0);
//   static const Color accentBlue = Color(0xFF42A5F5);
//   static const Color deepBlue = Color(0xFF0D47A1);
//   static const Color lightBlue = Color(0xFFE3F2FD);
//
//   static ThemeData light() => ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: primaryBlue,
//       brightness: Brightness.light,
//       primary: primaryBlue,
//       secondary: accentBlue,
//       surface: const Color(0xFFF8FBFF),
//     ),
//     fontFamily: 'Poppins',
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFFF8FBFF),
//       elevation: 0,
//       foregroundColor: deepBlue,
//       systemOverlayStyle: SystemUiOverlayStyle.dark,
//     ),
//     scaffoldBackgroundColor: const Color(0xFFF8FBFF),
//     cardTheme: CardThemeData(
//       elevation: 0,
//       shape:
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       color: Colors.white,
//     ),
//   );
//
//   static ThemeData dark() => ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: primaryBlue,
//       brightness: Brightness.dark,
//       primary: accentBlue,
//       secondary: const Color(0xFF90CAF9),
//       surface: const Color(0xFF0A1628),
//     ),
//     fontFamily: 'Poppins',
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFF0A1628),
//       elevation: 0,
//       foregroundColor: Color(0xFF90CAF9),
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//     ),
//     scaffoldBackgroundColor: const Color(0xFF0A1628),
//     cardTheme: CardThemeData(
//       elevation: 0,
//       shape:
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       color: const Color(0xFF0F2137),
//     ),
//   );
// }
//
// // ─── Root App ─────────────────────────────────────────────────────────────────
//
// class HealthProApp extends StatefulWidget {
//   const HealthProApp({super.key});
//   @override
//   State<HealthProApp> createState() => _HealthProAppState();
// }
//
// class _HealthProAppState extends State<HealthProApp> {
//   ThemeMode _themeMode = ThemeMode.light;
//
//   void _toggleTheme() =>
//       setState(() => _themeMode = _themeMode == ThemeMode.light
//           ? ThemeMode.dark
//           : ThemeMode.light);
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     title: 'HealthPro',
//     debugShowCheckedModeBanner: false,
//     theme: AppTheme.light(),
//     darkTheme: AppTheme.dark(),
//     themeMode: _themeMode,
//     home: MainShell(onToggleTheme: _toggleTheme, themeMode: _themeMode),
//   );
// }
//
// // ─── Main Shell (Bottom Nav) ──────────────────────────────────────────────────
//
// class MainShell extends StatefulWidget {
//   final VoidCallback onToggleTheme;
//   final ThemeMode themeMode;
//   const MainShell(
//       {super.key, required this.onToggleTheme, required this.themeMode});
//   @override
//   State<MainShell> createState() => _MainShellState();
// }
//
// class _MainShellState extends State<MainShell>
//     with SingleTickerProviderStateMixin {
//   int _currentIndex = 0;
//   late AnimationController _fabController;
//   late Animation<double> _fabAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _fabController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 400));
//     _fabAnim = CurvedAnimation(parent: _fabController, curve: Curves.elasticOut);
//     _fabController.forward();
//   }
//
//   @override
//   void dispose() {
//     _fabController.dispose();
//     super.dispose();
//   }
//
//   void _onNavTap(int i) {
//     if (i == _currentIndex) return;
//     setState(() => _currentIndex = i);
//     if (i == 0) {
//       _fabController.reset();
//       _fabController.forward();
//     }
//   }
//
//   List<Widget> get _pages => [
//     HomePage(
//         onToggleTheme: widget.onToggleTheme,
//         themeMode: widget.themeMode),
//     ProfessionalsPage(
//         onChatStart: (prof) {
//           setState(() => _currentIndex = 2);
//
//           print(prof);
//         }),
//     const ChatListPage(),
//     const ProfilePage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 300),
//         transitionBuilder: (child, anim) =>
//             FadeTransition(opacity: anim, child: child),
//         child: KeyedSubtree(key: ValueKey(_currentIndex), child: _pages[_currentIndex]),
//       ),
//       floatingActionButton: _currentIndex == 0
//           ? ScaleTransition(
//         scale: _fabAnim,
//         child: FloatingActionButton.extended(
//           onPressed: () => setState(() => _currentIndex = 1),
//           backgroundColor: cs.primary,
//           foregroundColor: Colors.white,
//           icon: const Icon(Icons.chat_bubble_outline_rounded),
//           label: const Text('Start Chat',
//               style: TextStyle(fontWeight: FontWeight.w600)),
//           elevation: 6,
//         ),
//       )
//           : null,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: _BottomNav(
//           currentIndex: _currentIndex,
//           onTap: _onNavTap,
//           isDark: isDark,
//           cs: cs),
//     );
//   }
// }
//
// // ─── Bottom Nav ───────────────────────────────────────────────────────────────
//
// class _BottomNav extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//   final bool isDark;
//   final ColorScheme cs;
//   const _BottomNav(
//       {required this.currentIndex,
//         required this.onTap,
//         required this.isDark,
//         required this.cs});
//
//   @override
//   Widget build(BuildContext context) {
//     final bg = isDark ? const Color(0xFF0F2137) : Colors.white;
//     final items = [
//       (Icons.home_rounded, Icons.home_outlined, 'Home'),
//       (Icons.people_rounded, Icons.people_outline_rounded, 'Professionals'),
//       (Icons.chat_rounded, Icons.chat_outlined, 'Chats'),
//       (Icons.person_rounded, Icons.person_outline_rounded, 'Profile'),
//     ];
//
//     return Container(
//       decoration: BoxDecoration(
//         color: bg,
//         boxShadow: [
//           BoxShadow(
//               color: cs.primary.withOpacity(0.08),
//               blurRadius: 20,
//               offset: const Offset(0, -4))
//         ],
//       ),
//       child: SafeArea(
//         child: SizedBox(
//           height: 64,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(items.length, (i) {
//               final selected = i == currentIndex;
//               return GestureDetector(
//                 onTap: () => onTap(i),
//                 behavior: HitTestBehavior.opaque,
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 250),
//                   curve: Curves.easeInOut,
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: selected
//                         ? cs.primary.withOpacity(0.12)
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 250),
//                         child: Icon(
//                           selected ? items[i].$1 : items[i].$2,
//                           key: ValueKey(selected),
//                           color: selected ? cs.primary : cs.onSurface.withOpacity(0.45),
//                           size: 24,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         items[i].$3,
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
//                           color: selected ? cs.primary : cs.onSurface.withOpacity(0.45),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─── Sample Data ──────────────────────────────────────────────────────────────
//
// final List<Map<String, dynamic>> kPosts = [
//   {
//     'id': '1',
//     'author': 'Dr. Adaeze Okafor',
//     'specialty': 'Cardiologist',
//     'avatar': 'AO',
//     'avatarColor': Color(0xFF1565C0),
//     'time': '2h ago',
//     'type': 'text',
//     'content':
//     '🫀 Heart health tip: Did you know that 30 minutes of moderate exercise 5 days a week can reduce your risk of cardiovascular disease by up to 35%? Start small — even a brisk walk counts! Remember, your heart is the engine of your body. Take care of it. #HeartHealth #Prevention',
//     'likes': 248,
//     'comments': 34,
//     'shares': 17,
//     'liked': false,
//   },
//   {
//     'id': '2',
//     'author': 'Dr. Emeka Nwosu',
//     'specialty': 'Nutritionist',
//     'avatar': 'EN',
//     'avatarColor': Color(0xFF0288D1),
//     'time': '4h ago',
//     'type': 'image',
//     'imageLabel': '🥗 Balanced Plate',
//     'content':
//     'A balanced diet doesn\'t have to be complicated. This simple visual guide shows you exactly how to portion your plate for optimal nutrition. Protein, complex carbs, healthy fats, and lots of vegetables! Save this for your next meal prep.',
//     'likes': 512,
//     'comments': 89,
//     'shares': 203,
//     'liked': true,
//   },
//   {
//     'id': '3',
//     'author': 'Dr. Ngozi Adeleke',
//     'specialty': 'Psychiatrist',
//     'avatar': 'NA',
//     'avatarColor': Color(0xFF0097A7),
//     'time': '6h ago',
//     'type': 'video',
//     'videoLabel': '▶ Mental Health Awareness — 5 min',
//     'content':
//     'Mental health is just as important as physical health. In this short video, I walk you through 3 evidence-based breathing techniques that can reduce anxiety within minutes. Practice these daily for best results. 🧠💙',
//     'likes': 1203,
//     'comments': 156,
//     'shares': 445,
//     'liked': false,
//   },
//   {
//     'id': '4',
//     'author': 'Dr. Tunde Fashola',
//     'specialty': 'Pediatrician',
//     'avatar': 'TF',
//     'avatarColor': Color(0xFF1976D2),
//     'time': '1d ago',
//     'type': 'text',
//     'content':
//     '👶 Vaccination reminder for parents: The first year of a child\'s life is critical for immunization. Staying on schedule with vaccines protects not just your child, but the entire community through herd immunity. Talk to your pediatrician today if you have questions!',
//     'likes': 874,
//     'comments': 67,
//     'shares': 312,
//     'liked': false,
//   },
// ];
//
// final List<Map<String, dynamic>> kProfessionals = [
//   {
//     'name': 'Dr. Adaeze Okafor',
//     'specialty': 'Cardiologist',
//     'hospital': 'Lagos University Teaching Hospital',
//     'avatar': 'AO',
//     'avatarColor': Color(0xFF1565C0),
//     'rating': 4.9,
//     'reviews': 128,
//     'available': true,
//     'experience': '12 years',
//   },
//   {
//     'name': 'Dr. Emeka Nwosu',
//     'specialty': 'Nutritionist & Dietitian',
//     'hospital': 'HealthBridge Clinic, Abuja',
//     'avatar': 'EN',
//     'avatarColor': Color(0xFF0288D1),
//     'rating': 4.7,
//     'reviews': 95,
//     'available': true,
//     'experience': '8 years',
//   },
//   {
//     'name': 'Dr. Ngozi Adeleke',
//     'specialty': 'Psychiatrist',
//     'hospital': 'MindCare Centre, Ibadan',
//     'avatar': 'NA',
//     'avatarColor': Color(0xFF0097A7),
//     'rating': 4.8,
//     'reviews': 210,
//     'available': false,
//     'experience': '15 years',
//   },
//   {
//     'name': 'Dr. Tunde Fashola',
//     'specialty': 'Pediatrician',
//     'hospital': 'Children\'s Health Institute',
//     'avatar': 'TF',
//     'avatarColor': Color(0xFF1976D2),
//     'rating': 4.6,
//     'reviews': 184,
//     'available': true,
//     'experience': '10 years',
//   },
//   {
//     'name': 'Dr. Amara Obi',
//     'specialty': 'Dermatologist',
//     'hospital': 'SkinCare Plus, Enugu',
//     'avatar': 'AO',
//     'avatarColor': Color(0xFF00838F),
//     'rating': 4.5,
//     'reviews': 77,
//     'available': true,
//     'experience': '6 years',
//   },
// ];
//
// final List<Map<String, dynamic>> kChats = [
//   {
//     'name': 'Dr. Adaeze Okafor',
//     'specialty': 'Cardiologist',
//     'avatar': 'AO',
//     'avatarColor': Color(0xFF1565C0),
//     'lastMessage': 'Your ECG results look great! Keep up the lifestyle changes.',
//     'time': '10:24 AM',
//     'unread': 2,
//     'online': true,
//   },
//   {
//     'name': 'Dr. Emeka Nwosu',
//     'specialty': 'Nutritionist',
//     'avatar': 'EN',
//     'avatarColor': Color(0xFF0288D1),
//     'lastMessage': 'I\'ve sent you the meal plan PDF. Let me know if you have questions!',
//     'time': 'Yesterday',
//     'unread': 0,
//     'online': false,
//   },
// ];
//
// // ─── HOME PAGE ─────────────────────────────────────────────────────────────────
//
// class HomePage extends StatefulWidget {
//   final VoidCallback onToggleTheme;
//   final ThemeMode themeMode;
//   const HomePage(
//       {super.key, required this.onToggleTheme, required this.themeMode});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _headerAnim;
//   final List<Map<String, dynamic>> _posts =
//   kPosts.map((p) => Map<String, dynamic>.from(p)).toList();
//
//   @override
//   void initState() {
//     super.initState();
//     _headerAnim = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 800));
//     _headerAnim.forward();
//   }
//
//   @override
//   void dispose() {
//     _headerAnim.dispose();
//     super.dispose();
//   }
//
//   void _toggleLike(int index) {
//     setState(() {
//       final post = _posts[index];
//       post['liked'] = !post['liked'];
//       post['likes'] =
//       post['liked'] ? post['likes'] + 1 : post['likes'] - 1;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             floating: true,
//             snap: true,
//             backgroundColor: isDark ? const Color(0xFF0A1628) : const Color(0xFFF8FBFF),
//             title: SlideTransition(
//               position: Tween<Offset>(
//                   begin: const Offset(-0.3, 0), end: Offset.zero)
//                   .animate(CurvedAnimation(
//                   parent: _headerAnim, curve: Curves.easeOut)),
//               child: FadeTransition(
//                 opacity: _headerAnim,
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 36,
//                       height: 36,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [cs.primary, cs.secondary],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(Icons.health_and_safety_rounded,
//                           color: Colors.white, size: 20),
//                     ),
//                     const SizedBox(width: 10),
//                     Text('HealthPro',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 22,
//                           color: cs.primary,
//                           letterSpacing: -0.5,
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(
//                   widget.themeMode == ThemeMode.dark
//                       ? Icons.light_mode_rounded
//                       : Icons.dark_mode_rounded,
//                   color: cs.primary,
//                 ),
//                 onPressed: widget.onToggleTheme,
//               ),
//               IconButton(
//                 icon: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Icon(Icons.notifications_outlined, color: cs.primary),
//                     Positioned(
//                       right: -2,
//                       top: -2,
//                       child: Container(
//                         width: 9,
//                         height: 9,
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                               color: isDark
//                                   ? const Color(0xFF0A1628)
//                                   : const Color(0xFFF8FBFF),
//                               width: 1.5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 onPressed: () {},
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: _StoriesRow(cs: cs, isDark: isDark),
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate(
//                     (ctx, i) => _PostCard(
//                   post: _posts[i],
//                   onLike: () => _toggleLike(i),
//                   index: i,
//                 ),
//                 childCount: _posts.length,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─── Stories Row ──────────────────────────────────────────────────────────────
//
// class _StoriesRow extends StatelessWidget {
//   final ColorScheme cs;
//   final bool isDark;
//   const _StoriesRow({required this.cs, required this.isDark});
//
//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       ('Your Story', Icons.add, cs.primary),
//       ...kProfessionals.take(4).map((p) => (p['name'] as String, null, p['avatarColor'] as Color)),
//     ];
//
//     return SizedBox(
//       height: 90,
//       child: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         scrollDirection: Axis.horizontal,
//         itemCount: items.length,
//         itemBuilder: (ctx, i) {
//           final item = items[i];
//           final isFirst = i == 0;
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//             child: Column(
//               children: [
//                 Container(
//                   width: 52,
//                   height: 52,
//                   decoration: BoxDecoration(
//                     gradient: isFirst
//                         ? null
//                         : LinearGradient(
//                         colors: [cs.primary, cs.secondary],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight),
//                     color: isFirst
//                         ? (isDark ? const Color(0xFF1A2F4A) : const Color(0xFFE3F2FD))
//                         : null,
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                         color: isFirst ? cs.primary : Colors.transparent,
//                         width: 2),
//                   ),
//                   child: isFirst
//                       ? Icon(Icons.add_rounded, color: cs.primary, size: 26)
//                       : Center(
//                     child: Text(
//                       kProfessionals[i - 1]['avatar'] as String,
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   isFirst ? 'Your Story' : (item.$1.split(' ')[0] + ' ' + (item.$1.split(' ').length > 1 ? item.$1.split(' ').last : '')),
//                   style: TextStyle(
//                       fontSize: 9,
//                       color: cs.onSurface.withOpacity(0.6),
//                       fontWeight: FontWeight.w500),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// // ─── Post Card ────────────────────────────────────────────────────────────────
//
// class _PostCard extends StatefulWidget {
//   final Map<String, dynamic> post;
//   final VoidCallback onLike;
//   final int index;
//   const _PostCard(
//       {required this.post, required this.onLike, required this.index});
//   @override
//   State<_PostCard> createState() => _PostCardState();
// }
//
// class _PostCardState extends State<_PostCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _likeAnim;
//   late Animation<double> _likeScale;
//
//   @override
//   void initState() {
//     super.initState();
//     _likeAnim = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 300));
//     _likeScale =
//         TweenSequence([
//           TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
//           TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
//         ]).animate(CurvedAnimation(parent: _likeAnim, curve: Curves.easeInOut));
//   }
//
//   @override
//   void dispose() {
//     _likeAnim.dispose();
//     super.dispose();
//   }
//
//   void _handleLike() {
//     _likeAnim.forward(from: 0);
//     widget.onLike();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final post = widget.post;
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return AnimatedCard(
//       index: widget.index,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           color: isDark ? const Color(0xFF0F2137) : Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//                 color: cs.primary.withOpacity(0.06),
//                 blurRadius: 16,
//                 offset: const Offset(0, 4)),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//               child: Row(
//                 children: [
//                   _Avatar(
//                       text: post['avatar'] as String,
//                       color: post['avatarColor'] as Color,
//                       size: 44),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(post['author'] as String,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 14,
//                                 color: cs.onSurface)),
//                         Text(
//                             '${post['specialty']}  ·  ${post['time']}',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: cs.onSurface.withOpacity(0.5))),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: cs.primary.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text('Follow',
//                         style: TextStyle(
//                             color: cs.primary,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12)),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Media
//             if (post['type'] == 'image')
//               _ImagePost(label: post['imageLabel'] as String, cs: cs),
//             if (post['type'] == 'video')
//               _VideoPost(label: post['videoLabel'] as String, cs: cs),
//
//             // Text
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
//               child: Text(post['content'] as String,
//                   style: TextStyle(
//                       fontSize: 14,
//                       height: 1.55,
//                       color: cs.onSurface.withOpacity(0.85))),
//             ),
//
//             // Divider
//             Divider(
//                 height: 20,
//                 thickness: 0.5,
//                 indent: 16,
//                 endIndent: 16,
//                 color: cs.onSurface.withOpacity(0.08)),
//
//             // Actions
//             Padding(
//               padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
//               child: Row(
//                 children: [
//                   _ActionBtn(
//                     icon: post['liked'] == true
//                         ? Icons.favorite_rounded
//                         : Icons.favorite_border_rounded,
//                     label: _formatCount(post['likes'] as int),
//                     color: post['liked'] == true ? Colors.red : cs.onSurface.withOpacity(0.5),
//                     onTap: _handleLike,
//                     scaleAnim: _likeScale,
//                   ),
//                   _ActionBtn(
//                     icon: Icons.chat_bubble_outline_rounded,
//                     label: _formatCount(post['comments'] as int),
//                     color: cs.onSurface.withOpacity(0.5),
//                     onTap: () => _showComments(context, post, cs, isDark),
//                   ),
//                   _ActionBtn(
//                     icon: Icons.repeat_rounded,
//                     label: _formatCount(post['shares'] as int),
//                     color: cs.onSurface.withOpacity(0.5),
//                     onTap: () {},
//                   ),
//                   const Spacer(),
//                   _ActionBtn(
//                     icon: Icons.bookmark_border_rounded,
//                     label: '',
//                     color: cs.onSurface.withOpacity(0.5),
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _formatCount(int n) {
//     if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
//     return n.toString();
//   }
//
//   void _showComments(BuildContext context, Map<String, dynamic> post,
//       ColorScheme cs, bool isDark) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => _CommentsSheet(post: post, cs: cs, isDark: isDark),
//     );
//   }
// }
//
// // ─── Action Button ────────────────────────────────────────────────────────────
//
// class _ActionBtn extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback onTap;
//   final Animation<double>? scaleAnim;
//   const _ActionBtn(
//       {required this.icon,
//         required this.label,
//         required this.color,
//         required this.onTap,
//         this.scaleAnim});
//
//   @override
//   Widget build(BuildContext context) {
//     Widget iconWidget = Icon(icon, color: color, size: 20);
//     if (scaleAnim != null) {
//       iconWidget = ScaleTransition(scale: scaleAnim!, child: iconWidget);
//     }
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         child: Row(
//           children: [
//             iconWidget,
//             if (label.isNotEmpty) ...[
//               const SizedBox(width: 4),
//               Text(label,
//                   style: TextStyle(
//                       color: color, fontWeight: FontWeight.w600, fontSize: 13)),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─── Image Post ───────────────────────────────────────────────────────────────
//
// class _ImagePost extends StatelessWidget {
//   final String label;
//   final ColorScheme cs;
//   const _ImagePost({required this.label, required this.cs});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 220,
//       margin: const EdgeInsets.symmetric(horizontal: 0),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             cs.primary.withOpacity(0.8),
//             cs.secondary.withOpacity(0.9),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Decorative circles
//           Positioned(
//             right: -30,
//             top: -30,
//             child: Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.08),
//               ),
//             ),
//           ),
//           Positioned(
//             left: -20,
//             bottom: -20,
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.06),
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.image_rounded, color: Colors.white, size: 48),
//                 const SizedBox(height: 10),
//                 Text(label,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─── Video Post ───────────────────────────────────────────────────────────────
//
// class _VideoPost extends StatelessWidget {
//   final String label;
//   final ColorScheme cs;
//   const _VideoPost({required this.label, required this.cs});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 220,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color(0xFF0D47A1).withOpacity(0.9),
//             const Color(0xFF0097A7).withOpacity(0.9),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: -40,
//             bottom: -40,
//             child: Container(
//               width: 160,
//               height: 160,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.07),
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.play_arrow_rounded,
//                       color: Colors.white, size: 36),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(label,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─── Comments Sheet ───────────────────────────────────────────────────────────
//
// class _CommentsSheet extends StatefulWidget {
//   final Map<String, dynamic> post;
//   final ColorScheme cs;
//   final bool isDark;
//   const _CommentsSheet(
//       {required this.post, required this.cs, required this.isDark});
//   @override
//   State<_CommentsSheet> createState() => _CommentsSheetState();
// }
//
// class _CommentsSheetState extends State<_CommentsSheet> {
//   final _comments = [
//     {'user': 'Amara O.', 'text': 'This is so helpful! Thank you Doc 🙏', 'time': '1h ago'},
//     {'user': 'Bode A.', 'text': 'I shared this with my family. Great advice!', 'time': '45m ago'},
//     {'user': 'Chioma N.', 'text': 'Can you do a post about managing stress too?', 'time': '20m ago'},
//   ];
//   final _ctrl = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = widget.cs;
//     final isDark = widget.isDark;
//     return DraggableScrollableSheet(
//       initialChildSize: 0.6,
//       maxChildSize: 0.92,
//       minChildSize: 0.35,
//       builder: (_, scrollCtrl) => Container(
//         decoration: BoxDecoration(
//           color: isDark ? const Color(0xFF0F2137) : Colors.white,
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
//         ),
//         child: Column(
//           children: [
//             const SizedBox(height: 12),
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: cs.onSurface.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text('Comments (${_comments.length})',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                       color: cs.onSurface)),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 controller: scrollCtrl,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 itemCount: _comments.length,
//                 itemBuilder: (_, i) => Padding(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CircleAvatar(
//                         radius: 18,
//                         backgroundColor: cs.primary.withOpacity(0.15),
//                         child: Text(
//                             _comments[i]['user']!.substring(0, 1),
//                             style:
//                             TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(_comments[i]['user']!,
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.w700, fontSize: 13)),
//                                 const SizedBox(width: 8),
//                                 Text(_comments[i]['time']!,
//                                     style: TextStyle(
//                                         fontSize: 11,
//                                         color: cs.onSurface.withOpacity(0.45))),
//                               ],
//                             ),
//                             const SizedBox(height: 4),
//                             Text(_comments[i]['text']!,
//                                 style: TextStyle(
//                                     fontSize: 13,
//                                     color: cs.onSurface.withOpacity(0.8))),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   left: 16,
//                   right: 16,
//                   bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//                   top: 8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _ctrl,
//                       decoration: InputDecoration(
//                         hintText: 'Write a comment…',
//                         hintStyle: TextStyle(
//                             color: cs.onSurface.withOpacity(0.4), fontSize: 14),
//                         filled: true,
//                         fillColor: isDark
//                             ? cs.onSurface.withOpacity(0.08)
//                             : cs.primary.withOpacity(0.06),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide.none),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   CircleAvatar(
//                     radius: 24,
//                     backgroundColor: cs.primary,
//                     child: IconButton(
//                       icon: const Icon(Icons.send_rounded,
//                           color: Colors.white, size: 18),
//                       onPressed: () {
//                         if (_ctrl.text.trim().isNotEmpty) {
//                           setState(() {
//                             _comments.add({
//                               'user': 'You',
//                               'text': _ctrl.text.trim(),
//                               'time': 'now',
//                             });
//                             _ctrl.clear();
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─── PROFESSIONALS PAGE ────────────────────────────────────────────────────────
//
// class ProfessionalsPage extends StatefulWidget {
//   final Function(Map<String, dynamic>) onChatStart;
//   const ProfessionalsPage({super.key, required this.onChatStart});
//   @override
//   State<ProfessionalsPage> createState() => _ProfessionalsPageState();
// }
//
// class _ProfessionalsPageState extends State<ProfessionalsPage> {
//   String _search = '';
//   String _filter = 'All';
//   final _filters = ['All', 'Cardiologist', 'Nutritionist', 'Psychiatrist', 'Pediatrician', 'Dermatologist'];
//
//   List<Map<String, dynamic>> get _filtered => kProfessionals.where((p) {
//     final matchSearch = p['name'].toString().toLowerCase().contains(_search.toLowerCase()) ||
//         p['specialty'].toString().toLowerCase().contains(_search.toLowerCase());
//     final matchFilter = _filter == 'All' ||
//         p['specialty'].toString().contains(_filter);
//     return matchSearch && matchFilter;
//   }).toList();
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Professionals',
//             style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 22,
//                 color: cs.primary)),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(110),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
//                 child: TextField(
//                   onChanged: (v) => setState(() => _search = v),
//                   decoration: InputDecoration(
//                     hintText: 'Search doctors, specialties…',
//                     prefixIcon: Icon(Icons.search_rounded, color: cs.primary),
//                     filled: true,
//                     fillColor:
//                     isDark ? cs.onSurface.withOpacity(0.06) : cs.primary.withOpacity(0.06),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide.none),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _filters.length,
//                   itemBuilder: (_, i) {
//                     final selected = _filters[i] == _filter;
//                     return GestureDetector(
//                       onTap: () => setState(() => _filter = _filters[i]),
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         margin: const EdgeInsets.symmetric(horizontal: 4),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: selected ? cs.primary : Colors.transparent,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                               color: selected
//                                   ? cs.primary
//                                   : cs.onSurface.withOpacity(0.2)),
//                         ),
//                         child: Text(_filters[i],
//                             style: TextStyle(
//                                 color: selected
//                                     ? Colors.white
//                                     : cs.onSurface.withOpacity(0.6),
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12)),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
//         itemCount: _filtered.length,
//         itemBuilder: (ctx, i) => AnimatedCard(
//           index: i,
//           child: _ProfessionalCard(
//             prof: _filtered[i],
//             onChat: () => widget.onChatStart(_filtered[i]),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _ProfessionalCard extends StatelessWidget {
//   final Map<String, dynamic> prof;
//   final VoidCallback onChat;
//   const _ProfessionalCard({required this.prof, required this.onChat});
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF0F2137) : Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: cs.primary.withOpacity(0.06),
//               blurRadius: 16,
//               offset: const Offset(0, 4)),
//         ],
//       ),
//       child: Row(
//         children: [
//           Stack(
//             children: [
//               _Avatar(
//                   text: prof['avatar'] as String,
//                   color: prof['avatarColor'] as Color,
//                   size: 56),
//               if (prof['available'] == true)
//                 Positioned(
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     width: 14,
//                     height: 14,
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                           color:
//                           isDark ? const Color(0xFF0F2137) : Colors.white,
//                           width: 2),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(prof['name'] as String,
//                     style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 15,
//                         color: cs.onSurface)),
//                 const SizedBox(height: 2),
//                 Text(prof['specialty'] as String,
//                     style: TextStyle(
//                         color: cs.primary,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 12)),
//                 const SizedBox(height: 4),
//                 Text(prof['hospital'] as String,
//                     style: TextStyle(
//                         color: cs.onSurface.withOpacity(0.5), fontSize: 11),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Icon(Icons.star_rounded, color: Colors.amber, size: 14),
//                     const SizedBox(width: 3),
//                     Text('${prof['rating']}',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 12)),
//                     Text(' (${prof['reviews']} reviews)',
//                         style: TextStyle(
//                             fontSize: 11,
//                             color: cs.onSurface.withOpacity(0.45))),
//                     const SizedBox(width: 8),
//                     Text('• ${prof['experience']}',
//                         style: TextStyle(
//                             fontSize: 11,
//                             color: cs.onSurface.withOpacity(0.45))),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),
//           GestureDetector(
//             onTap: onChat,
//             child: Container(
//               width: 42,
//               height: 42,
//               decoration: BoxDecoration(
//                 color: cs.primary,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: const Icon(Icons.chat_bubble_rounded,
//                   color: Colors.white, size: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─── CHAT LIST PAGE ────────────────────────────────────────────────────────────
//
// class ChatListPage extends StatelessWidget {
//   const ChatListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Messages',
//             style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 22,
//                 color: cs.primary)),
//         actions: [
//           IconButton(
//               icon: Icon(Icons.edit_rounded, color: cs.primary),
//               onPressed: () {}),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: Column(
//         children: [
//           if (kChats.isEmpty)
//             const Expanded(
//                 child: Center(child: Text('No conversations yet')))
//           else
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 itemCount: kChats.length,
//                 itemBuilder: (ctx, i) => AnimatedCard(
//                   index: i,
//                   child: _ChatTile(
//                     chat: kChats[i],
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => ChatDetailPage(chat: kChats[i])),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ChatTile extends StatelessWidget {
//   final Map<String, dynamic> chat;
//   final VoidCallback onTap;
//   const _ChatTile({required this.chat, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final hasUnread = (chat['unread'] as int) > 0;
//
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         child: Row(
//           children: [
//             Stack(
//               children: [
//                 _Avatar(
//                     text: chat['avatar'] as String,
//                     color: chat['avatarColor'] as Color,
//                     size: 52),
//                 if (chat['online'] == true)
//                   Positioned(
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       width: 13,
//                       height: 13,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                             color: isDark
//                                 ? const Color(0xFF0A1628)
//                                 : const Color(0xFFF8FBFF),
//                             width: 2),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(chat['name'] as String,
//                           style: TextStyle(
//                               fontWeight: hasUnread
//                                   ? FontWeight.w700
//                                   : FontWeight.w500,
//                               fontSize: 15,
//                               color: cs.onSurface)),
//                       Text(chat['time'] as String,
//                           style: TextStyle(
//                               fontSize: 11,
//                               color: hasUnread
//                                   ? cs.primary
//                                   : cs.onSurface.withOpacity(0.4),
//                               fontWeight: hasUnread
//                                   ? FontWeight.w600
//                                   : FontWeight.w400)),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(chat['lastMessage'] as String,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 color: hasUnread
//                                     ? cs.onSurface.withOpacity(0.75)
//                                     : cs.onSurface.withOpacity(0.45),
//                                 fontWeight: hasUnread
//                                     ? FontWeight.w500
//                                     : FontWeight.w400)),
//                       ),
//                       if (hasUnread)
//                         Container(
//                           margin: const EdgeInsets.only(left: 8),
//                           width: 20,
//                           height: 20,
//                           decoration: BoxDecoration(
//                               color: cs.primary, shape: BoxShape.circle),
//                           child: Center(
//                             child: Text('${chat['unread']}',
//                                 style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.w700)),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─── CHAT DETAIL PAGE ─────────────────────────────────────────────────────────
//
// class ChatDetailPage extends StatefulWidget {
//   final Map<String, dynamic> chat;
//   const ChatDetailPage({super.key, required this.chat});
//   @override
//   State<ChatDetailPage> createState() => _ChatDetailPageState();
// }
//
// class _ChatDetailPageState extends State<ChatDetailPage> {
//   final _ctrl = TextEditingController();
//   final _scroll = ScrollController();
//
//   final List<Map<String, dynamic>> _messages = [
//     {'from': 'doctor', 'text': 'Hello! I\'ve reviewed your recent test results. Your cholesterol levels have improved significantly. Keep up the great work! 🎉', 'time': '10:00 AM'},
//     {'from': 'user', 'text': 'Thank you Doctor! I\'ve been following the diet plan you gave me. Should I continue the same medication?', 'time': '10:05 AM'},
//     {'from': 'doctor', 'text': 'Yes, continue the current dosage for now. Your ECG results look great! Keep up the lifestyle changes.', 'time': '10:24 AM'},
//   ];
//
//   void _send() {
//     final text = _ctrl.text.trim();
//     if (text.isEmpty) return;
//     setState(() {
//       _messages.add({'from': 'user', 'text': text, 'time': _timeNow()});
//       _ctrl.clear();
//     });
//     Future.delayed(const Duration(milliseconds: 100), () {
//       _scroll.animateTo(_scroll.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
//     });
//   }
//
//   String _timeNow() {
//     final now = DateTime.now();
//     final h = now.hour.toString().padLeft(2, '0');
//     final m = now.minute.toString().padLeft(2, '0');
//     return '$h:$m';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final chat = widget.chat;
//
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 40,
//         title: Row(
//           children: [
//             _Avatar(
//                 text: chat['avatar'] as String,
//                 color: chat['avatarColor'] as Color,
//                 size: 38),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(chat['name'] as String,
//                     style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 15,
//                         color: cs.onSurface)),
//                 Text(
//                     chat['online'] == true ? '🟢 Online' : '⚫ Offline',
//                     style: TextStyle(
//                         fontSize: 11,
//                         color: cs.onSurface.withOpacity(0.5))),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//               icon: Icon(Icons.videocam_rounded, color: cs.primary),
//               onPressed: () {}),
//           IconButton(
//               icon: Icon(Icons.call_rounded, color: cs.primary), onPressed: () {}),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scroll,
//               padding: const EdgeInsets.all(16),
//               itemCount: _messages.length,
//               itemBuilder: (_, i) {
//                 final msg = _messages[i];
//                 final isUser = msg['from'] == 'user';
//                 return _MessageBubble(
//                     msg: msg, isUser: isUser, cs: cs, isDark: isDark);
//               },
//             ),
//           ),
//           Container(
//             color: isDark ? const Color(0xFF0F2137) : Colors.white,
//             padding: EdgeInsets.only(
//                 left: 12,
//                 right: 12,
//                 top: 8,
//                 bottom: MediaQuery.of(context).viewInsets.bottom + 12),
//             child: Row(
//               children: [
//                 IconButton(
//                     icon: Icon(Icons.add_circle_outline_rounded,
//                         color: cs.primary),
//                     onPressed: () {}),
//                 Expanded(
//                   child: TextField(
//                     controller: _ctrl,
//                     onSubmitted: (_) => _send(),
//                     decoration: InputDecoration(
//                       hintText: 'Type a message…',
//                       hintStyle: TextStyle(
//                           color: cs.onSurface.withOpacity(0.4), fontSize: 14),
//                       filled: true,
//                       fillColor: isDark
//                           ? cs.onSurface.withOpacity(0.06)
//                           : cs.primary.withOpacity(0.05),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(24),
//                           borderSide: BorderSide.none),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 12),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 CircleAvatar(
//                   radius: 22,
//                   backgroundColor: cs.primary,
//                   child: IconButton(
//                       icon:
//                       const Icon(Icons.send_rounded, color: Colors.white, size: 18),
//                       onPressed: _send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _MessageBubble extends StatelessWidget {
//   final Map<String, dynamic> msg;
//   final bool isUser;
//   final ColorScheme cs;
//   final bool isDark;
//   const _MessageBubble(
//       {required this.msg,
//         required this.isUser,
//         required this.cs,
//         required this.isDark});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         constraints:
//         BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
//         decoration: BoxDecoration(
//           gradient: isUser
//               ? LinearGradient(
//               colors: [cs.primary, cs.secondary],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight)
//               : null,
//           color: isUser
//               ? null
//               : (isDark
//               ? const Color(0xFF1A2F4A)
//               : cs.primary.withOpacity(0.07)),
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(18),
//             topRight: const Radius.circular(18),
//             bottomLeft: isUser ? const Radius.circular(18) : const Radius.circular(4),
//             bottomRight:
//             isUser ? const Radius.circular(4) : const Radius.circular(18),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment:
//           isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(msg['text'] as String,
//                 style: TextStyle(
//                     fontSize: 14,
//                     height: 1.45,
//                     color: isUser
//                         ? Colors.white
//                         : cs.onSurface.withOpacity(0.85))),
//             const SizedBox(height: 4),
//             Text(msg['time'] as String,
//                 style: TextStyle(
//                     fontSize: 10,
//                     color: isUser
//                         ? Colors.white.withOpacity(0.65)
//                         : cs.onSurface.withOpacity(0.4))),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─── PROFILE PAGE ─────────────────────────────────────────────────────────────
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 260,
//             pinned: true,
//             backgroundColor: cs.primary,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [cs.primary, AppTheme.deepBlue],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     // Decorative
//                     Positioned(
//                       right: -60,
//                       top: -60,
//                       child: Container(
//                         width: 200,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white.withOpacity(0.07),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: -40,
//                       bottom: -40,
//                       child: Container(
//                         width: 160,
//                         height: 160,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white.withOpacity(0.05),
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(height: 40),
//                           Container(
//                             width: 88,
//                             height: 88,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white.withOpacity(0.2),
//                               border: Border.all(color: Colors.white, width: 3),
//                             ),
//                             child: const Center(
//                               child: Text('JA',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 30)),
//                             ),
//                           ),
//                           const SizedBox(height: 14),
//                           const Text('Jide Adeyemi',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 22)),
//                           const SizedBox(height: 4),
//                           Text('Lagos, Nigeria · Joined 2024',
//                               style: TextStyle(
//                                   color: Colors.white.withOpacity(0.7),
//                                   fontSize: 13)),
//                           const SizedBox(height: 14),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               _StatBadge(label: 'Following', value: '12'),
//                               Container(
//                                   width: 1,
//                                   height: 28,
//                                   color: Colors.white.withOpacity(0.25),
//                                   margin: const EdgeInsets.symmetric(horizontal: 16)),
//                               _StatBadge(label: 'Saved Posts', value: '47'),
//                               Container(
//                                   width: 1,
//                                   height: 28,
//                                   color: Colors.white.withOpacity(0.25),
//                                   margin: const EdgeInsets.symmetric(horizontal: 16)),
//                               _StatBadge(label: 'Consultations', value: '8'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _SectionTitle('Health Overview', cs),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       _HealthMetric(
//                           icon: Icons.favorite_rounded,
//                           label: 'Heart Rate',
//                           value: '72 bpm',
//                           color: Colors.red,
//                           isDark: isDark),
//                       const SizedBox(width: 12),
//                       _HealthMetric(
//                           icon: Icons.water_drop_rounded,
//                           label: 'Blood Pressure',
//                           value: '120/80',
//                           color: Colors.blue,
//                           isDark: isDark),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       _HealthMetric(
//                           icon: Icons.directions_walk_rounded,
//                           label: 'Steps Today',
//                           value: '6,234',
//                           color: Colors.green,
//                           isDark: isDark),
//                       const SizedBox(width: 12),
//                       _HealthMetric(
//                           icon: Icons.local_fire_department_rounded,
//                           label: 'Calories',
//                           value: '1,842 kcal',
//                           color: Colors.orange,
//                           isDark: isDark),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   _SectionTitle('My Professionals', cs),
//                   const SizedBox(height: 12),
//                   ...kChats.map((c) => _MinimalChatTile(chat: c, cs: cs, isDark: isDark)),
//                   const SizedBox(height: 24),
//                   _SectionTitle('Settings', cs),
//                   const SizedBox(height: 8),
//                   _SettingsTile(
//                       icon: Icons.notifications_outlined,
//                       label: 'Notifications',
//                       cs: cs,
//                       isDark: isDark),
//                   _SettingsTile(
//                       icon: Icons.lock_outline_rounded,
//                       label: 'Privacy & Security',
//                       cs: cs,
//                       isDark: isDark),
//                   _SettingsTile(
//                       icon: Icons.help_outline_rounded,
//                       label: 'Help & Support',
//                       cs: cs,
//                       isDark: isDark),
//                   _SettingsTile(
//                       icon: Icons.logout_rounded,
//                       label: 'Sign Out',
//                       cs: cs,
//                       isDark: isDark,
//                       isDestructive: true),
//                   const SizedBox(height: 80),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _StatBadge extends StatelessWidget {
//   final String label, value;
//   const _StatBadge({required this.label, required this.value});
//   @override
//   Widget build(BuildContext context) => Column(
//     children: [
//       Text(value,
//           style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w800,
//               fontSize: 18)),
//       Text(label,
//           style: TextStyle(
//               color: Colors.white.withOpacity(0.65), fontSize: 11)),
//     ],
//   );
// }
//
// class _HealthMetric extends StatelessWidget {
//   final IconData icon;
//   final String label, value;
//   final Color color;
//   final bool isDark;
//   const _HealthMetric(
//       {required this.icon,
//         required this.label,
//         required this.value,
//         required this.color,
//         required this.isDark});
//
//   @override
//   Widget build(BuildContext context) => Expanded(
//     child: Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF0F2137) : Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: color.withOpacity(0.08),
//               blurRadius: 12,
//               offset: const Offset(0, 4)),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//                 color: color.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(12)),
//             child: Icon(icon, color: color, size: 20),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style: TextStyle(
//                         fontSize: 10,
//                         color: Theme.of(context)
//                             .colorScheme
//                             .onSurface
//                             .withOpacity(0.5))),
//                 Text(value,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w700, fontSize: 13)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// class _MinimalChatTile extends StatelessWidget {
//   final Map<String, dynamic> chat;
//   final ColorScheme cs;
//   final bool isDark;
//   const _MinimalChatTile(
//       {required this.chat, required this.cs, required this.isDark});
//
//   @override
//   Widget build(BuildContext context) => Container(
//     margin: const EdgeInsets.only(bottom: 8),
//     padding: const EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       color: isDark ? const Color(0xFF0F2137) : Colors.white,
//       borderRadius: BorderRadius.circular(14),
//     ),
//     child: Row(
//       children: [
//         _Avatar(
//             text: chat['avatar'] as String,
//             color: chat['avatarColor'] as Color,
//             size: 40),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(chat['name'] as String,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 14)),
//               Text(chat['specialty'] as String,
//                   style: TextStyle(
//                       fontSize: 12, color: cs.onSurface.withOpacity(0.5))),
//             ],
//           ),
//         ),
//         Icon(Icons.arrow_forward_ios_rounded,
//             size: 14, color: cs.onSurface.withOpacity(0.3)),
//       ],
//     ),
//   );
// }
//
// class _SettingsTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final ColorScheme cs;
//   final bool isDark;
//   final bool isDestructive;
//   const _SettingsTile(
//       {required this.icon,
//         required this.label,
//         required this.cs,
//         required this.isDark,
//         this.isDestructive = false});
//
//   @override
//   Widget build(BuildContext context) => Container(
//     margin: const EdgeInsets.only(bottom: 8),
//     decoration: BoxDecoration(
//       color: isDark ? const Color(0xFF0F2137) : Colors.white,
//       borderRadius: BorderRadius.circular(14),
//     ),
//     child: ListTile(
//       leading: Container(
//         width: 38,
//         height: 38,
//         decoration: BoxDecoration(
//           color: isDestructive
//               ? Colors.red.withOpacity(0.1)
//               : cs.primary.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(icon,
//             color: isDestructive ? Colors.red : cs.primary, size: 20),
//       ),
//       title: Text(label,
//           style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 14,
//               color: isDestructive ? Colors.red : cs.onSurface)),
//       trailing: isDestructive
//           ? null
//           : Icon(Icons.arrow_forward_ios_rounded,
//           size: 14, color: cs.onSurface.withOpacity(0.3)),
//       shape:
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//     ),
//   );
// }
//
// // ─── Shared Widgets ───────────────────────────────────────────────────────────
//
// class _Avatar extends StatelessWidget {
//   final String text;
//   final Color color;
//   final double size;
//   const _Avatar(
//       {required this.text, required this.color, required this.size});
//
//   @override
//   Widget build(BuildContext context) => Container(
//     width: size,
//     height: size,
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [color, color.withOpacity(0.7)],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       shape: BoxShape.circle,
//     ),
//     child: Center(
//       child: Text(text,
//           style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//               fontSize: size * 0.3)),
//     ),
//   );
// }
//
// class _SectionTitle extends StatelessWidget {
//   final String title;
//   final ColorScheme cs;
//   const _SectionTitle(this.title, this.cs);
//   @override
//   Widget build(BuildContext context) => Text(title,
//       style: TextStyle(
//           fontWeight: FontWeight.w700,
//           fontSize: 17,
//           color: cs.onSurface));
// }
//
// // ─── Animated Card (staggered entrance) ───────────────────────────────────────
//
// class AnimatedCard extends StatefulWidget {
//   final Widget child;
//   final int index;
//   const AnimatedCard({super.key, required this.child, required this.index});
//   @override
//   State<AnimatedCard> createState() => _AnimatedCardState();
// }
//
// class _AnimatedCardState extends State<AnimatedCard>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _ctrl;
//   late Animation<double> _fade;
//   late Animation<Offset> _slide;
//
//   @override
//   void initState() {
//     super.initState();
//     _ctrl = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 500));
//     _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
//     _slide = Tween<Offset>(
//         begin: const Offset(0, 0.08), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
//     final delay = Duration(milliseconds: widget.index * 80);
//     Future.delayed(delay, () {
//       if (mounted) _ctrl.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => FadeTransition(
//     opacity: _fade,
//     child: SlideTransition(position: _slide, child: widget.child),
//   );
// }
//
//
//
// class ViewModel{
//
//   final ImagePicker picker = ImagePicker();
//
//   Future<File?> pickMedia(bool isVideo) async{
//     XFile? file;
//
//     if(isVideo){
//       file = await picker.pickVideo(source: ImageSource.gallery);
//
//     }else{
//       file = await picker.pickImage(source: ImageSource.gallery);
//     }
//
//     if(file == null) return null;
//     return File(file.path);
//   }
//
// }
