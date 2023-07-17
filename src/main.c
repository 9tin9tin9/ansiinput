#include <stdio.h>
#include "ansiinput.h"

int main() {
    AI_raw();
    AI_noecho();
    AI_mouse();
    AI_initEventQueue();
    AI_setExitKey((AI_KeyEvent){ .ctrl = true, .alt = false, .c = 'C'});

    AI_Event e = { 0 };
    while (AI_waitEvent(&e) && !AI_shouldExit()) {
        AI_Event_printInfo(&e, stdout);
        puts("\r");
    }

    AI_nomouse();
    AI_echo();
    AI_cooked();
    return 0;
}
