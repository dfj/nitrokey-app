CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

PROJECT(NitrokeyApp)
SET(PROJECT_VERSION "1.0") 
#ADD_DEFINITIONS(-DSEAFILE_CLIENT_VERSION=${PROJECT_VERSION}) 

INCLUDE(FindPkgConfig)

IF (NOT (${CMAKE_BUILD_TYPE} MATCHES Release))
  SET(CMAKE_BUILD_TYPE Debug) 
ENDIF()
MESSAGE("Build type: ${CMAKE_BUILD_TYPE}") 


# QT configuration
FIND_PACKAGE(Qt5Core)
FIND_PACKAGE(Qt5Gui)
FIND_PACKAGE(Qt5Widgets)


# Directory structure

SET(ROOTDIR ${CMAKE_CURRENT_SOURCE_DIR})
SET(UIDIR ${ROOTDIR}/ui)
SET(SRCDIR ${ROOTDIR}/src)
SET(SRCUIDIR ${SRCDIR}/ui)
SET(UTILSDIR ${SRCDIR}/utils)

# Moc files
SET(moc_headers
    ${SRCUIDIR}/aboutdialog.h
    ${UTILSDIR}/base32.h
    ${SRCDIR}/command.h
    ${UTILSDIR}/crc32.h
    ${SRCUIDIR}/nitrokey-applet.h
    ${SRCDIR}/device.h
    ${UTILSDIR}/gui.h
    ${UTILSDIR}/hidapi.h
    ${SRCUIDIR}/hotpdialog.h
    ${SRCDIR}/hotpslot.h
    ${SRCDIR}/inttypes.h
    ${SRCUIDIR}/mainwindow.h
    ${SRCDIR}/mcvs-wrapper.h
    ${SRCUIDIR}/passworddialog.h
    ${SRCUIDIR}/passwordsafedialog.h
    ${SRCUIDIR}/pindialog.h
    ${SRCDIR}/response.h
    ${SRCUIDIR}/securitydialog.h
    ${UTILSDIR}/sleep.h
    ${SRCUIDIR}/splash.h
    ${SRCUIDIR}/stick20changepassworddialog.h
    ${SRCUIDIR}/stick20debugdialog.h
    ${SRCUIDIR}/stick20dialog.h
    ${SRCUIDIR}/stick20hiddenvolumedialog.h
    ${UTILSDIR}/stick20hid.h
    ${SRCUIDIR}/stick20infodialog.h
    ${SRCUIDIR}/stick20lockfirmwaredialog.h
    ${SRCUIDIR}/stick20matrixpassworddialog.h
    ${SRCUIDIR}/stick20responsedialog.h
    ${SRCUIDIR}/stick20setup.h
    ${SRCUIDIR}/stick20updatedialog.h
    ${SRCUIDIR}/stick20window.h
    ${SRCDIR}/totpslot.h
)


# Ui files
SET(ui_files
    ${UIDIR}/aboutdialog.ui
    ${UIDIR}/hotpdialog.ui
    ${UIDIR}/mainwindow.ui
    ${UIDIR}/passworddialog.ui
    ${UIDIR}/passwordsafedialog.ui
    ${UIDIR}/pindialog.ui
    ${UIDIR}/securitydialog.ui
    ${UIDIR}/stick20changepassworddialog.ui
    ${UIDIR}/stick20debugdialog.ui
    ${UIDIR}/stick20dialog.ui
    ${UIDIR}/stick20hiddenvolumedialog.ui
    ${UIDIR}/stick20infodialog.ui
    ${UIDIR}/stick20lockfirmwaredialog.ui
    ${UIDIR}/stick20matrixpassworddialog.ui
    ${UIDIR}/stick20responsedialog.ui
    ${UIDIR}/stick20setup.ui
    ${UIDIR}/stick20updatedialog.ui
    ${UIDIR}/stick20window.ui
)


# Resource files
SET(qrc_files
    resources.qrc
)


# preprocess ui files
QT5_WRAP_UI(ui_output ${ui_files})

# meta object compliation(moc)
QT5_WRAP_CPP(moc_output ${moc_headers})

# resources files
QT5_ADD_RESOURCES(resources_ouput ${qrc_files})


FIND_PACKAGE(PkgConfig REQUIRED)
SET(LIBUSB_INCLUDE_DIRS "/usr/include/libusb-1.0")

# c/cpp sources
SET(nitrokey_app_sources
    ${SRCUIDIR}/aboutdialog.cpp
    ${UTILSDIR}/base32.cpp
    ${SRCDIR}/command.cpp
    ${UTILSDIR}/crc32.cpp
    ${SRCUIDIR}/nitrokey-applet.cpp
    ${SRCDIR}/device.cpp
    ${UTILSDIR}/gui.cpp
    ${SRCUIDIR}/hotpdialog.cpp
    ${SRCDIR}/hotpslot.cpp
    ${SRCDIR}/main.cpp
    ${SRCUIDIR}/mainwindow.cpp
    ${SRCUIDIR}/passworddialog.cpp
    ${SRCUIDIR}/passwordsafedialog.cpp
    ${SRCUIDIR}/pindialog.cpp
    ${SRCDIR}/response.cpp
    ${SRCUIDIR}/securitydialog.cpp
    ${SRCUIDIR}/splash.cpp
    ${SRCUIDIR}/stick20changepassworddialog.cpp
    ${SRCUIDIR}/stick20debugdialog.cpp
    ${SRCUIDIR}/stick20dialog.cpp
    ${SRCUIDIR}/stick20hiddenvolumedialog.cpp
    ${SRCUIDIR}/stick20infodialog.cpp
    ${SRCUIDIR}/stick20lockfirmwaredialog.cpp
    ${SRCUIDIR}/stick20matrixpassworddialog.cpp
    ${SRCUIDIR}/stick20responsedialog.cpp
    ${SRCUIDIR}/stick20setup.cpp
    ${SRCUIDIR}/stick20updatedialog.cpp
    ${SRCUIDIR}/stick20window.cpp
    ${SRCDIR}/totpslot.cpp
    ${UTILSDIR}/stick20hid.c
    ${UTILSDIR}/hid_libusb.c
    ${platform_specific_sources}
)

IF (WIN32)
    SET( platform_specific_sources hid_win.c)
ELSEIF(APPLE)
    SET( platform_specific_sources hid_mac.c)
    SET( platform_specific_libs "-framework IOKit -framework CoreFoundation")
ELSEIF (${CMAKE_SYSTEM_NAME} MATCHES "Linux" OR ${CMAKE_SYSTEM_NAME} MATCHES "BSD")
    SET(EXTRA_LIBS pthread usb-1.0)
ENDIF()

INCLUDE_DIRECTORIES(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
    ${SRCDIR}
    ${UTILSDIR}
    ${SRCUIDIR}
    ${PROJECT_SOURCE_DIR}
    ${QT_INCLUDE_DIR}
    ${LIBUSB_INCLUDE_DIRS}
)

LINK_DIRECTORIES(
    ${QT_LIBRARY_DIR}
    ${LIBUSB_LIBRARY_DIRS}
)


# Freedesktop files
if(NOT WIN32)
install(DIRECTORY
  ${CMAKE_SOURCE_DIR}/data/icons/16x16
  ${CMAKE_SOURCE_DIR}/data/icons/22x22
  ${CMAKE_SOURCE_DIR}/data/icons/24x24
  ${CMAKE_SOURCE_DIR}/data/icons/32x32
  ${CMAKE_SOURCE_DIR}/data/icons/48x48
  ${CMAKE_SOURCE_DIR}/data/icons/128x128
  ${CMAKE_SOURCE_DIR}/data/icons/scalable
  DESTINATION share/icons/hicolor
)

install(FILES
  ${CMAKE_SOURCE_DIR}/data/nitrokey-app.desktop
  DESTINATION share/applications
)

install(FILES
  ${CMAKE_SOURCE_DIR}/data/icons/128x128/apps/nitrokey-app.png
  DESTINATION share/pixmaps
)

endif()


ADD_EXECUTABLE(nitrokey-app ${GUI_TYPE}
  ${nitrokey_app_sources}
  ${moc_output}
  ${ui_output}
  ${resources_ouput}
)

INSTALL(TARGETS nitrokey-app DESTINATION bin)

TARGET_LINK_LIBRARIES(nitrokey-app
  ${QT_LIBRARIES}
  ${LIBUSB_LIBRARIES}
  ${EXTRA_LIBS}
  ${platform_specific_libs}
)

qt5_use_modules( nitrokey-app Core Gui Widgets)

# Packaging
SET(CPACK_GENERATOR
    "DEB;RPM")

SET(CPACK_PACKAGE_NAME "nitrokey-app" )
SET(CPACK_PACKAGE_VERSION "1.0" )
SET(CPACK_PACKAGE_ARCHITECTURE `dpkg --print-architecture`)
SET(CPACK_PACKAGE_DEPENDS "" )
SET(CPACK_PACKAGE_DESCRIPTION  "Application to manage your Nitrokey")

# Deb
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Georgios Gkitsas <george@nitrokey.com>" )
SET(CPACK_PACKAGE_PRIORITY "optional")
SET(CPACK_PACKAGE_SECTION "utils")

# Rpm


INCLUDE(CPack)
