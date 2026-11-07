import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/motion/app_animated_switcher.dart';
import '../services/report_photo_picker.dart';
import '../viewmodels/report_wizard_state.dart';
import '../viewmodels/report_wizard_viewmodel.dart';
import '../widgets/report_category_step.dart';
import '../widgets/report_evidence_step.dart';
import '../widgets/report_success_view.dart';
import '../widgets/report_wizard_step_bar.dart';

class ReportWizardView extends ConsumerStatefulWidget {
  const ReportWizardView({super.key});

  @override
  ConsumerState<ReportWizardView> createState() => _ReportWizardViewState();
}

class _ReportWizardViewState extends ConsumerState<ReportWizardView> {
  late final TextEditingController _descriptionController;
  final ReportPhotoPicker _photoPicker = ReportPhotoPicker();
  String? _photoError;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(reportWizardViewModelProvider).draft;
    _descriptionController = TextEditingController(text: draft.description);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportWizardViewModelProvider);
    final viewModel = ref.read(reportWizardViewModelProvider.notifier);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          viewModel.reset();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'Cerrar',
            onPressed: _close,
            icon: const Icon(LucideIcons.x, size: 22),
          ),
          title: const Text('Nuevo reporte'),
          bottom: state.submitted
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(44),
                  child: ReportWizardStepBar(step: state.step),
                ),
        ),
        body: AppAnimatedSwitcher(
          child: state.submitted
              ? ReportSuccessView(
                  key: const ValueKey('report-success'),
                  onDone: () {
                    viewModel.reset();
                    context.go('/reportes');
                  },
                  onCreateAnother: () {
                    viewModel.reset();
                    _descriptionController.clear();
                    setState(() => _photoError = null);
                  },
                )
              : ListView(
                  key: ValueKey('report-step-${state.step.name}'),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                  children: [
                    if (!AppConfig.hasBackend) ...[
                      const InfoBanner(
                        icon: LucideIcons.serverCrash,
                        title: 'Servicio no configurado',
                        message:
                            'Podrás enviar el reporte cuando se configure la URL '
                            'del backend de HydroAlert.',
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (state.step == ReportWizardStep.category)
                      ReportCategoryStep(
                        state: state,
                        descriptionController: _descriptionController,
                        onSelectCategory: viewModel.selectCategory,
                        onDescriptionChanged: viewModel.updateDescription,
                        onContinue: viewModel.goToEvidence,
                      )
                    else
                      ReportEvidenceStep(
                        state: state,
                        photoError: _photoError,
                        onLocate: viewModel.locateUser,
                        onPickCamera: _pickFromCamera,
                        onPickGallery: _pickFromGallery,
                        onRemovePhoto: viewModel.removePhoto,
                        onBack: viewModel.goBack,
                        onSubmit: viewModel.submit,
                      ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _pickFromCamera() => _pickPhoto(_photoPicker.pickFromCamera);

  Future<void> _pickFromGallery() => _pickPhoto(_photoPicker.pickFromGallery);

  Future<void> _pickPhoto(Future<ReportPhoto?> Function() pick) async {
    try {
      final photo = await pick();
      if (photo == null || !mounted) {
        return;
      }

      ref
          .read(reportWizardViewModelProvider.notifier)
          .setPhoto(bytes: photo.bytes, name: photo.name);
      setState(() => _photoError = null);
    } on ReportPhotoException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _photoError = error.message);
    }
  }

  void _close() {
    ref.read(reportWizardViewModelProvider.notifier).reset();
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/reportes');
    }
  }
}
