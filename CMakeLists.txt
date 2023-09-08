cmake_minimum_required(VERSION 3.27)

project(Log20)

###############################################################################
# Enable C++ 20 and modules support
###############################################################################

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_EXPERIMENTAL_CXX_MODULE_CMAKE_API "aa1f7df0-828a-4fcd-9afc-2dc80491aca7")
set(CMAKE_EXPERIMENTAL_CXX_MODULE_DYNDEP 1)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

option(LOG20_BUILD_TESTS "Build tests" ON)

add_subdirectory(Log20)

if(LOG20_BUILD_TESTS)
	add_subdirectory(Test)
endif()