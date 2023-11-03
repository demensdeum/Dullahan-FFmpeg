#!/bin/bash

# Change directories for your tasks

target_directories=(
  "C:/Users/Demensdeum/Documents/Sources/RaidenVideoRipper"
  "C:/Users/Demensdeum/Documents/Sources/build-RaidenVideoRipper-Desktop_Qt_6_6_0_MinGW_64_bit-Debug/debug"
  "C:/Users/Demensdeum/Documents/Sources/build-RaidenVideoRipper-Desktop_Qt_6_6_0_MinGW_64_bit-Release/release"
)

clean_enabled=false
configure_enabled=false
run_examples=false
install_libs=false
debug_flag="-g"
optimization_flags=""
ffmpeg_debug_level=3
target_arch="i686"

for arg in "$@"; do
    if [ "$arg" = "--clean" ]; then
        clean_enabled=true
        echo "Clean enabled"
    elif [ "$arg" = "--configure" ]; then
        configure_enabled=true
        echo "Configure enabled"
    elif [ "$arg" = "--run-examples" ]; then
        run_examples=true
        echo "Run examples"
    elif [ "$arg" = "--install-libs" ]; then
        install_libs=true
        echo "Installing DLLs to DemensDeum's PC for Raiden Video Ripper project..."
    elif [ "$arg" = "--release" ]; then
        debug_flag=""
        #optimization_flags="-O3 -march=native -mtune=native -flto -funroll-loops -Ofast"
        optimization_flags="-O3"
        ffmpeg_debug_level=0
        echo "Release version..."
    fi
done

if [ $clean_enabled == true ]; then
echo "Cleaning..."
make clean
fi

if [ $configure_enabled == true ]; then
echo "Configuring..."
./configure \
    --enable-shared \
    --enable-libx264 \
    --enable-libx265 \
    --enable-gpl \
    --enable-libvpx \
    --enable-libvorbis \
    --enable-debug=$ffmpeg_debug_level

if [ $? -ne 0 ]; then
    echo "Configure Error!"
    exit 1
fi

fi

echo "Building Dullahan-FFmpeg..."
make
gcc $optimization_flags \
    -DDULLAHAN_FFMPEG_ENABLED=1 \
     $debug_flag \
     -shared \
     -Wl,--out-implib,dullahan_ffmpeg.dll.a \
     -o dullahan_ffmpeg.dll \
     fftools/thread_queue.c \
     fftools/objpool.c \
     fftools/cmdutils.c \
     fftools/ffmpeg_mux.c \
     fftools/ffmpeg_demux.c \
     fftools/opt_common.c \
     fftools/ffmpeg_mux_init.c \
     fftools/ffmpeg_hw.c \
     fftools/ffmpeg_filter.c \
     fftools/ffmpeg_opt.c \
     fftools/sync_queue.c \
     fftools/ffmpeg_enc.c \
     fftools/ffmpeg_dec.c \
     fftools/ffmpeg.c \
     -I. \
     -L libpostproc -l libpostproc \
     -L libavcodec -l libavcodec \
     -L libavdevice -l libavdevice \
     -L libavfilter -l libavfilter \
     -L libavformat -l libavformat \
     -L libavutil -l libavutil \
     -L libswscale -l swscale \
     -L libswresample -l swresample \
     -limagehlp

if [ $? -ne 0 ]; then
    echo "Dullahan-FFmpeg build error!!!"
    exit 1
fi

echo "Copying built dlls..."

cp libavfilter/avfilter-9.dll .
cp libavcodec/avcodec-60.dll .
cp libavdevice/avdevice-60.dll .
cp libavformat/avformat-60.dll .
cp libavutil/avutil-58.dll .
cp libpostproc/postproc-57.dll .
cp libswresample/swresample-4.dll .
cp libswscale/swscale-7.dll .

if [ $? -ne 0 ]; then
    echo "dlls copying error!"
    exit 1
fi

echo "Building C example application..."

gcc $optimization_flags $debug_flag dullahan_ffmpeg_test.c -L . -l dullahan_ffmpeg -o dullahan_ffmpeg_test_c.exe
if [ $? -ne 0 ]; then
    echo "Building C example build error!"
    exit 1
fi

if [ $run_examples == true ]; then

./dullahan_ffmpeg_test_c.exe
if [ $? -ne 0 ]; then
    echo "C example run error!"
    exit 1
fi

fi

echo "Building C++ example application..."

g++ $optimization_flags $debug_flag dullahan_ffmpeg_test.cpp -L . -l dullahan_ffmpeg -o dullahan_ffmpeg_test_cpp.exe
if [ $? -ne 0 ]; then
    echo "Building C++ example build error!"
    exit 1
fi

if [ $run_examples == true ]; then

./dullahan_ffmpeg_test_cpp.exe
if [ $? -ne 0 ]; then
    echo "C++ example run error!"
    exit 1
fi

fi

echo "Building C++ example application (Cancel Test)..."

g++ $optimization_flags $debug_flag dullahan_ffmpeg_cancel_test.cpp -L . -l dullahan_ffmpeg -o dullahan_ffmpeg_cancel_test.exe
if [ $? -ne 0 ]; then
    echo "Building C++ cancel example build error!"
    exit 1
fi

echo "Building C++ example output formats application..."

g++ $optimization_flags $debug_flag dullahan_ffmpeg_output_formats_test.cpp -L . -l dullahan_ffmpeg -o dullahan_ffmpeg_output_formats_test.exe
if [ $? -ne 0 ]; then
    echo "Building C++ example output formats build error!"
    exit 1
fi

if [ $run_examples == true ]; then

./dullahan_ffmpeg_output_formats_test.exe
if [ $? -ne 0 ]; then
    echo "C++ example output formats run error!"
    exit 1
fi

fi

install_files=(
  "libavfilter/avfilter-9.dll"
  "libavcodec/avcodec-60.dll"
  "libavdevice/avdevice-60.dll"
  "libavformat/avformat-60.dll"
  "libavutil/avutil-58.dll"
  "libpostproc/postproc-57.dll"
  "libswresample/swresample-4.dll"
  "libswscale/swscale-7.dll"
  "dullahan_ffmpeg.dll"
  "dullahan_ffmpeg.dll.a"
)

if [ "$install_libs" == true ]; then
    echo "Installing libs..."
  for install_file in "${install_files[@]}"; do
    for target_directory in "${target_directories[@]}"; do
        cp "$install_file" "${target_directory}"
    done
  done
fi

echo "1" > /tmp/Dullahan-FFmpeg-Build-Complete