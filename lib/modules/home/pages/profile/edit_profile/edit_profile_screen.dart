import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../auth/domain/entities/user_entity.dart';
import '../../../../../auth/presentation/manager/auth_bloc.dart';
import '../../../../../auth/presentation/manager/auth_event.dart';
import '../../../../../auth/presentation/manager/auth_state.dart';
import '../../../../../auth/presentation/manager/injection.dart';
import '../../../../../core/app_colors/app_colors.dart';
import '../../../../../core/routes/app_routes_name.dart';
import '../../../../../model/buttom_model.dart';
import '../../../../../model/textfromfield_model.dart';
import 'widgets/avatar_grid.dart';

class EditProfileScreen extends StatelessWidget {
  final UserEntity user;

  const EditProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => buildAuthBloc(),
      child: _EditProfileView(user: user),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  final UserEntity user;

  const _EditProfileView({required this.user});

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  late int _avatarIndex;
  bool _isGridOpen = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _avatarIndex = widget.user.avatarIndex ?? 0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String get _name => _nameController.text.trim();
  String get _phone => _phoneController.text.trim();
  bool get _nameChanged => _name != widget.user.name;
  bool get _phoneChanged => _phone != (widget.user.phone ?? '');
  bool get _avatarChanged => _avatarIndex != (widget.user.avatarIndex ?? 0);

  bool get _hasChanges => _nameChanged || _phoneChanged || _avatarChanged;

  void _selectAvatar(int index) {
    setState(() {
      _avatarIndex = index;
      _isGridOpen = false;
    });
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<AuthBloc>().add(
      UpdateProfileRequested(
        original: widget.user,
        name: _name,
        phone: _phone,
        avatarIndex: _avatarIndex,
      ),
    );
  }

  Future<bool> _confirmDiscard() async {
    if (!_hasChanges) return true;

    final discard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.darkGrey,
        title: const Text(
          'Discard changes?',
          style: TextStyle(color: AppColors.white),
        ),
        content: const Text(
          'You have unsaved changes. Leave without updating?',
          style: TextStyle(color: AppColors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Keep editing', style: TextStyle(color: AppColors.yellow)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Discard', style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
    );

    return discard ?? false;
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.darkGrey,
        title: const Text(
          'Delete account?',
          style: TextStyle(color: AppColors.white),
        ),
        content: const Text(
          'This permanently removes your account and data. It cannot be undone.',
          style: TextStyle(color: AppColors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.yellow)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete', style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    context.read<AuthBloc>().add(const DeleteAccountRequested());
  }

  void _resetPassword() {
    context.read<AuthBloc>().add(
      ForgetPasswordRequested(email: widget.user.email),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        setState(() => _isSaving = state is AuthLoading);

        if (state is ProfileUpdated) {
          Navigator.pop(context, state.user);
        } else if (state is ProfileUnchanged) {
          _showMessage('Nothing changed yet');
        } else if (state is PasswordResetEmailSent) {
          _showMessage('Password reset link sent to ${widget.user.email}');
        } else if (state is AccountDeleted) {
          Navigator.pushNamedAndRemoveUntil(
            context, AppRoutesName.login, (route) => false,
          );
        } else if (state is AuthError) {
          _showMessage(state.message);
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final shouldPop = await _confirmDiscard();
          if (!context.mounted) return;
          if (shouldPop) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.darkBackground,
          appBar: AppBar(
            backgroundColor: AppColors.darkBackground,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.yellow),
              onPressed: () => Navigator.maybePop(context),
            ),
            title: const Text(
              'Pick Avatar',
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Center(
                            child: GestureDetector(
                              onTap: () => setState(() => _isGridOpen = !_isGridOpen),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: AppColors.darkGrey,
                                backgroundImage:
                                    AssetImage(AvatarGrid.assetFor(_avatarIndex)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          CustomTextFormField(
                            controller: _nameController,
                            prefixIcon: Icons.person,
                            hintText: 'Name',
                            fillColor: AppColors.darkGrey,
                            height: 56,
                            onChanged: (_) => setState(() {}),
                            validator: (value) =>
                                (value?.trim().isEmpty ?? true) ? 'Name is required' : null,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            controller: _phoneController,
                            prefixIcon: Icons.phone,
                            hintText: 'Phone Number',
                            keyboardType: TextInputType.phone,
                            fillColor: AppColors.darkGrey,
                            height: 56,
                            onChanged: (_) => setState(() {}),
                            validator: (value) =>
                                (value?.trim().isEmpty ?? true) ? 'Phone is required' : null,
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: _resetPassword,
                            child: const Text(
                              'Reset Password',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 75),
                          if (_isGridOpen)
                            AvatarGrid(
                              selectedIndex: _avatarIndex,
                              onSelected: _selectAvatar,
                            ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  if (!_isGridOpen)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        children: [
                          CustomButton(
                            text: 'Delete Account',
                            onPressed: _isSaving ? null : _confirmDelete,
                            backgroundColor: AppColors.red,
                            textColor: AppColors.white,
                            disabledBackgroundColor: AppColors.red,
                            disabledTextColor: AppColors.white,
                            height: 56,
                            borderRadius: 15,
                          ),
                          SizedBox(height: 19),
                          CustomButton(
                            text: _isSaving ? 'Updating...' : 'Update Data',
                            onPressed: _hasChanges && !_isSaving ? _submit : null,
                            backgroundColor: AppColors.yellow,
                            textColor: AppColors.darkBackground,
                            disabledBackgroundColor: AppColors.yellow,
                            disabledTextColor: AppColors.darkBackground,
                            height: 56,
                            borderRadius: 15,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
