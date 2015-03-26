SDKVERSION = 8.0
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = WiFiCallingEnabler
WiFiCallingEnabler_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
