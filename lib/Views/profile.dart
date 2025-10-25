import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/Views/Auth/AuthStates.dart';
import 'package:meal_app/Views/Auth/Authcubit.dart';
import 'package:meal_app/Views/Auth/Pages/Login.dart';
import 'package:meal_app/Core/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Profile Header
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  BlocBuilder<AuthCubit, AppAuthState>(
                    builder: (context, state) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state is AuthAuthenticated
                                  ? state.user.fullName ?? ''
                                  : '',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              state is AuthAuthenticated
                                  ? state.user.email ?? ''
                                  : '',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // Settings Section
          Text(
            'Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          // Dark Mode Toggle Card
          Card(
            child: ListTile(
              leading: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: Colors.orange,
              ),
              title: Text('Dark Mode'),
              trailing: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Switch(
                    value: context.read<ThemeCubit>().isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    activeColor: Colors.orange,
                  );
                },
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.orange),
              title: Text('Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.orange,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.language, color: Colors.orange),
              title: Text('Language'),
              subtitle: Text('English'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),

          SizedBox(height: 20),

          // Other Options
          Text(
            'Other',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.orange),
              title: Text('My Orders'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.favorite, color: Colors.orange),
              title: Text('Favorites'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.help, color: Colors.orange),
              title: Text('Help & Support'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ),

          SizedBox(height: 20),

          // Logout Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Logout', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
