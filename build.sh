echo "GPL! NONFREE! libx264! DEBUG!"
echo "Configuring..."
./configure \
    --enable-shared \
    --enable-libx264 \
    --enable-libx265 \
    --enable-gpl \
    --enable-debug=3
echo "Building..."
make
gcc -DHEADLESS_FFMPEG_ENABLED=1\
     -g \
     -shared \
     -Wl,--out-implib,headless_ffmpeg.dll.a \
     -o headless_ffmpeg.dll \
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
     -L libswresample -l swresample

gcc -g headless_ffmpeg_test.c -L . -l headless_ffmpeg -o headless_ffmpeg_test.exe
cp libavfilter/avfilter-9.dll .
cp libavcodec/avcodec-60.dll .
cp libavdevice/avdevice-60.dll .
cp libavformat/avformat-60.dll .
cp libavutil/avutil-58.dll .
cp libpostproc/postproc-57.dll .
cp libswresample/swresample-4.dll .
cp libswscale/swscale-7.dll .
./headless_ffmpeg_test.exe