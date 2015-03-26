#import <substrate.h>

extern NSString *TUCallCapabilitiesEmergencyAddressKey;
extern NSString *TUCallCapabilitiesStatusKey;
extern NSString *TUCallCapabilitiesTermsAndConditionsKey;

%group fw

static NSDictionary *hook(NSDictionary *orig)
{
	NSMutableDictionary *dict = [orig mutableCopy];
	NSMutableDictionary *add = [dict[TUCallCapabilitiesEmergencyAddressKey] mutableCopy];
	add[TUCallCapabilitiesStatusKey] = @YES;
	NSMutableDictionary *term = [dict[TUCallCapabilitiesStatusKey] mutableCopy];
	term[TUCallCapabilitiesTermsAndConditionsKey] = @YES;
	dict[TUCallCapabilitiesEmergencyAddressKey] = add;
	dict[TUCallCapabilitiesStatusKey] = term;
	return dict;
}

%hook TUCallCapabilities

+ (NSDictionary *)wiFiCallingCapabilityInformation
{
	return hook(%orig);
}

+ (void)setWiFiCallingCapabilityInformation:(NSDictionary *)dict
{
	%orig(hook(dict));
}

+ (BOOL)canEnableRelayCalling
{
	return YES;
}

+ (BOOL)canEnableWiFiCalling
{
	return YES;
}

+ (BOOL)_canEnableRelayCallingDefault
{
	return YES;
}

+ (void)_setCanEnableRelayCallingDefault:(BOOL)enabled
{
	%orig(YES);
}

+ (BOOL)_supportsRelayCallingDefault
{
	return YES;
}

+ (void)_setSupportsRelayCallingDefault:(BOOL)enabled
{
	%orig(YES);
}

%end

%end

%group prefs

%hook PHSettingsWiFiCallingController

- (BOOL)_isAddressOnFile
{
	return YES;
}

- (BOOL)_isTermAndConditionsStatusOnFile
{
	return YES;
}

%end

%end

%ctor
{
	dlopen("/System/Library/PrivateFrameworks/TelephonyUtilities.framework/TelephonyUtilities", RTLD_LAZY);
	%init(fw);
	if ([NSBundle.mainBundle.bundleIdentifier isEqualToString:@"com.apple.Preferences"]) {
		%init(prefs);
	}
}