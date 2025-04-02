#include "include/get_settings/get_settings_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "get_settings_plugin.h"

void GetSettingsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  get_settings::GetSettingsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
