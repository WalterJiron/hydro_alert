import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../domain/entities/report_category.dart';
import '../viewmodels/report_wizard_state.dart';
import '../viewmodels/report_wizard_viewmodel.dart';
import '../widgets/report_category_visuals.dart';

class ReportWizardView extends ConsumerStatefulWidget {
  const ReportWizardView({super.key});

  @override
  ConsumerState<ReportWizardView> createState() => _ReportWizardViewState();
}

class _ReportWizardViewState extends ConsumerState<ReportWizardView> {
  late final TextEditingController _descriptionController;
  final ImagePicker _imagePicker = ImagePicker();
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
                  child: _StepBar(step: state.step),
                ),
        ),
        body: state.submitted
            ? _SuccessView(
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
                    ..._buildCategoryStep(state, viewModel)
                  else
                    ..._buildEvidenceStep(state, viewModel),
                ],
              ),
      ),
    );
  }

  List<Widget> _buildCategoryStep(
    ReportWizardState state,
    ReportWizardViewModel viewModel,
  ) {
    return [
      const InfoBanner(
        icon: LucideIcons.shieldAlert,
        tone: InfoBannerTone.warning,
        title: 'Reporte comunitario',
        message:
            'Tu reporte será visible como información no verificada. No incluyas '
            'datos personales ni información sensible.',
      ),
      const SizedBox(height: 20),
      Text('¿Qué observas?', style: AppTypography.titleLarge),
      const SizedBox(height: 4),
      Text(
        'Selecciona la categoría que mejor describa la situación.',
        style: AppTypography.bodySmall,
      ),
      const SizedBox(height: 12),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ReportCategory.values.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 96,
        ),
        itemBuilder: (context, index) {
          final category = ReportCategory.values[index];
          return _CategoryOption(
            category: category,
            selected: state.draft.category == category,
            onTap: () => viewModel.selectCategory(category),
          );
        },
      ),
      const SizedBox(height: 20),
      Text('Descripción', style: AppTypography.titleSmall),
      const SizedBox(height: 8),
      TextField(
        controller: _descriptionController,
        maxLines: 4,
        maxLength: 500,
        textCapitalization: TextCapitalization.sentences,
        onChanged: viewModel.updateDescription,
        decoration: const InputDecoration(
          hintText:
              'Describe lo que ves: lugar, condiciones y cualquier riesgo inmediato.',
          alignLabelWithHint: true,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'Mínimo 10 caracteres. Sé breve y claro.',
        style: AppTypography.bodySmall,
      ),
      if (state.errorMessage != null) ...[
        const SizedBox(height: 14),
        InfoBanner(
          icon: LucideIcons.circleAlert,
          tone: InfoBannerTone.danger,
          message: state.errorMessage!,
        ),
      ],
      const SizedBox(height: 20),
      CustomButton(
        label: 'Continuar',
        icon: LucideIcons.arrowRight,
        expand: true,
        onPressed: state.canContinue ? viewModel.goToEvidence : null,
      ),
    ];
  }

  List<Widget> _buildEvidenceStep(
    ReportWizardState state,
    ReportWizardViewModel viewModel,
  ) {
    final draft = state.draft;

    return [
      Text('Ubicación', style: AppTypography.titleLarge),
      const SizedBox(height: 4),
      Text(
        'Necesitamos la ubicación del reporte. Se solicita solo cuando la pides.',
        style: AppTypography.bodySmall,
      ),
      const SizedBox(height: 10),
      AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: draft.hasLocation
                        ? AppColors.successSoft
                        : AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    LucideIcons.mapPin,
                    size: 20,
                    color: draft.hasLocation
                        ? AppColors.success
                        : AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        draft.hasLocation
                            ? 'Ubicación seleccionada'
                            : 'Ubicación pendiente',
                        style: AppTypography.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        draft.hasLocation
                            ? '${draft.latitude!.toStringAsFixed(5)}, '
                                  '${draft.longitude!.toStringAsFixed(5)}'
                            : 'Activa la ubicación para continuar.',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CustomButton(
              label: draft.hasLocation
                  ? 'Actualizar ubicación'
                  : 'Usar mi ubicación',
              icon: LucideIcons.locateFixed,
              expand: true,
              variant: AppButtonVariant.secondary,
              isLoading: state.isLocating,
              onPressed: state.isLocating ? null : viewModel.locateUser,
            ),
          ],
        ),
      ),
      const SizedBox(height: 22),
      Row(
        children: [
          Text('Foto', style: AppTypography.titleLarge),
          const SizedBox(width: 8),
          Text('(opcional)', style: AppTypography.bodySmall),
        ],
      ),
      const SizedBox(height: 4),
      Text('JPG, PNG o WebP · máximo 5 MB.', style: AppTypography.bodySmall),
      const SizedBox(height: 10),
      if (draft.photoBytes == null)
        Row(
          children: [
            Expanded(
              child: CustomButton(
                label: 'Cámara',
                icon: LucideIcons.camera,
                variant: AppButtonVariant.secondary,
                onPressed: () => _pickPhoto(ImageSource.camera),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButton(
                label: 'Galería',
                icon: LucideIcons.image,
                variant: AppButtonVariant.secondary,
                onPressed: () => _pickPhoto(ImageSource.gallery),
              ),
            ),
          ],
        )
      else
        AppCard(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  draft.photoBytes!,
                  height: 180,
                  fit: BoxFit.cover,
                  semanticLabel: 'Foto adjunta al reporte',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      draft.photoName ?? 'Foto adjunta',
                      style: AppTypography.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: viewModel.removePhoto,
                    icon: const Icon(LucideIcons.trash2, size: 16),
                    label: const Text('Quitar'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.danger,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      if (_photoError != null) ...[
        const SizedBox(height: 10),
        InfoBanner(
          icon: LucideIcons.circleAlert,
          tone: InfoBannerTone.danger,
          message: _photoError!,
        ),
      ],
      const SizedBox(height: 22),
      Text('Antes de enviar', style: AppTypography.titleLarge),
      const SizedBox(height: 10),
      AppCard(
        child: Column(
          children: [
            _Requirement(
              label: 'Categoría seleccionada',
              met: draft.category != null,
            ),
            const SizedBox(height: 8),
            _Requirement(
              label: 'Descripción de al menos 10 caracteres',
              met: draft.description.trim().length >= 10,
            ),
            const SizedBox(height: 8),
            _Requirement(
              label: 'Ubicación del reporte',
              met: draft.hasLocation,
            ),
          ],
        ),
      ),
      if (state.errorMessage != null) ...[
        const SizedBox(height: 14),
        InfoBanner(
          icon: LucideIcons.circleAlert,
          tone: InfoBannerTone.danger,
          message: state.errorMessage!,
        ),
      ],
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: CustomButton(
              label: 'Atrás',
              icon: LucideIcons.arrowLeft,
              variant: AppButtonVariant.secondary,
              onPressed: state.isSubmitting ? null : viewModel.goBack,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: CustomButton(
              label: 'Enviar reporte',
              icon: LucideIcons.send,
              isLoading: state.isSubmitting,
              onPressed: state.canSubmit ? viewModel.submit : null,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Text(
        'Al enviar, aceptas que el reporte se muestre como información comunitaria no verificada.',
        style: AppTypography.bodySmall,
        textAlign: TextAlign.center,
      ),
    ];
  }

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final file = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1600,
        imageQuality: 82,
      );
      if (file == null) {
        return;
      }

      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) {
        setState(() {
          _photoError = 'La imagen seleccionada está vacía. Intenta con otra.';
        });
        return;
      }
      if (bytes.length > 5 * 1024 * 1024) {
        setState(() {
          _photoError =
              'La imagen supera los 5 MB. Elige una foto más liviana.';
        });
        return;
      }

      final extension = file.name.toLowerCase().split('.').last;
      const allowed = {'jpg', 'jpeg', 'png', 'webp'};
      if (!allowed.contains(extension)) {
        setState(() {
          _photoError = 'Formato no compatible. Usa JPG, PNG o WebP.';
        });
        return;
      }

      ref
          .read(reportWizardViewModelProvider.notifier)
          .setPhoto(bytes: bytes, name: file.name);
      setState(() {
        _photoError = null;
      });
    } on PlatformException {
      setState(() {
        _photoError =
            'No pudimos acceder a la cámara o galería. Revisa los permisos.';
      });
    } catch (_) {
      setState(() {
        _photoError = 'No pudimos adjuntar la foto. Inténtalo de nuevo.';
      });
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

class _StepBar extends StatelessWidget {
  const _StepBar({required this.step});

  final ReportWizardStep step;

  @override
  Widget build(BuildContext context) {
    final onEvidence = step == ReportWizardStep.evidence;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          _StepSegment(
            number: 1,
            label: 'Categoría',
            isActive: !onEvidence,
            isComplete: onEvidence,
          ),
          const SizedBox(width: 8),
          _StepSegment(
            number: 2,
            label: 'Detalles',
            isActive: onEvidence,
            isComplete: false,
          ),
        ],
      ),
    );
  }
}

class _StepSegment extends StatelessWidget {
  const _StepSegment({
    required this.number,
    required this.label,
    required this.isActive,
    required this.isComplete,
  });

  final int number;
  final String label;
  final bool isActive;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final background = isActive || isComplete
        ? AppColors.primary
        : AppColors.surfaceMuted;
    final foreground = isActive || isComplete
        ? Colors.white
        : AppColors.textMuted;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarySoft : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: isComplete
                  ? const Icon(LucideIcons.check, size: 12, color: Colors.white)
                  : Text(
                      '$number',
                      style: AppTypography.labelSmall.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: AppTypography.labelMedium.copyWith(
                  color: isActive ? AppColors.primary : AppColors.textMuted,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryOption extends StatelessWidget {
  const _CategoryOption({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final ReportCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = reportCategoryColor(category);

    return Material(
      color: selected ? AppColors.primarySoft : AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  reportCategoryIcon(category),
                  size: 18,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.label,
                  style: AppTypography.labelMedium.copyWith(
                    color: selected
                        ? AppColors.primaryDark
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected)
                const Icon(
                  LucideIcons.check,
                  size: 16,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Requirement extends StatelessWidget {
  const _Requirement({required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          met ? LucideIcons.circleCheck : LucideIcons.circleAlert,
          size: 18,
          color: met ? AppColors.success : AppColors.textMuted,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: met ? AppColors.textSecondary : AppColors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.onDone, required this.onCreateAnother});

  final VoidCallback onDone;
  final VoidCallback onCreateAnother;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                color: AppColors.successSoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.checkCircle2,
                size: 42,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Reporte enviado',
              style: AppTypography.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Gracias por ayudar a tu comunidad. Tu reporte se mostrará como '
              'información no verificada.',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const InfoBanner(
              icon: LucideIcons.users,
              tone: InfoBannerTone.warning,
              message:
                  'Si la situación es una emergencia, sigue las indicaciones de '
                  'las autoridades locales.',
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Volver a reportes',
              icon: LucideIcons.arrowRight,
              expand: true,
              onPressed: onDone,
            ),
            const SizedBox(height: 8),
            CustomButton(
              label: 'Crear otro reporte',
              variant: AppButtonVariant.ghost,
              expand: true,
              onPressed: onCreateAnother,
            ),
          ],
        ),
      ),
    );
  }
}
