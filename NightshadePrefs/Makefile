include $(THEOS)/makefiles/common.mk

ARCHS = arm64
BUNDLE_NAME = NightshadePrefs
NightshadePrefs_FILES = $(wildcard *.m)
NightshadePrefs_INSTALL_PATH = /Library/PreferenceBundles
NightshadePrefs_FRAMEWORKS = UIKit Foundation
NightshadePrefs_PRIVATE_FRAMEWORKS = Preferences
NightshadePrefs_LDFLAGS += -lCSColorPicker
NightshadePrefs_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NightshadePrefs.plist$(ECHO_END)
