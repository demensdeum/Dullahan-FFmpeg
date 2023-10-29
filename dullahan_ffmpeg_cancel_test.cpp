#include <iostream>
#include <vector>
#include <thread>
#include <chrono>

extern "C" {
#include "fftools/dullahan_ffmpeg.h"
}

void runHeadlessMain(std::vector<const char*> argv) {
    const int argc = static_cast<int>(argv.size());
    dullahan_ffmpeg_main(argc, const_cast<char**>(argv.data()));
}

int main() {
    std::cout << "Dullahan-FFmpeg Cancel Test Started (C++)" << std::endl;

    std::vector<const char*> argv = {
        "ffmpeg",
        "-y",
        "-i",
        "C:/msys64/home/Demensdeum/Videos/cancel/ANON WORKS IT - FULL VERSION 4chan Greentext Animations.mp4",
        "-ss",
        "0",
        "-to",
        "1648314",
        "C:/msys64/home/Demensdeum/Videos/cancel/ANON WORKS IT - FULL VERSION 4chan Greentext Animations_output.mp4"
    };

    std::thread thread(runHeadlessMain, argv);
    thread.detach();

    std::this_thread::sleep_for(std::chrono::seconds(3));
    int pts = dullahan_ffmpeg_conversion_pts();
    std::cout << std::endl << "---" << std::endl << "pts: " << pts << "---" << std::endl;
    std::this_thread::sleep_for(std::chrono::seconds(3));    
    dullahan_ffmpeg_cancel();
    std::this_thread::sleep_for(std::chrono::seconds(3));
    std::thread thread2(runHeadlessMain, argv);
    thread2.detach();
    std::this_thread::sleep_for(std::chrono::seconds(3));

    return 0;
}
