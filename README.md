# AYHorindar

[![CI Status](https://img.shields.io/travis/antonyereshchenko@gmail.com/AYHorindar.svg?style=flat)](https://travis-ci.org/antonyereshchenko@gmail.com/AYHorindar)
[![Version](https://img.shields.io/cocoapods/v/AYHorindar.svg?style=flat)](https://cocoapods.org/pods/AYHorindar)
[![License](https://img.shields.io/cocoapods/l/AYHorindar.svg?style=flat)](https://cocoapods.org/pods/AYHorindar)
[![Platform](https://img.shields.io/cocoapods/p/AYHorindar.svg?style=flat)](https://cocoapods.org/pods/AYHorindar)

<p align="center">
  <img width="50%" height="50%" src="https://github.com/bananaRanger/AYHorindar/blob/master/Resources/logo.png?raw=true">
</p>

## About

Customizable horizontal calendar view controller.

### Demo

<p align="center">
  <img width="60%" height="60%" src="https://github.com/bananaRanger/AYHorindar/blob/master/Resources/demo.png?raw=true">
</p>

## Installation

AYHorindar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
inhibit_all_warnings!

target 'YOUR_TARGET_NAME' do
  use_frameworks!
	pod 'AYHorindar'
end
```

## Usage

```swift
// 'horindarDelegate' - object that conform to protocol 'AYHorindarDelegate'.
// 'horindarUIDelegate' - object that conform to protocol 'AYHorindarUIDelegate'.
// 'horindarDataSource' - object that conform to protocol 'AYHorindarDataSource'.
// 'someView' - UIView on which you want add the horizontal calendar.

let calendar = AYHorindarViewController()

calendar.delegate = horindarDelegate
calendar.uiDelegate = horindarUIDelegate
calendar.dataSource = horindarDataSource

someView.addSubview(calendar.view)
someView.addAllSidesAnchors(to: calendar.view)
```

#### AYHorindarUIDelegate

<p align="center">
  <img width="100%" height="100%" src="https://github.com/bananaRanger/AYHorindar/blob/master/Resources/UIDelegate.png?raw=true">
</p>


## Author

Anton Yereshchenko

## License

AYHorindar is available under the MIT license. See the LICENSE file for more info.
