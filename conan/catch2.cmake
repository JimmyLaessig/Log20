###############################################################################
# Download catch2 library via conan
###############################################################################

set(CATCH2_VERSION 3.4.0)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_BINARY_DIR})
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_BINARY_DIR})

# Download conan.cmake automatically
if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
  message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/0.18.1/conan.cmake" "${CMAKE_BINARY_DIR}/conan.cmake")
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)

#conan_cmake_run(
#  REQUIRES
#    catch2/${CATCH2_VERSION}
#  OPTIONS
#    ${CONAN_EXTRA_OPTIONS}
#  BASIC_SETUP
#    CMAKE_TARGETS # individual targets to link to
#  BUILD missing)

conan_cmake_configure(REQUIRES catch2/${CATCH2_VERSION}
                      GENERATORS cmake_find_package_multi)

foreach(TYPE ${CMAKE_CONFIGURATION_TYPES})
  conan_cmake_autodetect(settings BUILD_TYPE ${TYPE})
  conan_cmake_install(PATH_OR_REFERENCE .
                      BUILD missing
                      REMOTE conancenter
                      SETTINGS ${settings})
endforeach()

# automatically enable catch2 to generate ctest targets
if(CONAN_CATCH2_ROOT_DEBUG)
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CONAN_CATCH2_ROOT_DEBUG}/lib/cmake/Catch2)
else()
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CONAN_CATCH2_ROOT}/lib/cmake/Catch2)
endif()

find_package(Catch2 REQUIRED)
