#include <iostream>
#include <vector>

extern "C" {
#include "fftools/dullahan_ffmpeg.h"
}

int main() {
    std::cout << "FFmpeg-Dullahan Usage Output Formats Test Started (C++)" << std::endl;

    const char* inputFile = "carpaccio.mp4";
    std::vector<std::string> outputFormats = {"mp4", "gif", "webm", "mp3"};

    for (const auto& format : outputFormats) {
        std::cout << "Converting " << inputFile << " to " << format << std::endl;

        std::string outputFileName = "carpaccio_output." + format;

        std::vector<const char*> argv = {
            "ffmpeg",
            "-y",
            "-i",
            inputFile,
            "-ss",
            "0",
            "-to",
            "5",
            outputFileName.c_str()
        };

        const int argc = static_cast<int>(argv.size());
        auto result = dullahan_ffmpeg_main(argc, const_cast<char**>(argv.data()));
        if (result != 0) {
            std::cout << "Can't convert: " << format << "; result: " << result << std::endl;
            exit(result);
        }
    }

    return 0;
}
