#include "fftools/ffmpeg_headless.h"
#include <stdio.h>

int main() {
    printf("started\n");

    #define ARGS_LENGTH 9

    int argc = ARGS_LENGTH;
    char *argv[ARGS_LENGTH];

    argv[0] = "ffmpeg";
    argv[1] = "-y";
    argv[2] = "-i";
    argv[3] = "phones.mp4";
    argv[4] = "-ss";
    argv[5] = "16";
    argv[6] = "-to";
    argv[7] = "20";
    argv[8] = "phones_output.mp4";

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