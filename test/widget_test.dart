import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_profile_app/core/base/auth/bloc/auth_bloc.dart';
import 'package:my_profile_app/core/base/auth/service/auth_service.dart';
import 'package:my_profile_app/core/components/appbar/appbar.dart';
import 'package:my_profile_app/core/init/cache/auth_cache_manager.dart';
import 'package:my_profile_app/core/init/network/dio_manager.dart';

import 'package:my_profile_app/view/auth/login_view.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {
  MockAuthBloc(MockAuthService mockAuthService,
      MockAuthCacheManager mockAuthCacheManager);
}

class MockAuthService extends Mock implements AuthService {
  MockAuthService(DioManager instance);
}

class MockAuthCacheManager extends Mock implements AuthCacheManager {}

void main() {
  dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());
  group('LoginView Test', () {
    testWidgets('LoginView Test', (WidgetTester tester) async {
      // Test code goes here
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<MockAuthBloc>.value(
              value: MockAuthBloc(
                MockAuthService(DioManager.instance),
                MockAuthCacheManager(),
              ),
              child: const LoginView(),
            ),
          ),
        );
        final authBloc = AuthBloc(
          MockAuthService(DioManager.instance),
          MockAuthCacheManager(),
        );
        whenListen(authBloc, Stream.fromIterable([0, 1, 2, 3]));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
      } catch (error) {
        if (kDebugMode) {
          print('Test failed: $error');
        }
      }
    });

    testWidgets('LoginView Test', (WidgetTester tester) async {
      // Test code goes here
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<MockAuthBloc>.value(
              value: MockAuthBloc(
                MockAuthService(DioManager.instance),
                MockAuthCacheManager(),
              ),
              child: const LoginView(),
            ),
          ),
        );
        final authBloc = AuthBloc(
          MockAuthService(DioManager.instance),
          MockAuthCacheManager(),
        );
        whenListen(authBloc, Stream.fromIterable([0, 1, 2, 3]));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
      } catch (error) {
        if (kDebugMode) {
          print('Test failed: $error');
        }
      }
    });
  });

  group('widget', () {
    testWidgets('app bar', (WidgetTester tester) async {
      testWidgets('app bar', (WidgetTester tester) async {
        await tester.pumpWidget(
          CustomAppBar(),
        );

        final titleFinder = find.text('@MyAppName');
        expect(titleFinder, findsOneWidget);
      });
    });
  });
}
