# HUElights

Here you will find an overview of what you could do with the HUE lights of Phillips (http://www2.meethue.com/en-xx/) 
This repository is a collection of information and different code snipets for different languages/programs meant as an inspirational source.

NOTE: for some pages on the HUE develoepr portal you will need a developers account which is easy to make

## Links

* HUE site: http://www2.meethue.com/en-xx/
* HUE developer portal: http://www.developers.meethue.com/philips-hue-api
* Apps for Hue: http://apps4hue.com/
* Control HUE with Siri: https://brandonevans.ca/projects/hacking-the-hue
* Control HUE with Arduino: http://www.makeuseof.com/tag/control-philips-hue-lights-arduino-and-motion-sensor/

## Apps and Code Snippets

### Processing

My thanks go out to: https://github.com/callil where I found: https://github.com/callil/hueP5 hwich I used as basis for the processing sketches. Here follows a description of sketches that are living on the repository:

#### HUEOSCbridge

A small processing sketch you can use to control the HUE uising OSC.
Use any program capable os sending OSC messages and use as label: "/setHue"
The message should have 4 parameters:

* Paramater 0: lampID string
* Paramater 1: Hue  int 0 - 65535
* Paramater 2: Saturation int 0 - 254
* Paramater 3: Brightness int 1 - 254

#### HUEcolorPicker

A small processing sketsch you cna use to control the lights of your Hue lamps. Currently it is hardcoded to the three lamps of the basis set, but you can easily extend this. You set the color of the Hue lmap by moving a little circel over the color you want it to be with the mouse.

##### HUErandom

This processing sketch slowly changes the color of each light to a new random value at a random time interval.


### Python

| **GitHub** | **activity** | **commits** | **releases** | **contributors** | **Python** | **Groups** | **Schedules** |**Python 3** | **pip** | **pip3** | **easy_install** | **easy_install3** |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [phue](https://github.com/studioimaginaire/phue) | Dec 2014 | 177 | 8 | 9 | [phue](https://pypi.python.org/pypi/phue) | yes | yes | yes | yes | yes | yes | yes |
| [beautifulhue](https://github.com/allanbunch/beautifulhue) | Jul 2013 | 10 | 3 | 1 | [BeautifulHue](https://pypi.python.org/pypi/BeautifulHue) | yes | yes | [issue](https://github.com/allanbunch/beautifulhue/issues/8) | yes | yes | yes | yes |
| [pyhue](https://github.com/aleroddepaz/pyhue) | Jun 2013 | 34 | 1 | 1 | [pyhue](https://pypi.python.org/pypi/pyhue) |yes | yes | no | yes | yes | yes | yes |
| [heliotron](https://github.com/briancline/heliotron) | Feb 2014 | 20 | 0 | 1 | [heliotron](https://pypi.python.org/pypi/heliotron) | no | no | no | no | no | no | no |
| [hueman](https://github.com/wrboyce/hueman) | Apr 2013 | 69 | 0 | 1 | [hueman](https://pypi.python.org/pypi/hueman) | yes | no | no | no | no | no | no |

All others found on GitHUb did not have an entry for pypi. Also interesting is a commandl line controller using phue: https://github.com/gicmo/huectl https://pypi.python.org/pypi/huectl Note that for some libraries (not phue) before you get started, you create a user (with another name than newdeveloper) via http://www.developers.meethue.com/documentation/getting-started and press the button on the bridge somewhere in the process.

I choose Phue as library for Python

#### makeyHue.py

A python script to use a MakeyMakey to control HUE lights. Using [phue](https://github.com/studioimaginaire/phue) as python library to control the HUE lights and [evdev](https://python-evdev.readthedocs.io/en/latest/) to get teh MakeyMakey input. Heavily inspired by the [MakeyPiano](https://github.com/merose/MakeyPiano) project.

