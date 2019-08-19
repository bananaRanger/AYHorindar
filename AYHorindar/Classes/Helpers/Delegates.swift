// MIT License
//
// Copyright (c) 2019 Anton Yereshchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

//MARK: AYNameDisplayType enum
public enum AYNameDisplayType: Int {
  case fully
  case short
  case veryShort
}

//MARK: - AYItemDisplayType enum
public enum AYItemDisplayType: Int {
  case weekWithDay
  case dayWithWeek
}



//MARK: - AYHorindarDelegate protocol
public protocol AYHorindarDelegate: class {
  func current(date: Date)
}

//MARK: - AYHorindarDataSource protocol
public protocol AYHorindarDataSource: class {
  func locale() -> Locale
  
  func dateFrom() -> Date
  func dateTo() -> Date
  func selectedDate() -> Date
  
  func itemDisplayType() -> AYItemDisplayType
  func weekdayNameDisplayType() -> AYNameDisplayType
}

//MARK: - AYHorindarUIDelegate protocol
public protocol AYHorindarUIDelegate: class {
  func backgorundColor() -> UIColor
  
  func contentInsets() -> UIEdgeInsets
  
  func spacing() -> CGFloat
  
  func topLabelFont() -> UIFont
  func bottomLabelFont() -> UIFont
  
  func topLabelTextColor() -> UIColor
  func bottomLabelTextColor() -> UIColor
  
  func topLabelSelectedTextColor() -> UIColor
  func bottomLabelSelectedTextColor() -> UIColor
}
