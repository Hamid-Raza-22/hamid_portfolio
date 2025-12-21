import 'package:flutter/material.dart';

/// Utility class for mapping icon names to IconData and vice versa.
/// This is necessary because IconData cannot be directly stored in Firebase.
class IconMapper {
  IconMapper._();

  static const Map<String, IconData> _iconMap = {
    // Services icons
    'phone_android_rounded': Icons.phone_android_rounded,
    'web_rounded': Icons.web_rounded,
    'palette_rounded': Icons.palette_rounded,
    'api_rounded': Icons.api_rounded,
    'cloud_rounded': Icons.cloud_rounded,
    'support_agent_rounded': Icons.support_agent_rounded,
    'speed_rounded': Icons.speed_rounded,
    'security_rounded': Icons.security_rounded,
    
    // Portfolio icons
    'favorite_rounded': Icons.favorite_rounded,
    'book_rounded': Icons.book_rounded,
    'currency_bitcoin_rounded': Icons.currency_bitcoin_rounded,
    'settings_remote_rounded': Icons.settings_remote_rounded,
    'cast_rounded': Icons.cast_rounded,
    'construction_rounded': Icons.construction_rounded,
    
    // Social icons
    'code_rounded': Icons.code_rounded,
    'work_rounded': Icons.work_rounded,
    'mail_rounded': Icons.mail_rounded,
    
    // Contact icons
    'email_rounded': Icons.email_rounded,
    'phone_rounded': Icons.phone_rounded,
    'location_on_rounded': Icons.location_on_rounded,
    
    // Achievement icons
    'compress_rounded': Icons.compress_rounded,
    'star_rounded': Icons.star_rounded,
    
    // Expertise icons
    'flutter_dash': Icons.flutter_dash,
    'settings_rounded': Icons.settings_rounded,
    'design_services_rounded': Icons.design_services_rounded,
    
    // Project icons
    'account_balance_wallet_rounded': Icons.account_balance_wallet_rounded,
    'electric_scooter_rounded': Icons.electric_scooter_rounded,
    'business_rounded': Icons.business_rounded,
    'trending_up_rounded': Icons.trending_up_rounded,
    
    // Generic icons
    'add': Icons.add,
    'edit': Icons.edit,
    'delete': Icons.delete,
    'save': Icons.save,
    'close': Icons.close,
    'check': Icons.check,
    'error': Icons.error,
    'info': Icons.info,
    'warning': Icons.warning,
    'person': Icons.person,
    'home': Icons.home,
    'menu': Icons.menu,
    'search': Icons.search,
    'settings': Icons.settings,
    'logout': Icons.logout,
    'login': Icons.login,
    'visibility': Icons.visibility,
    'visibility_off': Icons.visibility_off,
    'arrow_back': Icons.arrow_back,
    'arrow_forward': Icons.arrow_forward,
    'refresh': Icons.refresh,
    'upload': Icons.upload,
    'download': Icons.download,
    'share': Icons.share,
    'copy': Icons.copy,
    'link': Icons.link,
    'image': Icons.image,
    'video_library': Icons.video_library,
    'folder': Icons.folder,
    'file_copy': Icons.file_copy,
    'dashboard': Icons.dashboard,
    'analytics': Icons.analytics,
    'category': Icons.category,
    'list': Icons.list,
    'grid_view': Icons.grid_view,
    'view_module': Icons.view_module,
    'apps': Icons.apps,
    'widgets': Icons.widgets,
    'extension': Icons.extension,
    'integration_instructions': Icons.integration_instructions,
    'rocket_launch': Icons.rocket_launch,
    'school': Icons.school,
    'workspace_premium': Icons.workspace_premium,
    'military_tech': Icons.military_tech,
    'emoji_events': Icons.emoji_events,
  };

  /// Get IconData from icon name string
  static IconData fromString(String iconName) {
    return _iconMap[iconName] ?? Icons.help_outline;
  }

  /// Get icon name string from IconData
  static String iconToString(IconData icon) {
    for (final entry in _iconMap.entries) {
      if (entry.value == icon) {
        return entry.key;
      }
    }
    return 'help_outline';
  }

  /// Get all available icon names
  static List<String> get availableIcons => _iconMap.keys.toList();

  /// Get all available icons as map entries for selection UI
  static List<MapEntry<String, IconData>> get iconEntries =>
      _iconMap.entries.toList();
}
