################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
################################################################################

cmake_minimum_required( VERSION 3.18.4 )

include(cmake/toolchain.cmake)

project( STM32BluePillTemplate
		DESCRIPTION "Project template for STM32 blue pill microcontroller"
		VERSION 1.0.0
		LANGUAGES C ASM
)

# ===================================================================
# Project Set-Up
# ===================================================================

set( PROJECT_NAME template )
set( EXEC_NAME ${PROJECT_NAME} )
set( WORK_DIR ${PROJECT_SOURCE_DIR} )

include( ${WORK_DIR}/cmake/project.cmake)

# ===================================================================
# Project content
# ===================================================================

add_executable( ${EXEC_NAME} ${WORK_DIR}/main.c )

# add_subdirectory( ${WORK_DIR}/BSP )

# target_link_libraries( ${EXEC_NAME}
# 		BSP
# 		Tasks
# )

target_include_directories(${EXEC_NAME} PRIVATE
		${WORK_DIR}
)

target_link_options(${EXEC_NAME}
		PUBLIC
		-Wl,-T ${LINKER_SCRIPT} -Wl,-Map=${OUTPUT_MAP}
)

# Generate S19 file
add_custom_command(
		TARGET ${EXEC_NAME} POST_BUILD
		COMMAND
				${CMAKE_OBJCOPY} --srec-forceS3 -O srec ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}${CMAKE_EXECUTABLE_SUFFIX} ${OUTPUT_S19}
)

# Generate HEX file
add_custom_command(
		TARGET ${EXEC_NAME} POST_BUILD
		COMMAND
				${CMAKE_OBJCOPY} -O ihex ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}${CMAKE_EXECUTABLE_SUFFIX} ${OUTPUT_HEX}
)
