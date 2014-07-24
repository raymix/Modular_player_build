#Modular *player_build* Concept
___
Based on files from Dayz Epoch 1.0.5.2 RC and imitates original file/folder structure

###### What is it?
It is a redesigned *player_build* system created by @vbawol that still keeps the default functionality in general, 
however the code concept is designed for maximum compatibility for future addons that uses *player_build*.

###### Why?
There are many great mods out there that reuses whole *player_build.sqf* file. Thousands of servers out there are running
customized file uploaded to MPMissions instead. Basically original file is not even used in-game, just as a reference (unless it's a vanilla server, which is rare).
Many addons reuses this file only to change or add few variables and in most cases only rare few addons are compatible with each other.

###### How does it work?
It's quite simple concept - player_build is simply split apart into multiple files and defined as functions.
..* Default player build is actually modularly built from collection of these functions
..* These functions can receive arguments and send arrays back to caller with handles
..* Fully change outcome of single function by sending it your own customized variables with a single line of code
..* You are not forced to use all functions, this way you can design a custom mod bypassing some unneeded functions (i.e admin build)
..* You can redesign your own functions and reuse *modular player_build* functions in any combination you want
..* This will save mission file sizes for custom addons since most of code is actually inside client files and controlled externally
..* Addon makers that will work together on this project will most likely have their projects fully compatible

###### Can I contribute code or help in any other way?
Yes, you can! Also any testing and bug reports will help us big time.

###### Is this gonna be in official Dayz Epoch build?
No idea, that would be awesome, if this concept works out, I'd say this mod should be almost a "must".

###### What else?
If you have designed popular mod, but it has huge file size and it replaces player_build, there's a good chance it won't be accepted 
as a part of official Dayz even if it would be an awesome toggle-able feature. However modular player_build allows for everyone to 
reuse same files without ever changing them, thus giving ability to initiate their addon from a single file. If we all work together
and create a centralized control file.
This way your mod/addon could be added to Dayz-Epoch client files without ever changing any of default files that would cause incompatibility
plus it will keep the mission file sizes low.

|Changelog						|Author				|Version	|
| ------------------------------|:-----------------:| ---------:|
|Initial concept release		|Raymix				|001		|