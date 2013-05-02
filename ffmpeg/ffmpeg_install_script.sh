# Create a temporary directory for sources.
SOURCES=$(mktemp -d /tmp/XXXXXXXXXX)
cd $SOURCES

# Download the necessary sources.
curl -#LO http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz
curl -#LO http://downloads.sourceforge.net/project/lame/lame/3.98.4/lame-3.98.4.tar.gz
curl -#LO http://downloads.xiph.org/releases/ogg/libogg-1.2.2.tar.gz
curl -#LO http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.2.tar.gz
curl -#LO http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2
curl -#LO http://downloads.sourceforge.net/project/opencore-amr/vo-amrwbenc/vo-amrwbenc-0.1.1.tar.gz
curl -#LO http://www.tortall.net/projects/yasm/releases/yasm-1.1.0.tar.gz
curl -#LO http://webm.googlecode.com/files/libvpx-v0.9.6.tar.bz2
curl -#LO ftp://ftp.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
curl -#LO http://downloads.xvid.org/downloads/xvidcore-1.3.0.tar.gz
curl -#LG -d "p=ffmpeg.git;a=snapshot;h=HEAD;sf=tgz" -o ffmpeg.tar.gz http://git.videolan.org/

# Unpack files
for file in `ls ${SOURCES}/*.tar.*`; do
    tar -xzf $file
    rm $file
done

cd faac-*/
CFLAGS="-D__unix__" ./configure && make -j 4 && sudo make install; cd ..

cd lame-*/
./configure && make -j 4 && sudo make install; cd ..

cd libogg-*/
./configure && make -j 4 && sudo make install; cd ..

cd libvorbis-*/
./configure --disable-oggtest && make -j 4 && sudo make install; cd ..

cd libtheora-*/
./configure --disable-oggtest --disable-vorbistest --disable-examples --disable-asm
make -j 4 && sudo make install; cd ..

cd vo-amrwbenc-*/
./configure && make -j 4 && sudo make install; cd ..

cd yasm-*/
./configure && make -j 4 && sudo make install; cd ..

cd libvpx-*/
./configure --enable-vp8 --enable-psnr --enable-postproc --enable-multithread --enable-runtime-cpu-detect --disable-install-docs --disable-debug-libs --disable-examples && make -j 4 && sudo make install; cd ..

cd x264-*
CFLAGS="-I. -fno-common -read_only_relocs suppress" ./configure --enable-pic --enable-shared && make -j 4 && sudo make install; cd ..

cd xvidcore/build/generic
./configure --disable-assembly && make -j 4 && sudo make install; cd ../../..

# For Lion, we have to change which compiler to use (--cc=clang).
# If you're building on Snow Leopard, you can omit this flag so it defaults to gcc.
cd ffmpeg-*/
CFLAGS="-DHAVE_LRINTF" ./configure --cc=clang --enable-nonfree --enable-gpl --enable-version3 --enable-postproc --enable-swscale --enable-avfilter --enable-libmp3lame --enable-libvorbis --enable-libtheora --enable-libfaac --enable-libxvid --enable-libx264 --enable-libvpx --enable-libvo-amrwbenc --enable-shared --enable-pthreads --disable-indevs && make -j 4 && sudo make install

# FFMpeg creates MP4s that have the metadata at the end of the file.
# This tool moves it to the beginning.
cd tools
gcc -D_LARGEFILE_SOURCE qt-faststart.c -o qt-faststart
sudo mv qt-faststart /usr/local/bin