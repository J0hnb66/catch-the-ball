import 'package:flutter_test/flutter_test.dart';
import 'package:catch_the_ball/main.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const CatchTheBallApp());

    // Verify the app starts on the main menu screen.
    expect(find.text('Catch the Ball Game'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);
    expect(find.text('Quit'), findsOneWidget);
  });
}
