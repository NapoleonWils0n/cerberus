#===============================================================================
# FILE: Makefile
#
# Project: realesrgan video upscale
#
# OS: Freebsd/Linux with Nvidia
#
# Dependencies: realesrgan-ncnn-vulkan ffmpeg
#
# Description: Extracts frames from a video, upscales them using Real-ESRGAN,
#              and reassembles them with the original audio track (if present).
#===============================================================================

#===============================================================================
# PHONY
#===============================================================================

.PHONY: all clean


#===============================================================================
# commands
#===============================================================================

# Input/output defaults
# Override on command line e.g., make input=video.mp4 output=out.mp4
input  ?= input.mp4
output := output_upscaled.mp4


#===============================================================================
# options (can be overridden on command line, e.g., make tile_size=256)
#===============================================================================

# tile_size: 0 = auto, or >= 32 (e.g., 256 or 512 to reduce VRAM usage)
tile_size ?= 0

# threads: Thread counts for load:proc:save stages (default=1:2:2)
threads   ?= 1:2:2

# model:  realesrgan-x4plus (default) | realesrgan-x4plus-anime
#         realesr-animevideov3 | realesrnet-x4plus
model     ?= realesrgan-x4plus


#===============================================================================
# default target
#===============================================================================

all: $(output)


#===============================================================================
# create the frames directory
#===============================================================================

frames: 
	@mkdir -p frames


#===============================================================================
# create the upscale_dir directory
#===============================================================================

upscaled_frames: 
	@mkdir -p upscaled_frames


#===============================================================================
# .build directory to keep track of the build
#===============================================================================

.build:
	@mkdir -p .build

#===============================================================================
# ffmpeg extract frames
#===============================================================================

# Sentinel file trick for multi-file generation
.build/extracted: $(input) frames .build
	@ffmpeg -hide_banner -stats -v panic -i $(input) -qscale:v 1 -qmin 1 -vsync 0 frames/frame_%08d.png
	@touch .build/extracted


#===============================================================================
# realesrgan-ncnn-vulkan upscale images
#===============================================================================

.build/upscaled: .build/extracted upscaled_frames
	@realesrgan-ncnn-vulkan \
		-i frames \
		-o upscaled_frames \
		-n $(model) \
		-s 4 \
		-t $(tile_size) \
		-j $(threads) \
		-f png
	@touch .build/upscaled


#===============================================================================
# ffmpeg create video from frames
#===============================================================================

# Automatically add nv-sglrun if running on FreeBSD
RUN_PREFIX != [ $$(uname -s) = "FreeBSD" ] && echo "nv-sglrun 2>/dev/null" || echo ""

# Final video target output
$(output): .build/upscaled
	@$(RUN_PREFIX) ffmpeg \
	-hide_banner \
	-stats -v panic \
	-framerate $$(ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 $(input)) \
	-i upscaled_frames/frame_%08d.png \
	-i $(input) \
	-map 0:v:0 -map '1:a?' \
	-vf scale=3840:2160 \
	-c:v hevc_nvenc \
	-tune hq \
	-preset p7 \
	-rc vbr \
	-multipass fullres \
	-cq 20 \
	-b:v 0 \
	-rc-lookahead 32 \
	-spatial-aq 1 \
	-c:a copy \
	-pix_fmt yuv420p \
	-movflags +faststart \
	$(output)


#===============================================================================
# clean
#===============================================================================

clean:
	rm -rf frames upscaled_frames .build $(output)
