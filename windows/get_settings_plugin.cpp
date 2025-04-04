#include "get_settings_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace get_settings
{

  // static
  void GetSettingsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "get_settings",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<GetSettingsPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  GetSettingsPlugin::GetSettingsPlugin() {}

  GetSettingsPlugin::~GetSettingsPlugin() {}

  void GetSettingsPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    const auto &method = method_call.method_name();
    if (method == "getPlatformVersion")
    {
      std::ostringstream version_stream;
      version_stream << "";
      if (IsWindows11OrGreater())
      {
        version_stream << "11";
      }
      else if (IsWindows10OrGreater())
      {
        version_stream << "10";
      }
      else if (IsWindows8OrGreater())
      {
        version_stream << "8";
      }
      else if (IsWindows7OrGreater())
      {
        version_stream << "7";
      }
      result->Success(flutter::EncodableValue(version_stream.str()));
    }
    else if (method == "isRotationOn")
    {
      result->Success(false);
    }
    else if (method == "isiOSAppOnMac")
    {
      result->Success(false);
    }
    else if (method == "isPad")
    {
      result->Success(false);
    }
    else if (method == "getUserAgent")
    {
      result->Success(flutter::EncodableValue(std::string("")));
    }
    else if (method == "getCPUType")
    {
      result->Success(flutter::EncodableValue(GetSystemArchitecture()));
    }
    else if (method == "ipodToPath")
    {
      result->Success(flutter::EncodableValue(std::string("")));
    }
    else if (method == "contentToPath")
    {
      result->Success(flutter::EncodableValue(std::string("")));
    }
    else
    {
      result->NotImplemented();
    }
  }

} // namespace get_settings
