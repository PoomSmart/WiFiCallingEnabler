%hook TUCallCapabilities

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

%ctor
{
	dlopen("/System/Library/PrivateFrameworks/TelephonyUtilities.framework/TelephonyUtilities", RTLD_LAZY);
	%init;
}