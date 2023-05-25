# D.R.I.L.L.

![Godot4](https://img.shields.io/badge/godot-v4.0.*-blue)

Serious Games 2023

This is the Bonusübung Project for the Serious Games Lecture 2023 for Group 10. 

## Description
[Assignment](https://moodle.informatik.tu-darmstadt.de/pluginfile.php/251008/mod_resource/content/0/PraxisUebung%20-%20SoSe23.pdf)

[Godot Tutorials & Documentation](https://docs.godotengine.org/en/stable/index.html)

## Export & Deployment
To export the game, open the godot project and open the export dialog: `Project > Export...` In the dialog, select the `Web` Preset, then press the button `Export Project...` at the bottom of your screen. Please export it into the build folder (you'll have to create yourself) in order to not accidentally commit your built game into the repo. 

### Running an exported game
To run the exported game, just execute the script `serve.py` with the following parameters: 
`python3 serve.py --root build/web`. In this example the game was exported to the folder `build/web`. 


### Setup the export
If you have never exported a Project in Godot, follow the on screen instructions to download the template files. If you encounter any issues with that, here is the relevant tutorial: [Export for Web](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html)

