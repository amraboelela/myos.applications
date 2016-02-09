
LDLIBS=-lFoundation

ifeq ($(APP_TYPE),NativeApp)
    LDLIBS+=-lOpenGLES_native -lUIKit_native -lCoreGraphics_native -lQuartzCore_native
else
    LDLIBS+=-lOpenGLES -lUIKit -lCoreGraphics -lQuartzCore
endif

OBJECTS = \
    AppDelegate.o \
    CircleView.o \

include ${MYOS_PATH}/sdk/app-makefile
