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

import Foundation

class AYDateManager {
  
  //MARK: - methods
  static func dates(between lhs: Date?, and rhs: Date?) -> [Date] {
    guard let lhs = lhs,
      let rhs = rhs else { return [Date]() }
    
    if lhs < rhs {
      return Date.dates(from: lhs, to: rhs)
    } else {
      return Date.dates(from: rhs, to: lhs)
    }
  }
  
  static func week(for date: Date,
            with nameDisplayType: AYNameDisplayType?,
            and locale: Locale?) -> String {
    let formatter = DateFormatter()
    formatter.locale = locale ?? .current
    switch nameDisplayType ?? .veryShort {
    case .fully:
      return formatter.standaloneWeekdaySymbols[date.weekday - 1].capitalized
    case .short:
      return formatter.shortStandaloneWeekdaySymbols[date.weekday - 1].capitalized
    case .veryShort:
      return formatter.veryShortStandaloneWeekdaySymbols[date.weekday - 1].capitalized
    }
  }
  
}
