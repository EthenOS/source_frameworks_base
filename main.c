#include <stdio.h>
#include <stdbool.h>
#include "FreeRTOS.h"
#include "mcu.h"

int main() {
    rcc_init();
    gpio_init();

    while (true) {
       gpio_toggle(2); 
    }
}
