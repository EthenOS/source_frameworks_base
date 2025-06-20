KERNEL_SRC_DIR ?= ../../kernel/stm/Source

KERNEL_OUT_DIR ?= ../../out/products/freertos

ETHEN_MAIN_OUT = ../../out/

MANUFACTURER ?= ethen
DEVICE ?= watch

DEVICE_SRC_INC ?= ../../device/${MANUFACTURER}/${DEVICE}/include

PREFIX ?= arm-none-eabi
CC = ${PREFIX}-gcc
CXX = ${PREFIX}-g++
AR = ${PREFIX}-ar
OBJCOPY = ${PREFIX}-objcopy

CFLAGS = -I${KERNEL_SRC_DIR}/include -I${DEVICE_SRC_INC} -I${KERNEL_SRC_DIR}/portable/GCC/ARM_CM4_MPU/ -I../../hardware/st/stm32wb55cg/include -mcpu=cortex-m4 -nostdlib -nostartfiles -Og -g -L${KERNEL_OUT_DIR} -L${ETHEN_MAIN_OUT}/products/hal

build: freertos
	${CC} main.c ${CFLAGS} -c -o ${ETHEN_MAIN_OUT}/main.o -L${KERNEL_OUT_DIR} -lfreertos
	${CC} ${ETHEN_MAIN_OUT}/main.o -o ${ETHEN_MAIN_OUT}/main.elf ${CFLAGS} -lfreertos -lhal -T ../../hardware/st/stm32wb55cg/link.lds
	${OBJCOPY} ${ETHEN_MAIN_OUT}/main.elf ${ETHEN_MAIN_OUT}/main.bin -O binary

freertos: freertos_folder
	${CC} ${KERNEL_SRC_DIR}/croutine.c ${CFLAGS} -c -o ${KERNEL_OUT_DIR}/croutine.o
	${CC} ${KERNEL_SRC_DIR}/event_groups.c ${CFLAGS} -c -o ${KERNEL_OUT_DIR}/event_groups.o
	${CC} ${KERNEL_SRC_DIR}/list.c ${CFLAGS} -c -o ${KERNEL_OUT_DIR}/list.o
	${CC} ${KERNEL_SRC_DIR}/queue.c ${CFLAGS} -c -o ${KERNEL_OUT_DIR}/queue.o
	${CC} ${KERNEL_SRC_DIR}/stream_buffer.c ${CFLAGS} -c -o ${KERNEL_OUT_DIR}/stream_buffer.o
	${CC} ${KERNEL_SRC_DIR}/tasks.c ${CFLAGS} -c -o ${KERNEL_OUT_DIR}/tasks.o
	${CC} ${KERNEL_SRC_DIR}/timers.c ${CFLAGS} -c -o ${KERNEL_OUT_DIR}/timers.o
	${CC} ${KERNEL_SRC_DIR}/portable/GCC/ARM_CM4_MPU/mpu_wrappers_v2_asm.c ${CFLAGS} -c -o ${KERNEL_OUT_DIR}/mpu_wrappers_v2_asm.o	

	${AR} rcs ${KERNEL_OUT_DIR}/libfreertos.a ${KERNEL_OUT_DIR}/*.o

freertos_folder:
	mkdir -p ${KERNEL_OUT_DIR}
