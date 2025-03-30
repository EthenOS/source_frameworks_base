KERNEL_SRC_DIR ?= ../../kernel/stm/source/

CC = arm-none-eabi-gcc
CXX = arm-none-eabi-g++

build:
	${CC} main.c -c -I${KERNEL_SRC_DIR}
