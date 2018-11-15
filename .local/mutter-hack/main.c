#include <meta/main.h>

int main() {
    GMainLoop *loop = g_main_loop_new(NULL, FALSE);
    meta_init();
    g_main_loop_run(loop);
}

