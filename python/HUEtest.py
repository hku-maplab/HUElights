#!/usr/bin/python

from phue import Bridge
# https://github.com/studioimaginaire/phue

b = Bridge('bridgeipaddress')

# If the app is not registered and the button is not pressed, press the button and call connect() (this only needs to be run a single time)
b.connect()

# Get the bridge state (This returns the full dictionary that you can explore)
b.get_api()

# Prints if light 1 is on or not
b.get_light(1, 'on')

# Set brightness of lamp 1 to max
b.set_light(1, 'bri', 0)

# The set_light method can also take a dictionary as the second argument to do more fancy stuff
# This will set some parameters on light 1 with a transition time of 30 seconds
command =  {'transitiontime' : 300, 'on' : True, 'bri' : 254, 'hue' : 12750}
b.set_light(1, command)

