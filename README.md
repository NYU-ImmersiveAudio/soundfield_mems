# MEMS Sound-field FOA Mic

## Intro

This is a repository housing all things related to the slick new soundfield MEMS mic created in collaboration with NYU postdoc [Charlie Mydlarz](http://cusp.nyu.edu/people/charlie-mydlarz/) and graduate students from NYU's [MTech program](http://steinhardt.nyu.edu/music/technology). We are designing a first order ambisonics mic with an enclosure entirely 3D printed, hand soldered and reflowed electronics, and custom circuit boards designed in [Eagle](http://www.autodesk.com/products/eagle/overview). The boards can also be designed in [KiCad](http://kicad-pcb.org/) (an open source solution if anyone is looking for one).

We are making this project open source so that anyone who wants to experiment with ambisonics can print and build the mic themselves. The encoder and decoder will also be included and should run on [Matlab](https://www.mathworks.com/products/matlab) or [Octave GNU](https://www.gnu.org/software/octave). Let us know if there are any issue running on Octave, we have not tested this yet!

## Materials
### Essential materials
- Soldering gun
  - The hotter the better. You really don't want to be stingy with this because having a soldering gun that takes a long time to melt your solder will be a pain in the a**.
- Solder
 - You will use this solder to connect the battery to the PCB and the cables from the microphone to adaptors that fit into your audio interface. Naturally you will also need some adaptors such as mini-XLRs or normal XLR adaptors.
You can use any audio interface that has 4 inputs.
Remember, keep phantom power off!
- Solder paste for MEMS microphone.
  - You will use this solder paste to [surface mount](https://mad-science.wonderhowto.com/how-to/make-surface-mount-electronics-home-for-smaller-cheaper-diy-gadgets-0135537/) the capsules to the PCB in the [reflow oven](https://mad-science.wonderhowto.com/how-to/diy-lab-equipment-build-your-own-reflow-oven-out-toaster-for-precision-temperature-soldering-0135536/).  
- 0.1μF surface mounted decoupling capacitor (one per capsules for a total of 4).
  - It's a good idea to get extras of everything in case something goes wrong. I believe these are the ones we used. I also believe since they are dielectric it does not matter which direction you mount them, but I'll have to ask Charlie.
- Analog MEMS capsules.
  - You can buy them [here](https://www.invensense.com/products/analog/ics-40720/).
  - Download the data sheet to get access to the heat profile.
  - You will need the profile in order to know how hot to run your oven.  
- Custom PCB boards.
  - Find the Eagle files on the repo.
  - We had ours manufactured with [OSH Park](https://blog.oshpark.com/).
- Cables to connect the boards to the breakout board.
  - We used non-braided to make soldering easier. Braided wires tend to be easier to bend which can be helpful but need to be tinned. Tinning is the process of adding a bit of solder to the end of a braided wire so it "behaves".
- A reflow oven
  - If you don't want to build your own you can generally find these at Universities or Engineering labs. Try also looking online to see if there are services that allow one to send parts to be surface mounted at a low price. Or try looking for tinkering stores/communities which might have one of these.
- 3V battery.
- The printed CAD model.
 - Again, you might be able to find a community around you that shares 3D printers.  
- Tweezers for placing components on the PCB.
  - Trust us, you want to get tweezers.

### Optional
- Multimeter: to check that none of your connections have short-circuited.
- A clamp to help with the soldering.

[Here](https://sites.google.com/nyu.edu/open-source-vr-mic-nyu/) is a link to our Google site with more info and a step-by-step process.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

- [Charlie Mydlarz](http://cusp.nyu.edu/people/charlie-mydlarz/) : Eagle Board Design
- [Gabriel Zalles](http://www.gzalles.github.io): CAD Design
- [Spencer Cappiello](www.spencercappiello.com): misc.
- [Ian Anderson](): misc.

## License

The original technology is not mine. There are patents for this technology out there. The original creator of ambisonic technology is Michael Gerzon. Please give credit where you can.
