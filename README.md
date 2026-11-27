# Magical Orbits TD

Magical Orbits TD is a 2D Tower Defense developed with Godot based on an original mechanic where towers do not shoot at enemies, but instead use them as ammunition following the principles of kinematics and dynamics of classical mechanics.

Magical Orbits TD does not use a predefined path for the enemy waves. Instead, they try to advance along the path that takes them far from the towers using the Dijkstra’s algorithm to create a flow field. At the same time, the towers attract the enemies that enter their action range to make them orbit and launch them back. The simulation consists of attractive force, circular motion, tangential exit vectors, and kinetic energy of impact against other enemies, relative to the mass of the captured enemy.

It is intended to offer the player several modes of tower use, such as launching enemies directly to attack immediately, accumulating mass for more powerful impacts or keep enemies orbiting so they collide with the rest. It will also be possible to upgrade the towers to increase the amount of mass a tower can manage or the speed with which it launches enemies.

The game consists of a single level in which consecutive waves of enemies with incremental difficulty must be contained.

## Game engine

Godot Engine: https://godotengine.org

## How to import the project into Godot

1. Download the ZIP file from GitHub.
2. Open Godot Project Manager.
3. Select the ZIP File.
4. Import.
5. Run.

Official Godot documentation on importing projects:

https://docs.godotengine.org/en/stable/tutorials/editor/project\_manager.html#opening-and-importing-projects

## Assets

**Enemies:**
[Spire – Enemy Pack 1](https://itch.io) by **Foozle** (License: CC0) and [Spire – Enemy Pack 2](https://itch.io) by **Foozle** (License: CC0).


**Towers:**
[Spire – Tower Pack 1](https://itch.io) by **Foozle** (License: CC0).


**Map / Tileset:**
[Spire – Tileset 1](https://itch.io) by **Foozle** (License: CC0).


**Walls and Bastions:**
[Zelda-like tilesets and sprites](https://opengameart.org/content/zelda-like-tilesets-and-sprites) by **ArMM198** (License: CC0).


**UI Theme:**
[UI Kit Sampler: 56 Free Pixel UI Themes](https://csaf.itch.io/ui-kit-sampler-12-free-pixel-ui-themes) by CSAF (License: Custom Free / Royalty-Free, no attribution required).


**UI Icons:**
[Game-icons.net](https://game-icons.net) by various authors (License: CC BY 3.0).


**Font:**
[m5x7](https://managore.itch.io/m5x7) by Daniel Linssen (License: CC0)
