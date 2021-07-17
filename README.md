# RealityKit-Text

This is a convenience package for creating and positioning text in RealityKit.

## Overview

By default, the origin point of text made programmatically in RealityKit is in the bottom-left corner of the text.
This becomes problematic when you want to place the center of the text at a particular location, but you end up placing the bottom-left corner of the text at that location instead.
This package provides an easy way to overcome this problem, and an easy way to generate text programmatically.

## Minimum Requirements
  - Swift 5.2
  - iOS 13.0 (RealityKit)
  - Xcode 11


## Installation

### Swift Package Manager

To add this package to your  Xcode 11+ project:

Go to File > Swift Packages > Add Package Dependency, and paste in this link:
`https://github.com/Reality-Dev/RealityKit-Text`

---
## Usage

See the [Example](./RealityKit-Text-Example) for a full working example.

- After installing, import `TextEntity` to your .swift file
- Create an instance of TextEntity:
`let myTextEntity = TextEntity()`

## Important

All inputs to the initilazer have default values so they are all optional.
These include:
* text
* color
* isLit
* size
* isMetallic
* fontName
* extrustionDepth, and
* alignment


^You may include as many or as few of them as you like when you create your text.
If you pass no inputs into the initializer by just writing,
    `let myTextEntity = TextEntity()`
then you will get blue metallic Helvetica text that says "Hello World"

You can also change any of the properties of the text and the entity will automatically update/re-generate.
For example, if I change the color to red `myTextEntity.color = .red` then the color of the 3D text will automatically update, and if I change the text to a different string `myTextEntity.text = "Hello Universe"` then the text mesh of the 3D text will automatically update.

If anything is unclear, please [send me a tweet](https://twitter.com/gmj4k)

If you see a way things can be done better please feel free to contribute by making a fork & pull request.







