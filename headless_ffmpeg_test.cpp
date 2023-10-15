#include <iostream>
#include <vector>

extern "C" {
#include "fftools/ffmpeg_headless.h"
}

int main() {
    std::cout << "started" << std::endl;

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
        headless_main(argc, const_cast<char**>(argv.data()));
    }

    return 0;
}