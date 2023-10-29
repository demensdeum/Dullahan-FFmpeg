#include <iostream>
#include <vector>

extern "C" {
#include "fftools/dullahan_ffmpeg.h"
}

int main() {
    std::cout << "FFmpeg-Dullahan Usage Test Started (C++)" << std::endl;

    std::vector<const char*> argv = {
        "ffmpeg",
        "-y",
        "-i",
        "carpaccio.mp4",
        "-ss",
        "0",
        "-to",
        "5",
        "carpaccio_output.mp4"
    };

    for (int i = 1; i <= 5; ++i) {
        std::cout << "TRY " << i << std::endl;
        const int argc = static_cast<int>(argv.size());
        dullahan_ffmpeg_main(argc, const_cast<char**>(argv.data()));
    }

    return 0;
}