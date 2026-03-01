import 'package:go_router/go_router.dart';

// Import all screens
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/profile_setup_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/products/presentation/product_list_screen.dart';
import '../../features/products/presentation/search_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/checkout/presentation/checkout_screen.dart';
import '../../features/checkout/presentation/order_confirmation_screen.dart';
import '../../features/orders/presentation/orders_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/order-confirmation',
        builder: (context, state) => const OrderConfirmationScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
  );
}