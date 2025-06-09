# ffmpeg convert video to x265 and aac audio

# Move this Makefile into the same directory as the video to process

# you need to tell the Makefile the name of the video to process
# either edit the Makefile and changing input.mov to the name of the video to process
# and then run: make

# or by running: make input=filename.mov
# where filename.mov is the name of the file to process

# input
input := input.mov

# Declares targets as phony to ensure execution
.PHONY: all fdkaac pass1 pass2 combine clean 

# all targets
all: combine

# extract audio and compress with fdkaac in one go via piping
fdkaac: $(input)
	@echo "Extracting audio and compressing with fdkaac..."
	@ffmpeg \
		-hide_banner \
		-stats -v panic \
		-i $(input) \
		-vn \
		-f caf - | fdkaac -m 5 -w 18000 -o output.aac -

# video pass 1
pass1: fdkaac
	@echo "Starting video pass 1..."
	@ffmpeg -y \
		-hide_banner \
		-stats -v panic \
		-i $(input) \
		-an \
		-c:v libx265 \
		-x265-params "vbv-maxrate=10000:vbv-bufsize=20000:open-gop=0:keyint=48:min-keyint=48:scenecut=0:bframes=2:bitrate=8000:pass=1:no-slow-firstpass=1" \
		-pix_fmt yuv420p \
		-preset slow \
		-b:v 8000k \
		-f mp4 \
		NUL

# video pass 2
pass2: pass1
	@echo "Starting video pass 2..."
	@ffmpeg -y \
		-hide_banner \
		-stats -v panic \
		-i $(input) \
		-an \
		-c:v libx265 \
		-x265-params "vbv-maxrate=10000:vbv-bufsize=20000:open-gop=0:keyint=48:min-keyint=48:scenecut=0:bframes=2:bitrate=8000:pass=2" \
		-pix_fmt yuv420p \
		-preset slow \
		-b:v 8000k \
		-movflags +faststart \
		output.mp4

# combine audio and video
combine: pass2
	@echo "Combining audio and video..."
	@ffmpeg -y \
		-hide_banner \
		-stats -v panic \
		-i output.mp4 \
		-i output.aac \
		-c:a copy \
		-c:v copy \
		-map 0:0 \
		-map 1:0 \
		-pix_fmt yuv420p \
		-movflags +faststart \
		-f mp4 \
		combined-output.mp4

# make clean - prompt to remove all files, except the input file
clean:
	@echo "Cleaning up generated files..."
	@rm -fI combined-output.mp4 NUL output.aac output.mp4 x265_2pass.log x265_2pass.log.cutree
	@echo "Cleanup complete."
