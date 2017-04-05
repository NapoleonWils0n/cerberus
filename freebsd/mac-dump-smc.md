# dump smc stats from mac osx

You need to have SMCFanControl on your system and know where the smcFanControl.app is located.

[smc fan control](https://github.com/hholtmann/smcFanControl/tree/master/smc-command)

Open Terminal, cd to the directory that has the smcFanControl.app

```
cd /Applications/smcFanControl.app/Contents/Resources
```

dump the smc stats to a text file on the desktop

```
type ./smc -l
```
