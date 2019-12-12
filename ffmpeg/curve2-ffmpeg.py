# https://video.stackexchange.com/questions/16352/converting-gimp-curves-files-to-photoshop-acv-for-ffmpeg
import re

#make generator
lower=0
upper=1
length=256
zerotoonestepped256gen = [lower + x*(upper-lower)/length for x in range(length)]

def formatForFFMPEG(values):
    serializedValues = values.split(' ')
    list = []
    for i in range (len(serializedValues)):
        if not list or zerotoonestepped256gen[i] - float(re.match(r"^[^////]*",list[-1]).group(0)) > 0.01:
            list.append('%s/%s' % (zerotoonestepped256gen[i], serializedValues[i]))
    return list

#get filename
file = input('Please input the absolute path to the GIMP Color Curve Preset File: ')
out = input('Please enter the output file (file will be overwritten if it exists): ')

#Open the curves file
curvesfile = open(file,"r")
curvesString = curvesfile.read()
foundValues = re.findall(r'(?<=samples 256) [\d. ]*',curvesString)

masterValues = formatForFFMPEG(foundValues[0][1:])
redValues = formatForFFMPEG(foundValues[1][1:])
greenValues = formatForFFMPEG(foundValues[2][1:])
blueValues = formatForFFMPEG(foundValues[3][1:])
alphaValues = formatForFFMPEG(foundValues[4][1:])

commandPrelim = 'curves=master="'

command = commandPrelim + ' '.join(masterValues) + '":red="' + ' '.join(redValues) +'":green="' + ' '.join(greenValues) + '":blue="' + ' '.join(blueValues) + '"'


#with open(out, 'w') as out:
#    out.write("Final Command\n\n" + command + '\n\n')
#    out.write("master\n\n" + ' '.join(masterValues) + '\n\n')
#    out.write("red\n\n" + ' '.join(redValues) + '\n\n')
#    out.write("green\n\n" + ' '.join(greenValues) + '\n\n')
#    out.write("blue\n\n" + ' '.join(blueValues) + '\n\n')
#    out.write("alpha\n\n" + ' '.join(alphaValues) + '\n\n')


with open(out, 'w') as out:
    out.write(command)
