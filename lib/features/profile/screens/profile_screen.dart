import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bhakti Gharat',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '(91) 123-456-789',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.push('/profile/edit');
                    },
                    icon: const Icon(
                      Iconsax.edit,
                      color: Color(0xFFFF1493),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Profile Menu Items
              _buildMenuItem(
                context,
                icon: Iconsax.user,
                title: 'Personal Info',
                color: Colors.blue,
                onTap: () => context.push('/profile/personal-info'),
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.location,
                title: 'Addresses',
                color: Colors.blue,
                onTap: () => context.push('/profile/addresses'),
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.bag,
                title: 'My orders',
                color: Colors.blue,
                onTap: () => context.push('/profile/orders'),
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.heart,
                title: 'Wishlist',
                color: Colors.purple,
                onTap: () => context.push('/profile/wishlist'),
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.notification,
                title: 'Notifications',
                color: Colors.orange,
                onTap: () => context.push('/profile/notifications'),
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.card,
                title: 'Payment Method',
                color: Colors.blue,
                onTap: () => context.push('/profile/payment'),
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                context,
                icon: Iconsax.message_question,
                title: 'FAQs',
                color: Colors.orange,
                onTap: () => context.push('/profile/faqs'),
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.star,
                title: 'User Reviews',
                color: Colors.teal,
                onTap: () => context.push('/profile/reviews'),
              ),
              _buildMenuItem(
                context,
                icon: Iconsax.setting_2,
                title: 'Settings',
                color: Colors.blue,
                onTap: () => context.push('/profile/settings'),
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                context,
                icon: Iconsax.logout,
                title: 'Log Out',
                color: Colors.red,
                onTap: () {
                  // Handle logout
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 0,
        color: Colors.grey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: color),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
} 