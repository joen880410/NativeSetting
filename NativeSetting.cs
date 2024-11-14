using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class NativeSetting
{
    public static Action SettingCallback;
#if !UNITY_EDITOR && UNITY_ANDROID
    private static AndroidJavaClass m_ajc = null;
    private static AndroidJavaClass AJC
    {
        get
        {
            if (m_ajc == null)
                m_ajc = new AndroidJavaClass("com.smile.unity.NativeSetting");

            return m_ajc;
        }
    }
    public static void OpenAppSettings()
    {
        AJC.CallStatic("OpenAppSettings");
        Application.focusChanged += FocusChanged;
    }

    public static void FocusChanged(bool hasFocus)
    {
        if (hasFocus)
            SettingCallback?.Invoke();
        Application.focusChanged -= FocusChanged;
    }
#elif UNITY_EDITOR && UNITY_IOS
	[DllImport( "__Internal" )]
	private static extern void _NativeSetting_Setting(string title_Str, string message_Str, string open_Str, string cancel_Str);
#endif
    public static void SetSettingBox(string title_Str, string message_Str, string open_Str, string cancel_Str)
    {
#if !UNITY_EDITOR && UNITY_IOS
        _NativeSetting_Setting(title_Str, message_Str, string, cancel_Str);
#elif !UNITY_EDITOR && UNITY_ANDROID
        OpenAppSettings();
#endif
    }
}