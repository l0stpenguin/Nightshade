include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Nightshade
Nightshade_FILES = $(wildcard *.xm) $(wildcard CompatabilityLayer/*.xm)
Nightshade_FRAMEWORKS = UIKit Foundation
Nightshade_LIBRARIES = sparkapplist
Nightshade_LDFLAGS += -lCSColorPicker
Nightshade_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += NightshadePrefs
include $(THEOS_MAKE_PATH)/aggregate.mk

