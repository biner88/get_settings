//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <get_settings/get_settings_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) get_settings_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "GetSettingsPlugin");
  get_settings_plugin_register_with_registrar(get_settings_registrar);
}
