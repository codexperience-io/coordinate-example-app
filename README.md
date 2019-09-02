# Coordinate Library Example App

This is a showcase of [**Coordinate**](https://coordinate.codexperience.io/). Here you can see how the concepts of the library are applied in real code.

This is a simple App for viewing a list of racing teams and their respective drivers. The full list of features is the following:
- A splash screen
- Main Navigation, made of a 3 tabs:
	- Teams
	- Drivers
	- Profile
- Teams and Drivers are lists of items
- Clicking on a Team or Driver item should show the detail view of the respective item
- Teams and Drivers can be favorite 
- Profile tab shows and manages the list of favorite items

Pretty simple, right? The idea is to illustrate how simple it is to **re-use** UIViewControllers, independent of the where they are in the Navigation Flow and also how easy it is to communicate between the various parts of the structure.

## Installation

To install, at the root folder (where the Podfile is) run:

```
pod install
```

## Documentation

You can read about **Coordinate** at [https://coordinate.codexperience.io/](https://coordinate.codexperience.io/).

As for the source code in this repo, it has many comment explaining often how and why things are done.
