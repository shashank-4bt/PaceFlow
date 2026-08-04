import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/core/di/providers.dart';
import 'package:paceflow/core/utils/validators.dart';
import 'package:paceflow/features/auth/presentation/controllers/auth_controller.dart';
import 'package:paceflow/shared/extensions/context_ext.dart';
import 'package:paceflow/shared/widgets/loading_overlay.dart';
import 'package:paceflow/shared/widgets/pf_app_bar.dart';
import 'package:paceflow/shared/widgets/pf_button.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  static const routePath = '/profile/edit';
  static const routeName = 'editProfile';

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late final TextEditingController _weightController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authControllerProvider).user!;
    _nameController = TextEditingController(text: user.displayName);
    _bioController = TextEditingController(text: user.bio ?? '');
    _weightController =
        TextEditingController(text: user.weightKg.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final user = ref.read(authControllerProvider).user!;
    final weight = double.tryParse(_weightController.text.trim()) ??
        AppConstants.defaultWeightKg;

    final success = await ref.read(authControllerProvider.notifier).updateProfile(
          user.copyWith(
            displayName: _nameController.text.trim(),
            bio: _bioController.text.trim().isEmpty
                ? null
                : _bioController.text.trim(),
            weightKg: weight,
          ),
        );

    if (!mounted) return;
    setState(() => _saving = false);

    if (success) {
      context.showSnackBar('Profile updated');
      context.pop();
    } else {
      context.showSnackBar(
        ref.read(authControllerProvider).errorMessage ?? 'Update failed',
        isError: true,
      );
    }
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (file == null || !mounted) return;

    setState(() => _saving = true);
    try {
      final user = ref.read(authControllerProvider).user!;
      final storage = ref.read(firebaseStorageProvider);
      final avatarRef =
          storage.ref().child('users/${user.uid}/avatar.jpg');
      await avatarRef.putFile(File(file.path));
      final downloadUrl = await avatarRef.getDownloadURL();

      final success =
          await ref.read(authControllerProvider.notifier).updateProfile(
                user.copyWith(photoUrl: downloadUrl),
              );
      if (mounted) {
        if (success) {
          context.showSnackBar('Photo updated');
        } else {
          context.showSnackBar('Photo upload failed', isError: true);
        }
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Photo upload failed: $error', isError: true);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PfAppBar(
        title: 'Edit Profile',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: AppSpacings.pageInsets,
              children: [
                Center(
                  child: TextButton.icon(
                    onPressed: _pickPhoto,
                    icon: const Icon(Icons.photo_camera_rounded),
                    label: const Text('Change photo'),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Display name'),
                  validator: Validators.displayName,
                ),
                const SizedBox(height: AppSpacings.md),
                TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(labelText: 'Bio'),
                  maxLength: AppConstants.bioMaxLength,
                  maxLines: 3,
                ),
                const SizedBox(height: AppSpacings.md),
                TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    suffixText: 'kg',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    final n = double.tryParse(v ?? '');
                    if (n == null || n <= 0 || n > 300) {
                      return 'Enter a valid weight';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacings.xl),
                PfButton(
                  label: 'Save Changes',
                  onPressed: _saving ? null : _save,
                  isLoading: _saving,
                ),
              ],
            ),
          ),
          LoadingOverlay(visible: _saving),
        ],
      ),
    );
  }
}
