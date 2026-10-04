cmake_minimum_required(VERSION 3.21)

project(techmarket LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup()

qt_add_executable(apptechmarket
    main.cpp
)

qt_add_qml_module(apptechmarket
    URI TechMarket
    VERSION 1.0
    QML_FILES
        Main.qml
)

target_link_libraries(apptechmarket PRIVATE
    Qt6::Quick
    Qt6::QuickControls2
)