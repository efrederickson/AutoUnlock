ARCHS = armv7 armv7s arm64
include theos/makefiles/common.mk

TWEAK_NAME = AutoUnlock
AutoUnlock_FILES = Tweak.xm
AutoUnlock_FRAMEWORKS = CoreGraphics UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
