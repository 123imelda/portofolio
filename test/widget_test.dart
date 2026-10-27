import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kia_portfolio/main.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Kia Portfolio menampilkan halaman beranda', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KiaPortfolioApp());

    expect(find.text('Selamat datang di portofolio saya'), findsOneWidget);
  });
}
