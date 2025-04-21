import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
        
          const SizedBox(height: 24),
          _buildSection(
            title: 'Privacy & Security',
            children: [
              _buildSettingTile(
                icon: Iconsax.security,
                title: 'Privacy Settings',
                subtitle: 'Manage your privacy preferences',
                onTap: () {},
              ),
              _buildSettingTile(
                icon: Iconsax.password_check,
                title: 'Change Password',
                subtitle: 'Update your password',
                onTap: () {},
              ),
          
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'About',
            children: [
              _buildSettingTile(
                icon: Iconsax.info_circle,
                title: 'About App',
                subtitle: 'Version 1.0.0',
                onTap: () {},
              ),
              _buildSettingTile(
                icon: Iconsax.document,
                title: 'Terms of Service',
                subtitle: 'Read our terms and conditions',
                onTap: () {},
              ),
              _buildSettingTile(
                icon: Iconsax.shield,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
} 