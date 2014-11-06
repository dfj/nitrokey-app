#-------------------------------------------------
#
# Project created by QtCreator 2014-07-06T17:56:57
#
#-------------------------------------------------

CONFIG   += qt
CONFIG   +=link_pkgconfig
QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets


TARGET = CryptoStickGUI
TEMPLATE = app

SOURCES += main.cpp\
        mainwindow.cpp \
    hotpslot.cpp \
    totpslot.cpp \
    stick20window.cpp \
    stick20updatedialog.cpp \
    stick20setup.cpp \
    stick20responsedialog.cpp \
    stick20matrixpassworddialog.cpp \
    stick20lockfirmwaredialog.cpp \
    stick20infodialog.cpp \
    stick20hiddenvolumedialog.cpp \
    stick20dialog.cpp \
    stick20debugdialog.cpp \
    stick20changepassworddialog.cpp \
    response.cpp \
    passworddialog.cpp \
    hotpdialog.cpp \
    device.cpp \
    crc32.cpp \
    command.cpp \
    base32.cpp \
    aboutdialog.cpp \
    stick20hid.c \
    passwordsafedialog.cpp \
    securitydialog.cpp

win32 {
 SOURCES +=   hid_win.c
}

macx{
 SOURCES +=   hid_mac.c
}

unix:!macx{
    INCLUDEPATH += "/usr/include/libappindicator-0.1"
    INCLUDEPATH += "/usr/include/gtk-2.0"
    INCLUDEPATH += "/usr/include/glib-2.0"
    INCLUDEPATH += "/usr/lib/x86_64-linux-gnu/glib-2.0/include"
    INCLUDEPATH += "/usr/include/cairo"
    INCLUDEPATH += "/usr/include/pango-1.0"
    INCLUDEPATH += "/usr/lib/x86_64-linux-gnu/gtk-2.0/include"
    INCLUDEPATH += "/usr/include/gdk-pixbuf-2.0"
    INCLUDEPATH += "/usr/include/atk-1.0"

    PKGCONFIG = gtk+-2.0 appindicator-0.1

    LIBS += -L/usr/lib/x86_64-linux-gnu -lgobject-2.0
    LIBS += -L/usr/lib/x86_64-linux-gnu -lappindicator
    LIBS += -L/usr/lib/x86_64-linux-gnu -lgtk-x11-2.0
    SOURCES +=   hid_libusb.c
}

HEADERS  += mainwindow.h \
    totpslot.h \
    stick20window.h \
    stick20updatedialog.h \
    stick20setup.h \
    stick20responsedialog.h \
    stick20matrixpassworddialog.h \
    stick20lockfirmwaredialog.h \
    stick20infodialog.h \
    stick20hiddenvolumedialog.h \
    stick20hid.h \
    stick20dialog.h \
    stick20debugdialog.h \
    stick20changepassworddialog.h \
    sleep.h \
    response.h \
    passworddialog.h \
    inttypes.h \
    hotpslot.h \
    hotpdialog.h \
    hidapi.h \
    device.h \
    crc32.h \
    command.h \
    base32.h \
    aboutdialog.h \
    passwordsafedialog.h \
    securitydialog.h

FORMS    += mainwindow.ui \
    stick20window.ui \
    stick20updatedialog.ui \
    stick20setup.ui \
    stick20responsedialog.ui \
    stick20matrixpassworddialog.ui \
    stick20lockfirmwaredialog.ui \
    stick20infodialog.ui \
    stick20hiddenvolumedialog.ui \
    stick20dialog.ui \
    stick20debugdialog.ui \
    stick20changepassworddialog.ui \
    passworddialog.ui \
    hotpdialog.ui \
    aboutdialog.ui \
    passwordsafedialog.ui \
    securitydialog.ui

win32{
LIBS= -lsetupapi
}

macx{
LIBS=-framework IOKit -framework CoreFoundation
}

unix:!macx{
LIBS  = `pkg-config libusb-1.0 --libs` -lrt -lpthread
INCLUDEPATH += /usr/include/libusb-1.0
}

OTHER_FILES +=

RESOURCES += \
    resources.qrc

