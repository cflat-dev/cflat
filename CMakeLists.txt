cmake_minimum_required(VERSION 4.0)
project(cflat C)

set(CMAKE_C_STANDARD 11)

add_executable(cflat
        examples/main.c
        cflat.h
        include/mfcu.h
        include/cflib.h
)


# Install headers (public API)
install(DIRECTORY include/ DESTINATION include)
