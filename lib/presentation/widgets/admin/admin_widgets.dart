import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/icon_mapper.dart';
import '../../../core/utils/color_mapper.dart';
import '../../../domain/entities/entities.dart';
import '../../controllers/admin/admin_dashboard_controller.dart';

// ============ BASE MANAGEMENT WIDGET ============

class BaseManagementWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onAdd;
  final Widget child;
  final bool isLoading;

  const BaseManagementWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onAdd,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.primary, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Add New'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(child: child),
        ],
      ),
    );
  }
}

// ============ ITEM CARD WIDGET ============

class AdminItemCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final List<Widget>? extraInfo;

  const AdminItemCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.color,
    required this.onEdit,
    required this.onDelete,
    this.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (color ?? AppColors.primary).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color ?? AppColors.primary, size: 24),
            ),
          if (icon != null) const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (extraInfo != null) ...extraInfo!,
              ],
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, color: AppColors.primary),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: () => _showDeleteConfirm(context),
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: 'Delete',
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Delete Item?', style: TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to delete "$title"? This action cannot be undone.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              onDelete();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ============ FORM DIALOG BASE ============

class AdminFormDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onSave;
  final bool isLoading;

  const AdminFormDialog({
    super.key,
    required this.title,
    required this.children,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: isLoading ? null : onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ FORM FIELD WIDGET ============

class AdminTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final TextInputType? keyboardType;

  const AdminTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ============ ICON PICKER ============

class IconPickerField extends StatelessWidget {
  final String label;
  final String selectedIcon;
  final ValueChanged<String> onChanged;

  const IconPickerField({
    super.key,
    required this.label,
    required this.selectedIcon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showIconPicker(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(IconMapper.fromString(selectedIcon), color: AppColors.primary),
                const SizedBox(width: 12),
                Text(selectedIcon, style: const TextStyle(color: Colors.white)),
                const Spacer(),
                const Icon(Icons.arrow_drop_down, color: Colors.white70),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showIconPicker(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1E293B),
        child: SizedBox(
          width: 400,
          height: 400,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Icon',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: IconMapper.availableIcons.length,
                  itemBuilder: (context, index) {
                    final iconName = IconMapper.availableIcons[index];
                    final isSelected = iconName == selectedIcon;
                    return InkWell(
                      onTap: () {
                        onChanged(iconName);
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected ? Border.all(color: AppColors.primary) : null,
                        ),
                        child: Icon(
                          IconMapper.fromString(iconName),
                          color: isSelected ? AppColors.primary : Colors.white70,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ COLOR PICKER ============

class ColorPickerField extends StatelessWidget {
  final String label;
  final String selectedColor;
  final ValueChanged<String> onChanged;

  const ColorPickerField({
    super.key,
    required this.label,
    required this.selectedColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showColorPicker(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: ColorMapper.fromString(selectedColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Text(selectedColor, style: const TextStyle(color: Colors.white)),
                const Spacer(),
                const Icon(Icons.arrow_drop_down, color: Colors.white70),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showColorPicker(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1E293B),
        child: SizedBox(
          width: 400,
          height: 400,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select Color',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: ColorMapper.availableColors.length,
                  itemBuilder: (context, index) {
                    final colorName = ColorMapper.availableColors[index];
                    final isSelected = colorName == selectedColor;
                    return InkWell(
                      onTap: () {
                        onChanged(colorName);
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorMapper.fromString(colorName),
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 3)
                              : Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ TAGS EDITOR ============

class TagsEditorField extends StatefulWidget {
  final String label;
  final List<String> tags;
  final ValueChanged<List<String>> onChanged;

  const TagsEditorField({
    super.key,
    required this.label,
    required this.tags,
    required this.onChanged,
  });

  @override
  State<TagsEditorField> createState() => _TagsEditorFieldState();
}

class _TagsEditorFieldState extends State<TagsEditorField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...widget.tags.map((tag) => Chip(
                  label: Text(tag, style: const TextStyle(color: Colors.white)),
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white70),
                  onDeleted: () {
                    final newTags = List<String>.from(widget.tags)..remove(tag);
                    widget.onChanged(newTags);
                  },
                )),
            SizedBox(
              width: 120,
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Add tag...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  isDense: true,
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    final newTags = List<String>.from(widget.tags)..add(value);
                    widget.onChanged(newTags);
                    _controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ============ LIST EDITOR (for highlights, skills, etc.) ============

class ListEditorField extends StatefulWidget {
  final String label;
  final List<String> items;
  final ValueChanged<List<String>> onChanged;

  const ListEditorField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  State<ListEditorField> createState() => _ListEditorFieldState();
}

class _ListEditorFieldState extends State<ListEditorField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        ...widget.items.asMap().entries.map((entry) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: Colors.white70),
                    onPressed: () {
                      final newItems = List<String>.from(widget.items)..removeAt(entry.key);
                      widget.onChanged(newItems);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            )),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Add item...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  final newItems = List<String>.from(widget.items)..add(_controller.text);
                  widget.onChanged(newItems);
                  _controller.clear();
                }
              },
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ============ CATEGORY MANAGEMENT WIDGETS ============

// Profile Management
class ProfileManagement extends StatefulWidget {
  final AdminDashboardController controller;

  const ProfileManagement({super.key, required this.controller});

  @override
  State<ProfileManagement> createState() => _ProfileManagementState();
}

class _ProfileManagementState extends State<ProfileManagement> {
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _experienceController = TextEditingController();
  final _summaryController = TextEditingController();
  final _workPreferencesController = TextEditingController();
  final _locationController = TextEditingController();
  final _languagesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    final profile = widget.controller.profile.value;
    if (profile != null) {
      _nameController.text = profile.name;
      _titleController.text = profile.title;
      _experienceController.text = profile.experience;
      _summaryController.text = profile.summary;
      _workPreferencesController.text = profile.workPreferences;
      _locationController.text = profile.location;
      _languagesController.text = profile.languages;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, color: AppColors.primary, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Profile Management',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Obx(() => ElevatedButton.icon(
                    onPressed: widget.controller.isLoading.value ? null : _saveProfile,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 24),
          Obx(() {
            final profile = widget.controller.profile.value;
            if (profile != null && _nameController.text.isEmpty) {
              _loadProfile();
            }
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  AdminTextField(label: 'Name', controller: _nameController),
                  AdminTextField(label: 'Title', controller: _titleController),
                  AdminTextField(label: 'Experience', controller: _experienceController),
                  AdminTextField(label: 'Summary', controller: _summaryController, maxLines: 4),
                  AdminTextField(label: 'Work Preferences', controller: _workPreferencesController, maxLines: 2),
                  AdminTextField(label: 'Location', controller: _locationController),
                  AdminTextField(label: 'Languages', controller: _languagesController),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _saveProfile() {
    final profile = ProfileEntity(
      name: _nameController.text,
      title: _titleController.text,
      experience: _experienceController.text,
      summary: _summaryController.text,
      workPreferences: _workPreferencesController.text,
      location: _locationController.text,
      languages: _languagesController.text,
    );
    widget.controller.updateProfile(profile);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _experienceController.dispose();
    _summaryController.dispose();
    _workPreferencesController.dispose();
    _locationController.dispose();
    _languagesController.dispose();
    super.dispose();
  }
}

// Services Management
class ServicesManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ServicesManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Services',
      icon: Icons.design_services,
      onAdd: () => _showServiceDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.services.length,
            itemBuilder: (context, index) {
              final service = controller.services[index];
              return AdminItemCard(
                title: service.title,
                subtitle: service.description,
                icon: service.icon,
                color: service.color,
                onEdit: () => _showServiceDialog(context, service: service),
                onDelete: () => controller.deleteService(service.id),
              );
            },
          )),
    );
  }

  void _showServiceDialog(BuildContext context, {ServiceEntity? service}) {
    final titleController = TextEditingController(text: service?.title ?? '');
    final descController = TextEditingController(text: service?.description ?? '');
    String selectedIcon = service != null ? IconMapper.iconToString(service.icon) : 'code_rounded';
    String selectedColor = service != null ? ColorMapper.colorToString(service.color) : 'primary';

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) => AdminFormDialog(
          title: service == null ? 'Add Service' : 'Edit Service',
          onSave: () {
            final newService = ServiceEntity(
              id: service?.id ?? controller.generateId(),
              title: titleController.text,
              description: descController.text,
              icon: IconMapper.fromString(selectedIcon),
              color: ColorMapper.fromString(selectedColor),
            );
            if (service == null) {
              controller.addService(newService);
            } else {
              controller.updateService(newService);
            }
            Get.back();
          },
          children: [
            AdminTextField(label: 'Title', controller: titleController),
            AdminTextField(label: 'Description', controller: descController, maxLines: 3),
            IconPickerField(
              label: 'Icon',
              selectedIcon: selectedIcon,
              onChanged: (value) => setState(() => selectedIcon = value),
            ),
            ColorPickerField(
              label: 'Color',
              selectedColor: selectedColor,
              onChanged: (value) => setState(() => selectedColor = value),
            ),
          ],
        ),
      ),
    );
  }
}

// Portfolio Management
class PortfolioManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const PortfolioManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Portfolio',
      icon: Icons.work,
      onAdd: () => _showPortfolioDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.portfolioItems.length,
            itemBuilder: (context, index) {
              final item = controller.portfolioItems[index];
              return AdminItemCard(
                title: item.title,
                subtitle: item.description,
                icon: item.icon,
                color: item.color,
                onEdit: () => _showPortfolioDialog(context, item: item),
                onDelete: () => controller.deletePortfolioItem(item.id),
                extraInfo: [
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    children: item.tags.take(3).map((tag) => Chip(
                          label: Text(tag, style: const TextStyle(fontSize: 10, color: Colors.white)),
                          backgroundColor: item.color.withOpacity(0.3),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        )).toList(),
                  ),
                ],
              );
            },
          )),
    );
  }

  void _showPortfolioDialog(BuildContext context, {PortfolioEntity? item}) {
    final titleController = TextEditingController(text: item?.title ?? '');
    final categoryController = TextEditingController(text: item?.category ?? '');
    final descController = TextEditingController(text: item?.description ?? '');
    final urlController = TextEditingController(text: item?.projectUrl ?? '');
    String selectedIcon = item != null ? IconMapper.iconToString(item.icon) : 'folder';
    String selectedColor = item != null ? ColorMapper.colorToString(item.color) : 'primary';
    List<String> tags = List<String>.from(item?.tags ?? []);

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) => AdminFormDialog(
          title: item == null ? 'Add Portfolio Item' : 'Edit Portfolio Item',
          onSave: () {
            final newItem = PortfolioEntity(
              id: item?.id ?? controller.generateId(),
              title: titleController.text,
              category: categoryController.text,
              description: descController.text,
              icon: IconMapper.fromString(selectedIcon),
              color: ColorMapper.fromString(selectedColor),
              tags: tags,
              projectUrl: urlController.text.isEmpty ? null : urlController.text,
            );
            if (item == null) {
              controller.addPortfolioItem(newItem);
            } else {
              controller.updatePortfolioItem(newItem);
            }
            Get.back();
          },
          children: [
            AdminTextField(label: 'Title', controller: titleController),
            AdminTextField(label: 'Category', controller: categoryController),
            AdminTextField(label: 'Description', controller: descController, maxLines: 3),
            AdminTextField(label: 'Project URL (optional)', controller: urlController),
            IconPickerField(
              label: 'Icon',
              selectedIcon: selectedIcon,
              onChanged: (value) => setState(() => selectedIcon = value),
            ),
            ColorPickerField(
              label: 'Color',
              selectedColor: selectedColor,
              onChanged: (value) => setState(() => selectedColor = value),
            ),
            TagsEditorField(
              label: 'Tags',
              tags: tags,
              onChanged: (value) => setState(() => tags = value),
            ),
          ],
        ),
      ),
    );
  }
}

// Experience Management
class ExperienceManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ExperienceManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Experience',
      icon: Icons.business,
      onAdd: () => _showExperienceDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.experiences.length,
            itemBuilder: (context, index) {
              final exp = controller.experiences[index];
              return AdminItemCard(
                title: exp.title,
                subtitle: '${exp.company} • ${exp.duration}',
                icon: Icons.work,
                onEdit: () => _showExperienceDialog(context, experience: exp),
                onDelete: () => controller.deleteExperience(exp.id),
              );
            },
          )),
    );
  }

  void _showExperienceDialog(BuildContext context, {ExperienceEntity? experience}) {
    final titleController = TextEditingController(text: experience?.title ?? '');
    final companyController = TextEditingController(text: experience?.company ?? '');
    final locationController = TextEditingController(text: experience?.location ?? '');
    final durationController = TextEditingController(text: experience?.duration ?? '');
    List<String> highlights = List<String>.from(experience?.highlights ?? []);

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) => AdminFormDialog(
          title: experience == null ? 'Add Experience' : 'Edit Experience',
          onSave: () {
            final newExp = ExperienceEntity(
              id: experience?.id ?? controller.generateId(),
              title: titleController.text,
              company: companyController.text,
              location: locationController.text,
              duration: durationController.text,
              highlights: highlights,
            );
            if (experience == null) {
              controller.addExperience(newExp);
            } else {
              controller.updateExperience(newExp);
            }
            Get.back();
          },
          children: [
            AdminTextField(label: 'Job Title', controller: titleController),
            AdminTextField(label: 'Company', controller: companyController),
            AdminTextField(label: 'Location', controller: locationController),
            AdminTextField(label: 'Duration', controller: durationController),
            ListEditorField(
              label: 'Highlights',
              items: highlights,
              onChanged: (value) => setState(() => highlights = value),
            ),
          ],
        ),
      ),
    );
  }
}

// Projects Management
class ProjectsManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ProjectsManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Projects',
      icon: Icons.folder,
      onAdd: () => _showProjectDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.projectDetails.length,
            itemBuilder: (context, index) {
              final project = controller.projectDetails[index];
              return AdminItemCard(
                title: project.title,
                subtitle: '${project.category} • ${project.year}',
                icon: project.icon,
                color: project.color,
                onEdit: () => _showProjectDialog(context, project: project),
                onDelete: () => controller.deleteProjectDetail(project.id),
              );
            },
          )),
    );
  }

  void _showProjectDialog(BuildContext context, {ProjectDetailEntity? project}) {
    final titleController = TextEditingController(text: project?.title ?? '');
    final categoryController = TextEditingController(text: project?.category ?? '');
    final yearController = TextEditingController(text: project?.year ?? '');
    final descController = TextEditingController(text: project?.description ?? '');
    final urlController = TextEditingController(text: project?.url ?? '');
    String selectedIcon = project != null ? IconMapper.iconToString(project.icon) : 'folder';
    String selectedColor = project != null ? ColorMapper.colorToString(project.color) : 'primary';
    List<String> highlights = List<String>.from(project?.highlights ?? []);
    List<String> tags = List<String>.from(project?.tags ?? []);

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) => AdminFormDialog(
          title: project == null ? 'Add Project' : 'Edit Project',
          onSave: () {
            final newProject = ProjectDetailEntity(
              id: project?.id ?? controller.generateId(),
              title: titleController.text,
              category: categoryController.text,
              year: yearController.text,
              description: descController.text,
              icon: IconMapper.fromString(selectedIcon),
              color: ColorMapper.fromString(selectedColor),
              highlights: highlights,
              tags: tags,
              url: urlController.text.isEmpty ? null : urlController.text,
            );
            if (project == null) {
              controller.addProjectDetail(newProject);
            } else {
              controller.updateProjectDetail(newProject);
            }
            Get.back();
          },
          children: [
            AdminTextField(label: 'Title', controller: titleController),
            AdminTextField(label: 'Category', controller: categoryController),
            AdminTextField(label: 'Year', controller: yearController),
            AdminTextField(label: 'Description', controller: descController, maxLines: 3),
            AdminTextField(label: 'URL (optional)', controller: urlController),
            IconPickerField(
              label: 'Icon',
              selectedIcon: selectedIcon,
              onChanged: (value) => setState(() => selectedIcon = value),
            ),
            ColorPickerField(
              label: 'Color',
              selectedColor: selectedColor,
              onChanged: (value) => setState(() => selectedColor = value),
            ),
            ListEditorField(
              label: 'Highlights',
              items: highlights,
              onChanged: (value) => setState(() => highlights = value),
            ),
            TagsEditorField(
              label: 'Tags',
              tags: tags,
              onChanged: (value) => setState(() => tags = value),
            ),
          ],
        ),
      ),
    );
  }
}

// Education Management
class EducationManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const EducationManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Education',
      icon: Icons.school,
      onAdd: () => _showEducationDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.education.length,
            itemBuilder: (context, index) {
              final edu = controller.education[index];
              return AdminItemCard(
                title: edu.degree,
                subtitle: '${edu.institution} • ${edu.duration}',
                icon: Icons.school,
                onEdit: () => _showEducationDialog(context, education: edu),
                onDelete: () => controller.deleteEducation(edu.id),
              );
            },
          )),
    );
  }

  void _showEducationDialog(BuildContext context, {EducationEntity? education}) {
    final degreeController = TextEditingController(text: education?.degree ?? '');
    final institutionController = TextEditingController(text: education?.institution ?? '');
    final durationController = TextEditingController(text: education?.duration ?? '');
    final cgpaController = TextEditingController(text: education?.cgpa ?? '');
    final specializationController = TextEditingController(text: education?.specialization ?? '');
    final projectController = TextEditingController(text: education?.project ?? '');

    Get.dialog(
      AdminFormDialog(
        title: education == null ? 'Add Education' : 'Edit Education',
        onSave: () {
          final newEdu = EducationEntity(
            id: education?.id ?? controller.generateId(),
            degree: degreeController.text,
            institution: institutionController.text,
            duration: durationController.text,
            cgpa: cgpaController.text,
            specialization: specializationController.text,
            project: projectController.text,
          );
          if (education == null) {
            controller.addEducation(newEdu);
          } else {
            controller.updateEducation(newEdu);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Degree', controller: degreeController),
          AdminTextField(label: 'Institution', controller: institutionController),
          AdminTextField(label: 'Duration', controller: durationController),
          AdminTextField(label: 'CGPA', controller: cgpaController),
          AdminTextField(label: 'Specialization', controller: specializationController),
          AdminTextField(label: 'Project', controller: projectController),
        ],
      ),
    );
  }
}

// Certifications Management
class CertificationsManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const CertificationsManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Certifications',
      icon: Icons.workspace_premium,
      onAdd: () => _showCertificationDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.certifications.length,
            itemBuilder: (context, index) {
              final cert = controller.certifications[index];
              return AdminItemCard(
                title: cert.title,
                subtitle: '${cert.issuer} • ${cert.year}',
                icon: Icons.workspace_premium,
                onEdit: () => _showCertificationDialog(context, certification: cert),
                onDelete: () => controller.deleteCertification(cert.id),
              );
            },
          )),
    );
  }

  void _showCertificationDialog(BuildContext context, {CertificationEntity? certification}) {
    final titleController = TextEditingController(text: certification?.title ?? '');
    final issuerController = TextEditingController(text: certification?.issuer ?? '');
    final yearController = TextEditingController(text: certification?.year ?? '');

    Get.dialog(
      AdminFormDialog(
        title: certification == null ? 'Add Certification' : 'Edit Certification',
        onSave: () {
          final newCert = CertificationEntity(
            id: certification?.id ?? controller.generateId(),
            title: titleController.text,
            issuer: issuerController.text,
            year: yearController.text,
          );
          if (certification == null) {
            controller.addCertification(newCert);
          } else {
            controller.updateCertification(newCert);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Title', controller: titleController),
          AdminTextField(label: 'Issuer', controller: issuerController),
          AdminTextField(label: 'Year', controller: yearController),
        ],
      ),
    );
  }
}

// Expertise Management
class ExpertiseManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ExpertiseManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Skills & Expertise',
      icon: Icons.code,
      onAdd: () => _showExpertiseDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.expertise.length,
            itemBuilder: (context, index) {
              final exp = controller.expertise[index];
              return AdminItemCard(
                title: exp.title,
                subtitle: '${exp.skills.length} skills',
                icon: exp.icon,
                color: exp.color,
                onEdit: () => _showExpertiseDialog(context, expertise: exp),
                onDelete: () => controller.deleteExpertise(exp.id),
              );
            },
          )),
    );
  }

  void _showExpertiseDialog(BuildContext context, {ExpertiseEntity? expertise}) {
    final titleController = TextEditingController(text: expertise?.title ?? '');
    String selectedIcon = expertise != null ? IconMapper.iconToString(expertise.icon) : 'code_rounded';
    String selectedColor = expertise != null ? ColorMapper.colorToString(expertise.color) : 'primary';
    List<String> skills = List<String>.from(expertise?.skills ?? []);

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) => AdminFormDialog(
          title: expertise == null ? 'Add Expertise' : 'Edit Expertise',
          onSave: () {
            final newExp = ExpertiseEntity(
              id: expertise?.id ?? controller.generateId(),
              title: titleController.text,
              icon: IconMapper.fromString(selectedIcon),
              color: ColorMapper.fromString(selectedColor),
              skills: skills,
            );
            if (expertise == null) {
              controller.addExpertise(newExp);
            } else {
              controller.updateExpertise(newExp);
            }
            Get.back();
          },
          children: [
            AdminTextField(label: 'Title', controller: titleController),
            IconPickerField(
              label: 'Icon',
              selectedIcon: selectedIcon,
              onChanged: (value) => setState(() => selectedIcon = value),
            ),
            ColorPickerField(
              label: 'Color',
              selectedColor: selectedColor,
              onChanged: (value) => setState(() => selectedColor = value),
            ),
            ListEditorField(
              label: 'Skills',
              items: skills,
              onChanged: (value) => setState(() => skills = value),
            ),
          ],
        ),
      ),
    );
  }
}

// Achievements Management
class AchievementsManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const AchievementsManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Achievements',
      icon: Icons.emoji_events,
      onAdd: () => _showAchievementDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.achievements.length,
            itemBuilder: (context, index) {
              final ach = controller.achievements[index];
              return AdminItemCard(
                title: ach.text,
                icon: ach.icon,
                onEdit: () => _showAchievementDialog(context, achievement: ach),
                onDelete: () => controller.deleteAchievement(ach.id),
              );
            },
          )),
    );
  }

  void _showAchievementDialog(BuildContext context, {AchievementEntity? achievement}) {
    final textController = TextEditingController(text: achievement?.text ?? '');
    String selectedIcon = achievement != null ? IconMapper.iconToString(achievement.icon) : 'star_rounded';

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) => AdminFormDialog(
          title: achievement == null ? 'Add Achievement' : 'Edit Achievement',
          onSave: () {
            final newAch = AchievementEntity(
              id: achievement?.id ?? controller.generateId(),
              icon: IconMapper.fromString(selectedIcon),
              text: textController.text,
            );
            if (achievement == null) {
              controller.addAchievement(newAch);
            } else {
              controller.updateAchievement(newAch);
            }
            Get.back();
          },
          children: [
            AdminTextField(label: 'Achievement Text', controller: textController, maxLines: 2),
            IconPickerField(
              label: 'Icon',
              selectedIcon: selectedIcon,
              onChanged: (value) => setState(() => selectedIcon = value),
            ),
          ],
        ),
      ),
    );
  }
}

// Contact Management
class ContactManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const ContactManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Contact Info',
      icon: Icons.contact_mail,
      onAdd: () => _showContactDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.contactInfo.length,
            itemBuilder: (context, index) {
              final info = controller.contactInfo[index];
              return AdminItemCard(
                title: info.title,
                subtitle: info.value,
                icon: info.icon,
                color: info.color,
                onEdit: () => _showContactDialog(context, contact: info),
                onDelete: () => controller.deleteContactInfo(info.id),
              );
            },
          )),
    );
  }

  void _showContactDialog(BuildContext context, {ContactInfoEntity? contact}) {
    final titleController = TextEditingController(text: contact?.title ?? '');
    final valueController = TextEditingController(text: contact?.value ?? '');
    final actionTypeController = TextEditingController(text: contact?.actionType ?? '');
    String selectedIcon = contact != null ? IconMapper.iconToString(contact.icon) : 'email_rounded';
    String selectedColor = contact != null ? ColorMapper.colorToString(contact.color) : 'primary';

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) => AdminFormDialog(
          title: contact == null ? 'Add Contact Info' : 'Edit Contact Info',
          onSave: () {
            final newContact = ContactInfoEntity(
              id: contact?.id ?? controller.generateId(),
              title: titleController.text,
              value: valueController.text,
              icon: IconMapper.fromString(selectedIcon),
              color: ColorMapper.fromString(selectedColor),
              actionType: actionTypeController.text,
            );
            if (contact == null) {
              controller.addContactInfo(newContact);
            } else {
              controller.updateContactInfo(newContact);
            }
            Get.back();
          },
          children: [
            AdminTextField(label: 'Title', controller: titleController, hint: 'e.g., Email, Phone'),
            AdminTextField(label: 'Value', controller: valueController, hint: 'e.g., email@example.com'),
            AdminTextField(label: 'Action Type', controller: actionTypeController, hint: 'e.g., email, phone, whatsapp'),
            IconPickerField(
              label: 'Icon',
              selectedIcon: selectedIcon,
              onChanged: (value) => setState(() => selectedIcon = value),
            ),
            ColorPickerField(
              label: 'Color',
              selectedColor: selectedColor,
              onChanged: (value) => setState(() => selectedColor = value),
            ),
          ],
        ),
      ),
    );
  }
}

// Social Links Management
class SocialLinksManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const SocialLinksManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Social Links',
      icon: Icons.share,
      onAdd: () => _showSocialLinkDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.socialLinks.length,
            itemBuilder: (context, index) {
              final link = controller.socialLinks[index];
              return AdminItemCard(
                title: link.name,
                subtitle: link.url,
                icon: link.icon,
                onEdit: () => _showSocialLinkDialog(context, link: link),
                onDelete: () => controller.deleteSocialLink(link.id),
              );
            },
          )),
    );
  }

  void _showSocialLinkDialog(BuildContext context, {SocialLinkEntity? link}) {
    final nameController = TextEditingController(text: link?.name ?? '');
    final urlController = TextEditingController(text: link?.url ?? '');
    String selectedIcon = link != null ? IconMapper.iconToString(link.icon) : 'link';

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) => AdminFormDialog(
          title: link == null ? 'Add Social Link' : 'Edit Social Link',
          onSave: () {
            final newLink = SocialLinkEntity(
              id: link?.id ?? controller.generateId(),
              name: nameController.text,
              url: urlController.text,
              icon: IconMapper.fromString(selectedIcon),
            );
            if (link == null) {
              controller.addSocialLink(newLink);
            } else {
              controller.updateSocialLink(newLink);
            }
            Get.back();
          },
          children: [
            AdminTextField(label: 'Name', controller: nameController, hint: 'e.g., GitHub, LinkedIn'),
            AdminTextField(label: 'URL', controller: urlController, hint: 'https://...'),
            IconPickerField(
              label: 'Icon',
              selectedIcon: selectedIcon,
              onChanged: (value) => setState(() => selectedIcon = value),
            ),
          ],
        ),
      ),
    );
  }
}

// Stats Management
class StatsManagement extends StatelessWidget {
  final AdminDashboardController controller;

  const StatsManagement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BaseManagementWidget(
      title: 'Statistics',
      icon: Icons.analytics,
      onAdd: () => _showStatDialog(context),
      child: Obx(() => ListView.builder(
            itemCount: controller.stats.length,
            itemBuilder: (context, index) {
              final stat = controller.stats[index];
              return AdminItemCard(
                title: stat.value,
                subtitle: stat.label,
                icon: Icons.analytics,
                onEdit: () => _showStatDialog(context, stat: stat),
                onDelete: () => controller.deleteStat(stat.id),
              );
            },
          )),
    );
  }

  void _showStatDialog(BuildContext context, {StatEntity? stat}) {
    final valueController = TextEditingController(text: stat?.value ?? '');
    final labelController = TextEditingController(text: stat?.label ?? '');

    Get.dialog(
      AdminFormDialog(
        title: stat == null ? 'Add Stat' : 'Edit Stat',
        onSave: () {
          final newStat = StatEntity(
            id: stat?.id ?? controller.generateId(),
            value: valueController.text,
            label: labelController.text,
          );
          if (stat == null) {
            controller.addStat(newStat);
          } else {
            controller.updateStat(newStat);
          }
          Get.back();
        },
        children: [
          AdminTextField(label: 'Value', controller: valueController, hint: 'e.g., 50+'),
          AdminTextField(label: 'Label', controller: labelController, hint: 'e.g., Projects Completed'),
        ],
      ),
    );
  }
}
