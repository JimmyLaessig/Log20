###############################################################################
# Download catch2 library via conan
###############################################################################

set(CATCH2_VERSION 2.11.0)

# Download conan.cmake automatically
if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
  message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/0.18.1/conan.cmake" "${CMAKE_BINARY_DIR}/conan.cmake")
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)

conan_cmake_run(
  REQUIRES
    catch2/${CATCH2_VERSION}
  OPTIONS
    ${CONAN_EXTRA_OPTIONS}
  BASIC_SETUP
    CMAKE_TARGETS # individual targets to link to
  BUILD missing)

# automatically enable catch2 to generate ctest targets
if(CONAN_CATCH2_ROOT_DEBUG)
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CONAN_CATCH2_ROOT_DEBUG}/lib/cmake/Catch2)
else()
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CONAN_CATCH2_ROOT}/lib/cmake/Catch2)
endif()

message("")