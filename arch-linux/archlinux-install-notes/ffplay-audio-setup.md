# ffplay alsa audio set up

find your audio device aplay -l

	aplay -l


edit your ~/.bashrc with your favourite text editor

	vim ~/.bashrc


add the code below and replace 1,0 with the number of your audio device

	# export alsa settings for ffplay
	export SDL_AUDIODRIVER="alsa"
	export AUDIODEV="plughw:1,0"