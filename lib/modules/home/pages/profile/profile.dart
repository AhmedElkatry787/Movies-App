import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../../auth/presentation/manager/auth_bloc.dart';
import '../../../../auth/presentation/manager/auth_event.dart';
import '../../../../auth/presentation/manager/auth_state.dart';
import '../../../../auth/presentation/manager/injection.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/widgets/buttom_model.dart';
import 'edit_profile/edit_profile_screen.dart';

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

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkGrey,
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 52),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage(avatarPath)
                          ),
                          Column(
                            children: [
                              Text("12", style: const TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                              Text('Wish list ', style: const TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Column(
                            children: [
                              Text("12", style: const TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                              Text(' history ', style: const TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                          user.name,
                          style:TextStyle(
                              color: AppColors.white,
                              fontSize: 20, fontWeight: FontWeight.w700
                          ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            text: 'Edit Profile',
                            onPressed: () => _openEditProfile(user),
                            backgroundColor: AppColors.yellow,
                            textColor: AppColors.darkGrey,
                            height: 56,
                            borderRadius: 15,
                            width: 255,
                          ),
                           SizedBox(width: 10),
                          CustomButton(
                            text: 'ُExit',
                            icon: Icons.logout,
                            onPressed: () {
                              context.read<AuthBloc>().add(const LogoutRequested());
                              },
                            backgroundColor: AppColors.red,
                            textColor: AppColors.darkGrey,
                            height: 56,
                            borderRadius: 15,
                            width: 135,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: _tabButton('Watch List', 0,'assets/icons/watchlist.svg')),
                          Expanded(child: _tabButton('History', 1,'assets/icons/Folder.svg')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
               Expanded(
                 child: Center(
                     child: Image.asset(
                       'assets/images/Empty 1.png',
                       width: 120,
                       height: 120,
                     ),
                 ),
               ),
            ],
          );
        },
      ),
    );
  }


  Future<void> _openEditProfile(UserEntity user) async {
    final bloc = context.read<AuthBloc>();

    final updated = await Navigator.push<UserEntity>(
      context,
      MaterialPageRoute(builder: (_) => EditProfileScreen(user: user)),
    );

    if (updated == null) return;
    bloc.add(const CurrentUserRequested());
  }

  Widget _tabButton(String label, int index,String iconPath) {
    final isSelected = _tabIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _tabIndex = index),
      child: Column(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color : AppColors.white, fontSize: 20, fontWeight: FontWeight.w400)),
          const SizedBox(height: 24),
          if (isSelected) Container(height: 2, width: 250, color: AppColors.yellow),
        ],
      ),
    );
  }
}