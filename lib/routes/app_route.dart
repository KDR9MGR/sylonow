import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sylonow/core/screens/main_screen.dart';
import 'package:sylonow/features/category/screens/category_detail_screen.dart';
import 'package:sylonow/features/home/screens/service_detail_screen.dart';
import 'package:sylonow/features/splash/screens/t_splash_screen.dart';
import 'package:sylonow/features/checkout/screens/checkout_screen.dart';
import 'package:sylonow/features/checkout/screens/order_success_screen.dart';
import 'package:sylonow/features/profile/screens/personal_info_screen.dart';
import 'package:sylonow/features/profile/screens/addresses_screen.dart';
import 'package:sylonow/features/profile/screens/notifications_screen.dart';
import 'package:sylonow/features/profile/screens/payment_method_screen.dart';
import 'package:sylonow/features/profile/screens/settings_screen.dart';
import 'package:sylonow/features/profile/screens/edit_profile_screen.dart';
import 'package:sylonow/features/profile/screens/my_orders_screen.dart';
import 'package:sylonow/features/profile/screens/user_reviews_screen.dart';

class AppRoute {
  static final routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const TSplashScreen(),
      ),
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/service-detail',
        builder: (context, state) => const ServiceDetailScreen(),
      ),
      GoRoute(
        path: '/checkout',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return CustomPage(
            name: 'checkout',
            child: CheckoutScreen(
              theme: extra['theme'] as String,
              venue: extra['venue'] as String,
              date: extra['date'] as DateTime,
              time: extra['time'] as TimeOfDay,
              comment: extra['comment'] as String,
            ),
          );
        },
      ),
      GoRoute(
        path: '/order-success',
        name: 'order-success',
        builder: (context, state) => const OrderSuccessScreen(),
      ),
      GoRoute(
      path: '/category-detail/:heroTag',
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        return CategoryDetailScreen(
          title: extra['title'] ?? '',
          imageUrl: extra['imageUrl'] ?? '',
          heroTag: state.pathParameters['heroTag'] ?? '',
        );
      },
    ),

      // Profile Routes
      GoRoute(
        path: '/profile/edit',
        pageBuilder: (context, state) => CustomPage(
          child: const EditProfileScreen(),
          name: 'profile-edit',
        ),
      ),
      GoRoute(
        path: '/profile/personal-info',
        pageBuilder: (context, state) => CustomPage(
          child: const PersonalInfoScreen(),
          name: 'profile-personal-info',
        ),
      ),
      GoRoute(
        path: '/profile/addresses',
        pageBuilder: (context, state) => CustomPage(
          child: const AddressesScreen(),
          name: 'profile-addresses',
        ),
      ),
      GoRoute(
        path: '/profile/orders',
        pageBuilder: (context, state) => CustomPage(
          child: const MyOrdersScreen(),
          name: 'profile-orders',
        ),
      ),
      GoRoute(
        path: '/profile/notifications',
        pageBuilder: (context, state) => CustomPage(
          child: const NotificationsScreen(),
          name: 'profile-notifications',
        ),
      ),
      GoRoute(
        path: '/profile/payment',
        pageBuilder: (context, state) => CustomPage(
          child: const PaymentMethodScreen(),
          name: 'profile-payment',
        ),
      ),
      GoRoute(
        path: '/profile/settings',
        pageBuilder: (context, state) => CustomPage(
          child: const SettingsScreen(),
          name: 'profile-settings',
        ),
      ),
      GoRoute(
        path: '/profile/faqs',
        pageBuilder: (context, state) => CustomPage(
          name: 'profile-faqs',
          child: const Center(child: Text('FAQs')),
        ),
      ),
      GoRoute(
        path: '/profile/reviews',
        pageBuilder: (context, state) => CustomPage(
          child: const UserReviewsScreen(),
          name: 'profile-reviews',
        ),
      ),
    ],
  );
}

class CustomPage extends Page {
  final Widget child;

  const CustomPage({
    required this.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(0.0, 0.05);
        final end = Offset.zero;
        final curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var offsetAnimation = animation.drive(tween);
        var fadeAnimation = animation.drive(
          Tween(begin: 0.0, end: 1.0).chain(
            CurveTween(curve: curve),
          ),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}