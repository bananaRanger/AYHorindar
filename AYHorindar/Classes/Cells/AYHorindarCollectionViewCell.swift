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

//MARK: AYHorindarCollectionViewCell cell class
class AYHorindarCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var lblTopText: UILabel!
  @IBOutlet weak var lblBottomText: UILabel!
}

//MARK: - AYHorindarCollectionViewCell cell class extension
extension AYHorindarCollectionViewCell {
  func setWeekday(_ weekday: String, day: Int, itemDisplayType: AYItemDisplayType?) {
    switch itemDisplayType ?? .weekWithDay {
    case .weekWithDay:
      lblTopText.text = weekday
      lblBottomText.text = String(day)
    case .dayWithWeek:
      lblTopText.text = String(day)
      lblBottomText.text = weekday
    }
  }
  
  func setTopTextFont(_ font: UIFont?) {
    let font = font ?? .systemFont(ofSize: 16)
    lblTopText.font = font
  }
  
  func setBottomTextFont(_ font: UIFont?) {
    let font = font ?? .systemFont(ofSize: 16)
    lblBottomText.font = font
  }
  
  func setTopTextColor(_ color: UIColor?) {
    let color = color ?? UIColor.black
    lblTopText.textColor = color
  }
  
  func setBottomTextColor(_ color: UIColor?) {
    let color = color ?? UIColor.black
    lblBottomText.textColor = color
  }
}
