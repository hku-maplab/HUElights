from evdev import InputDevice, categorize, ecodes
from phue import Bridge
import random

# general info Makey Makey: https://learn.sparkfun.com/tutorials/makey-makey-quickstart-guide & https://learn.sparkfun.com/tutorials/makey-makey-advanced-guide
# evdev library: https://python-evdev.readthedocs.io/en/latest/
# phue library:  https://github.com/studioimaginaire/phue

if __name__ == '__main__':

  # this is based on a RaspberryPI your input device will be named different and may live
  # somewehere else depending on your operating system
  dev = InputDevice('/dev/input/by-id/usb-Arduino_LLC_Arduino_Leonardo-if02-event-mouse')
  lightsOn = False

  b = Bridge('10.200.200.157')
  
  # If the app is not registered and the button is not pressed, press the button and call connect() (this only needs to be run a single time)
  b.connect()

  # Get the bridge state (This returns the full dictionary that you can explore)
  b.get_api()

  # loop through the events
  for event in dev.read_loop():
    # check if we have a key event
    if event.type == ecodes.EV_KEY:
      
      # print some debug info
      print(categorize(event))
      
      # UP KEY sets the lights to a random color
      if event.code == ecodes.KEY_UP:
        if(event.value == 0):
          r = random.randrange(0,65280)
          command =  {'transitiontime' : 0, 'on' : True, 'bri' : 254, 'hue' : r}
          b.set_light(1, command)
          b.set_light(2, command)
          b.set_light(3, command)
          print(r)
          print("UP") 
      # DOWN KEY sets the lights to hue 12750
      elif event.code == ecodes.KEY_DOWN:
        command =  {'transitiontime' : 0, 'on' : True, 'bri' : 254, 'hue' : 12750}
        b.set_light(1, command)
        b.set_light(2, command)
        b.set_light(3, command)
        print("DOWN") 
      # SPACE KEY toggles the lights on or off
      elif event.code == ecodes.KEY_SPACE:
        if(event.value == 0):
          lightsOn = not lightsOn

          b.set_light(1, 'on', lightsOn)
          b.set_light(2, 'on', lightsOn)
          b.set_light(3, 'on', lightsOn)
        
        print("SPACE")
      else:
        print(event)
        print(categorize(event))
