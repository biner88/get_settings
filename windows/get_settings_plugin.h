#ifndef FLUTTER_PLUGIN_GET_SETTINGS_PLUGIN_H_
#define FLUTTER_PLUGIN_GET_SETTINGS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>
#include <Windows.h>
#include <sstream>
namespace get_settings
{

    class GetSettingsPlugin : public flutter::Plugin
    {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        GetSettingsPlugin();

        virtual ~GetSettingsPlugin();

        // Disallow copy and assign.
        GetSettingsPlugin(const GetSettingsPlugin &) = delete;
        GetSettingsPlugin &operator=(const GetSettingsPlugin &) = delete;
        bool IsWindows11OrGreater()
        {
            OSVERSIONINFOEXW osvi = {sizeof(osvi)};
            DWORDLONG const mask = VerSetConditionMask(
                VerSetConditionMask(
                    VerSetConditionMask(
                        0, VER_MAJORVERSION, VER_GREATER_EQUAL),
                    VER_MINORVERSION, VER_GREATER_EQUAL),
                VER_BUILDNUMBER, VER_GREATER_EQUAL);

            osvi.dwMajorVersion = 10;
            osvi.dwMinorVersion = 0;
            osvi.dwBuildNumber = 22000;

            return VerifyVersionInfoW(&osvi, VER_MAJORVERSION | VER_MINORVERSION | VER_BUILDNUMBER, mask);
        }
        //
        std::string GetSystemArchitecture()
        {
            SYSTEM_INFO sysInfo;
            GetNativeSystemInfo(&sysInfo);
            std::string cpu_type;

            switch (sysInfo.wProcessorArchitecture)
            {
            case PROCESSOR_ARCHITECTURE_AMD64:
                cpu_type = "x64";
                break;
            case PROCESSOR_ARCHITECTURE_ARM:
                cpu_type = "ARM";
                break;
            case PROCESSOR_ARCHITECTURE_ARM64:
                cpu_type = "ARM64";
                break;
            case PROCESSOR_ARCHITECTURE_INTEL:
                cpu_type = "x86";
                break;
            default:
                cpu_type = "Unknown";
                break;
            }
            return cpu_type;
        }
        // Called when a method is called on this plugin's channel from Dart.
        void HandleMethodCall(
            const flutter::MethodCall<flutter::EncodableValue> &method_call,
            std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
    };

} // namespace get_settings

#endif // FLUTTER_PLUGIN_GET_SETTINGS_PLUGIN_H_
