extern "C" {
#include "fftools/ffmpeg_headless.h"
}

#include <stdio.h>
#include <string.h>

int main() {
    printf("started\n");

    #define ARGS_LENGTH 9

    int argc = ARGS_LENGTH;
    char *argv[ARGS_LENGTH];

    argv[0] = strdup("ffmpeg");
    argv[1] = strdup("-y");
    argv[2] = strdup("-i");
    argv[3] = strdup("phones.mp4");
    argv[4] = strdup("-ss");
    argv[5] = strdup("16");
    argv[6] = strdup("-to");
    argv[7] = strdup("20");
    argv[8] = strdup("phones_output.mp4");

    printf("TRY 1\n");
    headless_main(argc, argv);
    printf("TRY 2\n");
    headless_main(argc, argv);
    printf("TRY 3\n");
    headless_main(argc, argv);
    printf("TRY 4\n");
    headless_main(argc, argv);
    printf("TRY 5\n");
    headless_main(argc, argv);

    return 1;
}