#include "fftools/dullahan_ffmpeg.h"
#include <stdio.h>

int main() {
    printf("Dullahan-FFmpeg Usage Test Started (C)\n");

    #define ARGS_LENGTH 9

    int argc = ARGS_LENGTH;
    char *argv[ARGS_LENGTH];

    argv[0] = "ffmpeg";
    argv[1] = "-y";
    argv[2] = "-i";
    argv[3] = "carpaccio.mp4";
    argv[4] = "-ss";
    argv[5] = "0";
    argv[6] = "-to";
    argv[7] = "5";
    argv[8] = "carpaccio_output.mp4";

    printf("TRY 1\n");
    dullahan_ffmpeg_main(argc, argv);
    printf("TRY 2\n");
    dullahan_ffmpeg_main(argc, argv);
    printf("TRY 3\n");
    dullahan_ffmpeg_main(argc, argv);
    printf("TRY 4\n");
    dullahan_ffmpeg_main(argc, argv);
    printf("TRY 5\n");
    dullahan_ffmpeg_main(argc, argv);

    return 0;
}