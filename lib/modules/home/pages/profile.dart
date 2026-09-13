import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/manager/auth_bloc.dart';
import '../../../auth/presentation/manager/auth_event.dart';
import '../../../auth/presentation/manager/auth_state.dart';
import '../../../auth/presentation/manager/injection.dart';
import '../../../core/app_colors/app_colors.dart';
import '../../../core/routes/app_routes_name.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildAuthBloc()..add(const CurrentUserRequested()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is LoggedOut,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
          context, AppRoutesName.login, (route) => false,
        );
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: AppColors.white)),
            );
          }
          if (state is! AuthSuccess) {
            return const Center(child: CircularProgressIndicator(color: AppColors.yellow));
          }

          final user = state.user;
          final avatarPath = 'assets/images/p${(user.avatarIndex ?? 0) + 1}.png';

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Profile', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(radius: 32, backgroundImage: AssetImage(avatarPath)),
                            const Expanded(child: SizedBox()),
                            _statColumn('12', 'Wish List'),
                            const SizedBox(width: 24),
                            _statColumn('10', 'History'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(user.name, style: const TextStyle(color: AppColors.white, fontSize: 16)),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.yellow),
                                child: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  context.read<AuthBloc>().add(const LogoutRequested());
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                icon: const Icon(Icons.logout, color: Colors.white),
                                label: const Text('Exit', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _tabButton('Watch List', 0),
                      const SizedBox(width: 24),
                      _tabButton('History', 1),
                    ],
                  ),
                  const Divider(color: AppColors.darkGrey),
                  const Expanded(
                    child: Center(
                      child: Text('لسه مفيش أفلام', style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _statColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _tabButton(String label, int index) {
    final isSelected = _tabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _tabIndex = index),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: isSelected ? AppColors.yellow : Colors.grey)),
          const SizedBox(height: 4),
          if (isSelected) Container(height: 2, width: 60, color: AppColors.yellow),
        ],
      ),
    );
  }
}