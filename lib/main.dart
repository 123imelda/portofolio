import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// Warna utama aplikasi
const Color kPink = Color(0xFFF5D5E4);
const Color kPinkStrong = Color(0xFFE884AE);
const Color kLavender = Color(0xFFE4D9F7);
const Color kSage = Color(0xFFDDEBDD);
const Color kBlue = Color(0xFFDCEBFA);
const Color kInk = Color(0xFF303447);
const Color kMuted = Color(0xFF73788B);
const Color kBackground = Color(0xFFF8F7FB);

// Tautan desain Figma
const String figmaUrl =
    'https://www.figma.com/proto/B8myds9taf0cO9SZcc28fK/medium-desain?node-id=11-2&starting-point-node-id=151%3A49&t=y3cCJA8fL4yT0Vrz-1';

// Aset foto profil
const String profilePhoto = 'assets/images/rizkia_profile.jpeg';

// Tautan sumber foto gedung LoveLens Wedding
const String lovelensVenueSourceUrl =
    'https://share.google/NR1z2VPiSD4zIgAk8';

void main() {
  runApp(const KiaPortfolioApp());
}

// Model data proyek
class PortfolioProject {
  final int id;
  final String title;
  final String category;
  final String subtitle;
  final String description;
  final String role;
  final List<String> tools;
  final String image;
  final List<String> gallery;
  final Color accent;
  final IconData icon;
  final bool mobileScreenshots;

  const PortfolioProject({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.description,
    required this.role,
    required this.tools,
    required this.image,
    required this.gallery,
    required this.accent,
    required this.icon,
    this.mobileScreenshots = false,
  });
}

// Data proyek portofolio
const List<PortfolioProject> portfolioProjects = [
  PortfolioProject(
    id: 1,
    title: 'MomsCare',
    category: 'UI/UX',
    subtitle: 'Desain aplikasi kesehatan ibu hamil',
    description:
        'MomsCare merupakan konsep aplikasi pemantauan kesehatan '
        'ibu hamil yang saya rancang secara mandiri. Desain mencakup '
        'halaman registrasi, dashboard kesehatan, direktori dokter, '
        'dan visualisasi riwayat detak jantung. Prototype interaktif '
        'dibuat di Figma untuk memperlihatkan alur penggunaan aplikasi.',
    role: 'Desain UI/UX dan prototype interaktif',
    tools: ['Figma', 'UI Design', 'UX Prototyping'],
    image: 'assets/images/momscare_cover.png',
    gallery: [
      'assets/images/momscare_doctors.png',
      'assets/images/momscare_heart_rate.png',
    ],
    accent: kPink,
    icon: Icons.favorite_rounded,
    mobileScreenshots: true,
  ),
  PortfolioProject(
    id: 2,
    title: 'LoveLens Wedding',
    category: 'Website',
    subtitle: 'Website pemesanan gedung pernikahan',
    description:
        'LoveLens Wedding merupakan website pemesanan gedung '
        'pernikahan yang saya desain dan kembangkan secara mandiri. '
        'Fitur utamanya mencakup pilihan gedung, formulir pemesanan, '
        'perhitungan durasi dan biaya sewa, validasi jadwal, serta '
        'pengelolaan data pemesanan.',
    role: 'Desain dan pengembangan website',
    tools: ['Python', 'Flask', 'HTML', 'CSS', 'Bootstrap'],
    image: 'assets/images/lovelens_lantai1.jpg',
    gallery: [
      'assets/images/lovelens_packages.jpg',
      'assets/images/lovelens_booking_form.jpg',
      'assets/images/lovelens_admin_login.jpg',
      'assets/images/lovelens_lantai1.jpg',
    ],
    accent: kLavender,
    icon: Icons.favorite_border_rounded,
  ),
];

// Konfigurasi aplikasi dan rute halaman
class KiaPortfolioApp extends StatelessWidget {
  const KiaPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kBackground,
      colorScheme: ColorScheme.fromSeed(seedColor: kPinkStrong),
    );

    return MaterialApp(
      title: 'Kia Portfolio',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme)
            .apply(bodyColor: kInk, displayColor: kInk),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/skills': (context) => const SkillsPage(),
        '/projects': (context) => const ProjectsPage(),
        '/contact': (context) => const ContactPage(),
      },
      onGenerateRoute: (settings) {
        final match = RegExp(r'^/project/(\d+)$')
            .firstMatch(settings.name ?? '');

        if (match != null) {
          final id = int.parse(match.group(1)!);

          for (final project in portfolioProjects) {
            if (project.id == id) {
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => ProjectDetailPage(project: project),
              );
            }
          }
        }

        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const NotFoundPage(),
        );
      },
    );
  }
}

// Data menu navigasi
class NavItem {
  final String title;
  final String route;
  final IconData icon;

  const NavItem(this.title, this.route, this.icon);
}

const List<NavItem> navItems = [
  NavItem('Beranda', '/', Icons.home_rounded),
  NavItem('Tentang Saya', '/about', Icons.person_rounded),
  NavItem('Keahlian', '/skills', Icons.grid_view_rounded),
  NavItem('Proyek', '/projects', Icons.work_outline_rounded),
  NavItem('Kontak', '/contact', Icons.mail_outline_rounded),
];

// Layout responsif aplikasi
class PortfolioLayout extends StatelessWidget {
  final String title;
  final String currentRoute;
  final Widget child;

  const PortfolioLayout({
    super.key,
    required this.title,
    required this.currentRoute,
    required this.child,
  });

  void navigate(BuildContext context, String route) {
    if (route == currentRoute) return;

    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 720) {
          return Scaffold(
            backgroundColor: kBackground,
            appBar: AppBar(
              backgroundColor: Colors.white.withValues(alpha: 0.92),
              surfaceTintColor: Colors.transparent,
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              actions: [
                PopupMenuButton<String>(
                  tooltip: 'Buka menu',
                  icon: const Icon(Icons.menu_rounded),
                  onSelected: (route) => navigate(context, route),
                  itemBuilder: (context) => navItems.map((item) {
                    return PopupMenuItem<String>(
                      value: item.route,
                      child: Row(
                        children: [
                          Icon(item.icon, size: 19),
                          const SizedBox(width: 10),
                          Text(item.title),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            body: PastelBackdrop(
              child: Padding(padding: const EdgeInsets.all(14), child: child),
            ),
          );
        }

        final compactSidebar = width < 1040;

        return Scaffold(
          backgroundColor: kBackground,
          body: PastelBackdrop(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Sidebar(currentRoute: currentRoute, compact: compactSidebar),
                Expanded(
                  child: Column(
                    children: [
                      TopBar(title: title),
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1240),
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  compactSidebar ? 18 : 30,
                                  16,
                                  compactSidebar ? 18 : 30,
                                  24,
                                ),
                                child: child,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Latar belakang aplikasi
class PastelBackdrop extends StatelessWidget {
  final Widget child;

  const PastelBackdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: -90,
          right: -65,
          child: ColorOrb(color: kLavender, size: 270),
        ),
        const Positioned(
          bottom: -110,
          left: 130,
          child: ColorOrb(color: kSage, size: 290),
        ),
        const Positioned(
          top: 230,
          left: -115,
          child: ColorOrb(color: kPink, size: 235),
        ),
        const Positioned(
          bottom: 100,
          right: -90,
          child: ColorOrb(color: kBlue, size: 220),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class ColorOrb extends StatelessWidget {
  final Color color;
  final double size;

  const ColorOrb({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.35),
        ),
      ),
    );
  }
}

// Menu navigasi samping
class Sidebar extends StatelessWidget {
  final String currentRoute;
  final bool compact;

  const Sidebar({super.key, required this.currentRoute, required this.compact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: compact ? 76 : 224,
      margin: const EdgeInsets.fromLTRB(14, 14, 0, 14),
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xDFFFFFFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: kLavender.withValues(alpha: 0.2),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          if (compact)
            const BrandMark()
          else
            const Row(
              children: [
                BrandMark(),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Kia Portfolio',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 30),
          for (final item in navItems)
            SidebarButton(
              item: item,
              compact: compact,
              selected:
                  currentRoute == item.route ||
                  (item.route == '/projects' &&
                      currentRoute.startsWith('/project/')),
            ),
          const Spacer(),
          if (compact)
            const Icon(Icons.auto_awesome_rounded, color: kPinkStrong)
          else
            const Text(
              'Portofolio UI/UX',
              style: TextStyle(color: kMuted, fontSize: 11),
            ),
        ],
      ),
    );
  }
}

// Foto profil pada identitas aplikasi
class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: kPink,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: kPinkStrong.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Image.asset(
          profilePhoto,
          width: 42,
          height: 42,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person_rounded, color: kInk, size: 24);
          },
        ),
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final NavItem item;
  final bool selected;
  final bool compact;

  const SidebarButton({
    super.key,
    required this.item,
    required this.selected,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final button = InkWell(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          item.route,
          (route) => false,
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 46,
        margin: const EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: compact ? 0 : 12),
        decoration: BoxDecoration(
          color: selected ? kPink.withValues(alpha: 0.6) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: compact
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Icon(item.icon, size: 20, color: selected ? kPinkStrong : kMuted),
            if (!compact) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: selected ? kInk : kMuted,
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );

    return compact ? Tooltip(message: item.title, child: button) : button;
  }
}

// Bilah navigasi atas
class TopBar extends StatelessWidget {
  final String title;

  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xDFFFFFFF),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          const Icon(Icons.auto_awesome_rounded, size: 18, color: kMuted),
          const SizedBox(width: 9),
          const Text(
            'Selamat datang, Rizkia',
            style: TextStyle(color: kMuted, fontSize: 12),
          ),
          const SizedBox(width: 14),
          const BrandMark(),
        ],
      ),
    );
  }
}

// Kartu dengan efek transparan
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(22),
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xDFFFFFFF),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: kLavender.withValues(alpha: 0.16),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeading(this.title, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 5),
            Text(
              subtitle!,
              style: const TextStyle(color: kMuted, fontSize: 12, height: 1.6),
            ),
          ],
        ],
      ),
    );
  }
}

// Komponen gambar lokal dan gambar dari internet
class LocalProjectImage extends StatelessWidget {
  final String path;
  final Color tint;
  final IconData fallbackIcon;
  final BoxFit fit;
  final String? sourceUrl;

  const LocalProjectImage({
    super.key,
    required this.path,
    required this.tint,
    required this.fallbackIcon,
    this.fit = BoxFit.cover,
    this.sourceUrl,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback(BuildContext context, Object error, StackTrace? stackTrace) {
      return Center(
        child: Icon(
          fallbackIcon,
          size: 44,
          color: kInk.withValues(alpha: 0.7),
        ),
      );
    }

    final isNetworkImage =
        path.startsWith('https://') || path.startsWith('http://');
    final linkUrl = sourceUrl ?? (isNetworkImage ? path : '');
    final canOpenSource = linkUrl.isNotEmpty;
    final Widget image = isNetworkImage
        ? Image.network(
            path,
            width: double.infinity,
            height: double.infinity,
            fit: fit,
            errorBuilder: fallback,
          )
        : Image.asset(
            path,
            width: double.infinity,
            height: double.infinity,
            fit: fit,
            errorBuilder: fallback,
          );

    final Widget content = canOpenSource
        ? InkWell(
            onTap: () async {
              final uri = Uri.tryParse(linkUrl);
              if (uri == null || !uri.hasScheme) return;
              try {
                final opened = await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
                if (!opened && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sumber gambar tidak dapat dibuka.'),
                    ),
                  );
                }
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sumber gambar tidak dapat dibuka.'),
                    ),
                  );
                }
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                image,
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.93),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kLavender),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.open_in_new_rounded, size: 14, color: kInk),
                        SizedBox(width: 5),
                        Text(
                          'Lihat sumber',
                          style: TextStyle(
                            color: kInk,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : image;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: tint.withValues(alpha: 0.18),
      alignment: Alignment.center,
      child: content,
    );
  }
}

// Halaman beranda
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final momscare = portfolioProjects.first;

    return PortfolioLayout(
      title: 'Beranda',
      currentRoute: '/',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 900;

                final introduction = GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: kSage,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'PORTOFOLIO UI/UX',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Selamat datang di portofolio saya',
                        style: TextStyle(
                          fontSize: 29,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Aku seorang mahasiswa yang tertarik pada UI/UX design '
                        'dan pengembangan website. Aku menikmati proses '
                        'menggabungkan estetika, kreativitas, dan fungsionalitas '
                        'untuk menciptakan pengalaman digital yang berkesan. '
                        'Jelajahi karya-karyaku dan lihat bagaimana ide '
                        'berkembang menjadi sebuah desain.',
                        style: TextStyle(
                          color: kMuted,
                          height: 1.8,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          FilledButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/projects');
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: kPinkStrong,
                              foregroundColor: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.work_outline_rounded,
                              size: 18,
                            ),
                            label: const Text('Lihat Proyek'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => const AboutPage(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: kInk,
                              side: const BorderSide(color: kLavender),
                            ),
                            icon: const Icon(
                              Icons.person_outline_rounded,
                              size: 18,
                            ),
                            label: const Text('Tentang Saya'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );

                final featured = InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/project/1');
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: SizedBox.expand(
                              child: Hero(
                                tag: 'project-image-${momscare.id}',
                                child: LocalProjectImage(
                                  path: momscare.image,
                                  tint: momscare.accent,
                                  fallbackIcon: momscare.icon,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'PROYEK PILIHAN',
                          style: TextStyle(color: kMuted, fontSize: 11),
                        ),
                        Text(
                          momscare.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          momscare.subtitle,
                          style: const TextStyle(color: kMuted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );

                if (isWide) {
                  return SizedBox(
                    height: 390,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 6, child: introduction),
                        const SizedBox(width: 18),
                        Expanded(flex: 4, child: featured),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    introduction,
                    const SizedBox(height: 16),
                    SizedBox(height: 280, child: featured),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            const SectionHeading(
              'Proyek Pilihan',
              subtitle:
                  'Dua proyek yang menggambarkan minat saya pada '
                  'desain dan pengembangan digital.',
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 850 ? 2 : 1;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: portfolioProjects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    mainAxisExtent: 126,
                  ),
                  itemBuilder: (context, index) {
                    final project = portfolioProjects[index];

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/project/${project.id}');
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: GlassCard(
                        padding: const EdgeInsets.all(12),
                        radius: 20,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: SizedBox(
                                width: 90,
                                height: 92,
                                child: LocalProjectImage(
                                  path: project.image,
                                  tint: project.accent,
                                  fallbackIcon: project.icon,
                                  fit: project.mobileScreenshots
                                      ? BoxFit.contain
                                      : BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    project.subtitle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: kMuted,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: kMuted,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Komponen ikon
class IconTile extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconTile({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(icon, color: kInk, size: 23),
    );
  }
}

// Kartu riwayat pendidikan
class EducationCard extends StatelessWidget {
  final String title;
  final String period;
  final String subtitle;
  final IconData icon;
  final Color color;

  const EducationCard({
    super.key,
    required this.title,
    required this.period,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(icon: icon, color: color),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  period,
                  style: const TextStyle(
                    color: kPinkStrong,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: kMuted,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman tentang saya
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _openFigma(BuildContext context) async {
    final uri = Uri.parse(figmaUrl);

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tautan Figma tidak dapat dibuka.')),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tautan Figma tidak dapat dibuka.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PortfolioLayout(
      title: 'Tentang Saya',
      currentRoute: '/about',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassCard(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final horizontal = constraints.maxWidth > 680;

                  final identity = Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                          boxShadow: [
                            BoxShadow(
                              color: kPinkStrong.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            profilePhoto,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: kPink,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 60,
                                  color: kInk,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Rizkia Imelda',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Desain UI/UX',
                        style: TextStyle(color: kMuted, fontSize: 12),
                      ),
                    ],
                  );

                  const biography = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mengenal Saya Lebih Dekat',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Saya Rizkia Imelda, mahasiswa semester 5 Program '
                        'Studi Sistem Teknologi dan Informasi di Universitas '
                        '17 Agustus 1945. Saya tertarik pada desain UI/UX '
                        'aplikasi dan website, terutama dalam membangun '
                        'tampilan yang modern, harmonis, dan tidak monoton.',
                        style: TextStyle(
                          color: kMuted,
                          height: 1.8,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Saya memperhatikan detail visual, khususnya '
                        'kombinasi warna, pemilihan ikon, dan konsistensi '
                        'antarmuka. Bagi saya, desain yang baik bukan hanya '
                        'menarik, tetapi juga menyampaikan informasi dengan '
                        'jelas dan nyaman digunakan.',
                        style: TextStyle(
                          color: kMuted,
                          height: 1.8,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  );

                  if (horizontal) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 210, child: identity),
                        const SizedBox(width: 28),
                        const Expanded(child: biography),
                      ],
                    );
                  }

                  return Column(
                    children: [identity, const SizedBox(height: 24), biography],
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // Riwayat pendidikan dari SMP hingga universitas
            const SectionHeading(
              'Pendidikan',
              subtitle: 'Riwayat pendidikan saya.',
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EducationCard(
                  title: 'SMP Darul Ulum 1 Unggulan',
                  period: '2018–2021',
                  subtitle: 'Sekolah Menengah Pertama',
                  icon: Icons.auto_stories_rounded,
                  color: kBlue,
                ),
                SizedBox(height: 12),
                EducationCard(
                  title: 'SMA Wachid Hasyim 2 Taman',
                  period: '2021–2024',
                  subtitle: 'Sekolah Menengah Atas',
                  icon: Icons.menu_book_rounded,
                  color: kPink,
                ),
                SizedBox(height: 12),
                EducationCard(
                  title: 'Universitas 17 Agustus 1945',
                  period: '2024–sekarang',
                  subtitle: 'Sistem Teknologi dan Informasi · Semester 5',
                  icon: Icons.school_rounded,
                  color: kLavender,
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Tautan desain MomsCare
            const SectionHeading(
              'Contoh Desain Buatan Saya',
              subtitle:
                  'Klik gambar untuk melihat desain MomsCare yang saya '
                  'rancang di Figma.',
            ),
            GlassCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => _openFigma(context),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: Image.asset(
                              'assets/images/momscare_cover.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: kPink,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.design_services_rounded,
                                    size: 48,
                                    color: kInk,
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 75,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Color(0xB82B2540)],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.open_in_new_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 9),
                                Expanded(
                                  child: Text(
                                    'Lihat desain MomsCare di Figma',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'MomsCare — desain aplikasi kesehatan ibu hamil',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Desain UI/UX dan prototype interaktif menggunakan Figma.',
                    style: TextStyle(color: kMuted, fontSize: 12, height: 1.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model data keahlian
class SkillItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const SkillItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

// Halaman keahlian
class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const skills = [
      SkillItem(
        title: 'UI Design',
        description: 'Merancang tampilan antarmuka aplikasi dan website.',
        icon: Icons.dashboard_customize_rounded,
        color: kPink,
      ),
      SkillItem(
        title: 'UX Prototyping',
        description:
            'Membuat prototype interaktif untuk menggambarkan alur layar.',
        icon: Icons.touch_app_rounded,
        color: kLavender,
      ),
      SkillItem(
        title: 'Color & Icon Selection',
        description:
            'Memilih warna dan ikon dengan memperhatikan konsistensi visual.',
        icon: Icons.palette_rounded,
        color: kSage,
      ),
      SkillItem(
        title: 'Figma',
        description: 'Membuat desain antarmuka dan prototype.',
        icon: Icons.design_services_rounded,
        color: kBlue,
      ),
      SkillItem(
        title: 'Canva',
        description: 'Menyusun desain visual sesuai kebutuhan.',
        icon: Icons.image_rounded,
        color: kPink,
      ),
      SkillItem(
        title: 'Web Development',
        description: 'Membangun website dan fungsi interaktifnya.',
        icon: Icons.code_rounded,
        color: kSage,
      ),
    ];

    return PortfolioLayout(
      title: 'Keahlian',
      currentRoute: '/skills',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              'Keahlian Saya',
              subtitle:
                  'Kemampuan yang saya gunakan dalam proyek desain '
                  'dan pengembangan web.',
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 940
                    ? 3
                    : (constraints.maxWidth > 560 ? 2 : 1);

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: skills.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    mainAxisExtent: 190,
                  ),
                  itemBuilder: (context, index) {
                    final skill = skills[index];

                    return GlassCard(
                      padding: const EdgeInsets.all(18),
                      radius: 22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconTile(icon: skill.icon, color: skill.color),
                          const SizedBox(height: 12),
                          Text(
                            skill.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            skill.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: kMuted,
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman daftar proyek
class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String selectedCategory = 'Semua';
  final Set<int> savedProjects = {};

  @override
  Widget build(BuildContext context) {
    final filteredProjects = selectedCategory == 'Semua'
        ? portfolioProjects
        : portfolioProjects
              .where((project) => project.category == selectedCategory)
              .toList();

    final isNarrow = MediaQuery.sizeOf(context).width < 520;

    return PortfolioLayout(
      title: 'Proyek',
      currentRoute: '/projects',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              'Proyek Pilihan',
              subtitle: 'Pilih proyek untuk melihat deskripsi dan gambar hasil pekerjaan.',
            ),
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: ['Semua', 'UI/UX', 'Website'].map((category) {
                final selected = selectedCategory == category;
                final tint = category == 'UI/UX'
                    ? kPink
                    : (category == 'Website' ? kLavender : kBlue);

                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  selectedColor: tint,
                  backgroundColor: Colors.white.withValues(alpha: 0.75),
                  side: BorderSide(color: selected ? tint : Colors.white),
                  labelStyle: const TextStyle(color: kInk),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProjects.length,
              separatorBuilder: (context, index) => const SizedBox(height: 13),
              itemBuilder: (context, index) {
                final project = filteredProjects[index];
                final saved = savedProjects.contains(project.id);

                return GlassCard(
                  padding: const EdgeInsets.all(12),
                  radius: 21,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: isNarrow ? 76 : 116,
                          height: isNarrow ? 88 : 104,
                          child: Hero(
                            tag: 'project-image-${project.id}',
                            child: LocalProjectImage(
                              path: project.image,
                              tint: project.accent,
                              fallbackIcon: project.icon,
                              fit: project.mobileScreenshots
                                  ? BoxFit.contain
                                  : BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/project/${project.id}',
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.category,
                                  style: const TextStyle(
                                    color: kMuted,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  project.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  project.subtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: kMuted,
                                    fontSize: 11,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Lihat detail proyek',
                                  style: TextStyle(
                                    color: kPinkStrong,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: saved
                            ? 'Hapus proyek tersimpan'
                            : 'Simpan proyek',
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          setState(() {
                            if (saved) {
                              savedProjects.remove(project.id);
                            } else {
                              savedProjects.add(project.id);
                            }
                          });
                        },
                        icon: Icon(
                          saved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: saved ? kPinkStrong : kMuted,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman detail proyek
class ProjectDetailPage extends StatelessWidget {
  final PortfolioProject project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return PortfolioLayout(
      title: 'Detail Proyek',
      currentRoute: '/project/${project.id}',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton.filledTonal(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  tooltip: 'Kembali',
                ),
                const SizedBox(width: 10),
                const Text(
                  'Detail Proyek',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final horizontal = constraints.maxWidth > 730;

                      final cover = ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: horizontal ? 420 : 320,
                          width: double.infinity,
                          child: Container(
                            color: project.accent.withValues(alpha: 0.18),
                            alignment: Alignment.center,
                            child: Hero(
                              tag: 'project-image-${project.id}',
                              child: LocalProjectImage(
                                path: project.image,
                                tint: project.accent,
                                fallbackIcon: project.icon,
                                fit: project.mobileScreenshots
                                    ? BoxFit.contain
                                    : BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );

                      final summary = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.category,
                            style: const TextStyle(color: kMuted, fontSize: 12),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            project.title,
                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            project.description,
                            style: const TextStyle(
                              color: kMuted,
                              height: 1.8,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Peran Saya',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            project.role,
                            style: const TextStyle(color: kMuted, fontSize: 12),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Tools',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 7,
                            runSpacing: 7,
                            children: project.tools.map((tool) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: project.accent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  tool,
                                  style: const TextStyle(fontSize: 11),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );

                      if (horizontal) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 5, child: cover),
                            const SizedBox(width: 24),
                            Expanded(flex: 4, child: summary),
                          ],
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [cover, const SizedBox(height: 22), summary],
                      );
                    },
                  ),
                  if (project.gallery.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const SectionHeading('Galeri Proyek'),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final columns = constraints.maxWidth > 850 ? 3 : 2;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: project.gallery.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                mainAxisExtent: project.mobileScreenshots
                                    ? 250
                                    : 170,
                              ),
                          itemBuilder: (context, index) {
                            final imagePath = project.gallery[index];
                            final isVenueSourceImage =
                                project.id == 2 &&
                                imagePath == 'assets/images/lovelens_lantai1.jpg';

                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: project.accent.withValues(alpha: 0.18),
                                child: LocalProjectImage(
                                  path: imagePath,
                                  sourceUrl: isVenueSourceImage
                                      ? lovelensVenueSourceUrl
                                      : null,
                                  tint: project.accent,
                                  fallbackIcon: project.icon,
                                  fit: project.mobileScreenshots
                                      ? BoxFit.contain
                                      : BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => Navigator.pop(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: kPinkStrong,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: const Text('Kembali ke Proyek'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman kontak
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioLayout(
      title: 'Kontak',
      currentRoute: '/contact',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              'Mari Terhubung!',
              subtitle:
                  'Hubungi saya untuk berdiskusi tentang desain UI/UX, '
                  'website, atau peluang kolaborasi.',
            ),
            const GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kontak Profesional',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Silakan hubungi saya melalui email atau WhatsApp.',
                    style: TextStyle(color: kMuted, height: 1.7, fontSize: 12),
                  ),
                  SizedBox(height: 18),
                  ContactTile(
                    title: 'Email',
                    value: 'rizkiaimelda5@gmail.com',
                    url: 'mailto:rizkiaimelda5@gmail.com',
                    icon: Icons.mail_outline_rounded,
                    tint: kPink,
                  ),
                  SizedBox(height: 11),
                  ContactTile(
                    title: 'WhatsApp',
                    value: '0812 2723 1853',
                    url: 'https://wa.me/6281227231853',
                    icon: Icons.chat_bubble_outline_rounded,
                    tint: kSage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String title;
  final String value;
  final String url;
  final IconData icon;
  final Color tint;

  const ContactTile({
    super.key,
    required this.title,
    required this.value,
    required this.url,
    required this.icon,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () async {
          final uri = Uri.parse(url);

          try {
            final opened = await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );

            if (!opened && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tautan tidak dapat dibuka.')),
              );
            }
          } catch (_) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tautan tidak dapat dibuka.')),
              );
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.47),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            children: [
              IconTile(icon: icon, color: tint),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SelectableText(
                      value,
                      style: const TextStyle(color: kMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new_rounded, size: 18, color: kMuted),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman untuk rute yang tidak tersedia
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioLayout(
      title: 'Halaman Tidak Ditemukan',
      currentRoute: '',
      child: Center(
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.search_off_rounded,
                size: 54,
                color: kPinkStrong,
              ),
              const SizedBox(height: 12),
              const Text(
                'Halaman tidak ditemukan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kembali ke beranda untuk melanjutkan.',
                style: TextStyle(color: kMuted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: kPinkStrong,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
