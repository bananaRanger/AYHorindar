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

extension Date {
  var startOfMonth: Date? {
    let calendar = Calendar.current
    let components = calendar.dateComponents(
      [.year, .month],
      from: calendar.startOfDay(for: self))
    return calendar.date(from: components)
  }
  
  var endOfMonth: Date? {
    guard let startOfMonth = startOfMonth else { return nil }
    let calendar = Calendar.current
    let components = DateComponents(month: 1, day: -1)
    return calendar.date(byAdding: components, to: startOfMonth)
  }
}

extension Date {
  static func dates(from: Date, to: Date) -> [Date] {
    let calendar = Calendar.current
    let intervalNumber = 1
    var current = from
    
    var dates = [Date]()
    
    while current <= to {
      dates.append(current)
      guard let date = calendar.date(
        byAdding: .day,
        value: intervalNumber,
        to: current) else { break }
      current = date
    }
    
    return dates
  }
}

extension Date {
  var day: Int {
    return Calendar.current.component(.day, from: self)
  }
  
  var weekday: Int {
    return Calendar.current.component(.weekday, from: self)
  }
  
  var month: Int {
    return Calendar.current.component(.month, from: self)
  }
  
  var year: Int {
    return Calendar.current.component(.year, from: self)
  }
}

extension Date {
  func isSpecificDay(_ date: Date?) -> Bool {
    return day == date?.day && month == date?.month && year == date?.year
  }
}

public extension Date {
  var log: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: self)
  }
}
