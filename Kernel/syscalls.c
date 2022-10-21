#include <syscalls.h>
#include <stdint.h>
#include <video.h>
#include <keyBoardHandler.h>

static void (*sysFunctions[20])(uint64_t r1, uint64_t r2, uint64_t r3, uint64_t r4,uint64_t r5) = {_0_empty,_1_writeChar,_2_read,_3_draw_rectangle,_4_clear_screen};

void sys_call_handler(uint64_t mode, uint64_t r1, uint64_t r2, uint64_t r3, uint64_t r4,uint64_t r5 ){ // pasamos todos ints, en el caso en el que sea un numero, se lee como un numero, en el caso de que esa una direccion de memoria, se castea a la que se necesita :)
    (*sysFunctions[mode])(r1,r2,r3,r4,r5);
	return;
}

void _0_empty(uint64_t r1, uint64_t r2, uint64_t r3, uint64_t r4,uint64_t r5){
    ;
} 


void _1_writeChar(uint64_t x, uint64_t y, uint64_t c){
    draw_char(x, y, (char *)c, WHITE, BLACK, DEFAULT_LETTER_SIZE);
} 


void _2_read(uint64_t buffer, uint64_t length){
    for(int i = 0; i< length; i++){
        char c;
        if((c = nextElement()) == -1) return;
        ((char *)buffer)[i] = c;
    }
} 


void _3_draw_rectangle (uint64_t x, uint64_t y, uint64_t w, uint64_t h, uint64_t color) {
    fillrect(x, y, color, w, h);    
}

void _4_clear_screen(){
    clearScreen();
}

