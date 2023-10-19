# InPost Recruitment Task

## Intro

We travel back in time ⏱️. InPost Mobile app was just created and you join the team to improve its feature set and **make it ready for the future**.\
User base is growing fast and every day more people start to use it daily.
\
\
You, as an experienced developer, were assigned to the project to improve its quality. The initial code is not perfect and is far from being.
**Organize and refactor code the way you like to work** (packages, modules, layers, data flow, names, methods order etc.) while finishing your tasks listed below.

## Rules

- We expect the complete solution - your tasks should be considered as ready for code review or release
- When refactoring, please keep the way how the app looks like from user perspective (excluding the changes we will ask you to do)
- You can change and move any part you like, install any library you want as long as final product is within the rules
- We are using static JSON files as responses, **consider it being a real server** returning your data 😉 Just as it would be a real production environment
- Please don't change JSON files
- Git history is also important

## Tasks

- Add grouping to the list of `Pack`s
- Style as requested from the Design department ([Figma link](https://www.figma.com/file/MzPR3whRl6KB1fFnkyM6Or/recruitment-task?node-id=0%3A1)):
    - Groups
    - App background
    - Fonts (typography and style)
    - Add image in the corner of the list cell
- Sort list items in groups by:
    - status (priority is described in `Pack.swift`)
    - pickupDate 
    - expireDate 
    - storedDate 
    - id
- Add pull to refresh and handle refresh progress 
- Add storing shipments locally (using Realm)
- Add local archiving of the shipment
    - For example via gesture, design is not important here
    - `Pack` must stay hidden after relaunching the app
- Fix one `Pack` appearing with unsupported status
- Fix ViewController title disappearing in Dark Mode
- Create unit tests

And remember: prepare app for the future the best way you can.

## Links and resources

- Fonts folder: [/Fonts](./Fonts)

If for some reason Figma link stops working, here you can see the requested design:

![Design from Figma](./Images/Figma.png)

# Good luck! 💪
