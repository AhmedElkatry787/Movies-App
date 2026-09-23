import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../../auth/presentation/manager/auth_bloc.dart';
import '../../../../auth/presentation/manager/auth_event.dart';
import '../../../../auth/presentation/manager/auth_state.dart';
import '../../../../auth/presentation/manager/injection.dart';
import '../../../../core/app_colors/app_colors.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/widgets/buttom_model.dart';
import '../../../../core/widgets/movie_card.dart';
import '../../../../history/presentation/manager/history_bloc.dart';
import '../../../../history/presentation/manager/history_event.dart';
import '../../../../history/presentation/manager/history_state.dart';
import '../../../../history/presentation/manager/injection.dart';
import '../../../../movies/domain/entities/movie_entity.dart';
import '../../../../watchlist/presentation/manager/injection.dart';
import '../../../../watchlist/presentation/manager/watchlist_bloc.dart';
import '../../../../watchlist/presentation/manager/watchlist_event.dart';
import '../../../../watchlist/presentation/manager/watchlist_state.dart';
import 'edit_profile/edit_profile_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => buildAuthBloc()..add(const CurrentUserRequested())),
        BlocProvider(create: (_) => buildWatchlistBloc()..add(const WatchlistSubscriptionRequested())),
        BlocProvider(create: (_) => buildHistoryBloc()..add(const HistorySubscriptionRequested())),
      ],
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

          // The header scrolls away with the grid, so short and landscape
          // screens still have room left for the movies.
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _header(state.user)),
              _tabIndex == 0 ? _watchList() : _historyList(),
            ],
          );
        },
      ),
    );
  }

  Widget _header(UserEntity user) {
    final avatarPath = 'assets/images/p${(user.avatarIndex ?? 0) + 1}.png';

    return Container(
      color: AppColors.darkGrey,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            Row(
              children: [
                CircleAvatar(
                  radius: context.scaled(70),
                  backgroundImage: AssetImage(avatarPath),
                ),
                Expanded(
                  child: BlocBuilder<WatchlistBloc, WatchlistState>(
                    builder: (context, watchlist) => _stat(watchlist.count, 'Wish list'),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<HistoryBloc, HistoryState>(
                    builder: (context, history) => _stat(history.count, 'history'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              user.name,
              style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w700),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            // The two buttons keep the design's 255:135 split at any width.
            Row(
              children: [
                Expanded(
                  flex: 255,
                  child: CustomButton(
                    text: 'Edit Profile',
                    onPressed: () => _openEditProfile(user),
                    backgroundColor: AppColors.yellow,
                    textColor: AppColors.darkGrey,
                    height: 56,
                    borderRadius: 15,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 135,
                  child: CustomButton(
                    text: 'Exit',
                    icon: Icons.logout,
                    onPressed: () {
                      context.read<AuthBloc>().add(const LogoutRequested());
                    },
                    backgroundColor: AppColors.red,
                    textColor: AppColors.darkGrey,
                    height: 56,
                    borderRadius: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Bottom-aligned so the labels line up even though the icons differ in height.
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _tabButton('Watch List', 0, 'assets/icons/watchlist.svg')),
                Expanded(child: _tabButton('History', 1, 'assets/icons/Folder.svg')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Scales down instead of overflowing next to the avatar on narrow phones.
  Widget _stat(int count, String label) {
    const style = TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.w700);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Text('$count', style: style),
            Text(label, style: style),
          ],
        ),
      ),
    );
  }

  Widget _watchList() {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, watchlist) {
        if (watchlist.isLoading) return _loading();
        if (watchlist.movies.isEmpty) return _emptyList();
        return _moviesGrid(watchlist.movies);
      },
    );
  }

  Widget _historyList() {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, history) {
        if (history.isLoading) return _loading();
        if (history.movies.isEmpty) return _emptyList();
        return _moviesGrid(history.movies);
      },
    );
  }

  Widget _moviesGrid(List<MovieEntity> movies) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid.builder(
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 189 / 279,
        ),
        itemBuilder: (context, index) => MovieCard(movie: movies[index]),
      ),
    );
  }

  Widget _loading() {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: CircularProgressIndicator(color: AppColors.yellow)),
    );
  }

  Widget _emptyList() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Image.asset(
          'assets/images/Empty 1.png',
          width: 120,
          height: 120,
        ),
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

  Widget _tabButton(String label, int index, String iconPath) {
    final isSelected = _tabIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _tabIndex = index),
      child: Column(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w400)),
          const SizedBox(height: 24),
          Container(height: 2, color: isSelected ? AppColors.yellow : Colors.transparent),
        ],
      ),
    );
  }
}
