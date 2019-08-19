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

import UIKit

//MARK: AYHorindarViewController
public class AYHorindarViewController: UIViewController {
  
  //MARK: - properies
  public weak var uiDelegate: AYHorindarUIDelegate?
  public weak var delegate: AYHorindarDelegate?
  public weak var dataSource: AYHorindarDataSource?
  
  private var dates = [Date]()
  
  private var previousCurrentDate: Date?

  private var layout: UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    guard let uiDelegate = uiDelegate else { return layout }
    layout.minimumInteritemSpacing = uiDelegate.spacing()
    layout.sectionInset = uiDelegate.contentInsets()
    layout.minimumLineSpacing = uiDelegate.spacing()
    return layout
  }
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: view.bounds,
      collectionViewLayout: layout)

    let bundle = Bundle(for: AYHorindarViewController.self)
    
    collectionView.register(
      UINib(nibName: AYHorindarCollectionViewCell.className, bundle: bundle),
      forCellWithReuseIdentifier: AYHorindarCollectionViewCell.className)

    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.delegate = self
    collectionView.dataSource = self
    
    return collectionView
  }()
  
  //MARK: - methods
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = uiDelegate?.backgorundColor()
  
    view.addSubview(collectionView)
    view.addAllSidesAnchors(to: collectionView)
    
    dates = AYDateManager.dates(
      between: dataSource?.dateFrom(),
      and: dataSource?.dateTo())
    
    previousCurrentDate = dataSource?.selectedDate() ?? Date()
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didRotate(notification:)),
      name: UIDevice.orientationDidChangeNotification,
      object: nil)
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(
      self,
      name: UIDevice.orientationDidChangeNotification,
      object: nil)
  }

  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionView.collectionViewLayout.invalidateLayout()
    collectionViewAnimating()
  }
  
  @objc func didRotate(notification: Notification) {
    guard let index = dates.firstIndex(
      where: { $0.isSpecificDay(previousCurrentDate) } ) else { return }
    
    collectionView.selectItem(
      at: IndexPath(row: index, section: 0),
      animated: true,
      scrollPosition: .centeredHorizontally)
    
    collectionViewAnimating()
  }
}

//MARK: - UICollectionViewDataSource implementation
extension AYHorindarViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView,
                             numberOfItemsInSection section: Int) -> Int {
    return dates.count
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: AYHorindarCollectionViewCell.className,
      for: indexPath) as! AYHorindarCollectionViewCell
    
    cell.setTopTextFont(uiDelegate?.topLabelFont())
    cell.setBottomTextFont(uiDelegate?.bottomLabelFont())

    let date = dates[indexPath.row]
    
    let weekday = AYDateManager.week(
      for: date,
      with: dataSource?.weekdayNameDisplayType(),
      and: dataSource?.locale())
    
    cell.setWeekday(
      weekday,
      day: date.day,
      itemDisplayType: dataSource?.itemDisplayType())
        
    return cell
  }
}

//MARK: - UICollectionViewDelegateFlowLayout implementation
extension AYHorindarViewController: UICollectionViewDelegateFlowLayout {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    collectionViewAnimating()
    currentDateDetecting()
  }

  public func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                       willDecelerate decelerate: Bool) {
    collectionViewCentering()
  }

  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    collectionViewCentering()
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             didSelectItemAt indexPath: IndexPath) {
    collectionView.scrollToItem(
      at: indexPath,
      at: .centeredHorizontally,
      animated: true)    
  }

  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             insetForSectionAt section: Int) -> UIEdgeInsets {
    
    guard let collectionViewFlowLayout = collectionView.collectionViewLayout
      as? UICollectionViewFlowLayout else { return .zero }

    let totalCellHeight = collectionViewFlowLayout.itemSize.height
    let totalCellWidth = collectionViewFlowLayout.itemSize.width

    let leftInset = (collectionView.bounds.width - totalCellWidth) / 2
    let rightInset = leftInset

    let horizontalSpacing = collectionView.bounds.height - totalCellHeight

    return UIEdgeInsets(
      top: horizontalSpacing / 2,
      left: leftInset,
      bottom: horizontalSpacing / 2,
      right: rightInset)
  }
}

//MARK: - AYHorindarViewController fileprivate extension
fileprivate extension AYHorindarViewController {
  func collectionViewCentering() {
    let initialPinchPoint = CGPoint(
      x: collectionView.center.x + collectionView.contentOffset.x,
      y: collectionView.center.y + collectionView.contentOffset.y);

    guard let index = collectionView.indexPathForItem(at: initialPinchPoint) else { return }
    collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
  }
  
  func collectionViewAnimating() {
    let minScaleX = CGFloat(0.16)
    
    let centerX = collectionView.contentOffset.x + collectionView.frame.size.width / 2
    for cell in collectionView.visibleCells {
      guard let cell = cell as? AYHorindarCollectionViewCell else { return }
      
      var offsetX = centerX - cell.center.x
      offsetX = offsetX < 0 ? offsetX * -1 : offsetX

      cell.transform = .identity

      if offsetX > 0 {
        let offsetPercentage = offsetX / view.bounds.width
        var scaleX = 1 - offsetPercentage

        if scaleX < minScaleX {
          scaleX = minScaleX
        }
        cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
        cell.setTopTextColor(uiDelegate?.topLabelTextColor())
        cell.setBottomTextColor(uiDelegate?.bottomLabelTextColor())
      }
    }
  }
  
  func currentDateDetecting() {
    let initialPinchPoint = CGPoint(
      x: collectionView.center.x + collectionView.contentOffset.x,
      y: collectionView.center.y + collectionView.contentOffset.y);
    
    guard let index = collectionView.indexPathForItem(at: initialPinchPoint) else { return }
    if previousCurrentDate?.isSpecificDay(dates[index.row]) == false {
      previousCurrentDate = dates[index.row]
      delegate?.current(date: dates[index.row])
    }
    
    guard let cell = collectionView.cellForItem(at: index)
      as? AYHorindarCollectionViewCell else { return }
    
    cell.setTopTextColor(uiDelegate?.topLabelSelectedTextColor())
    cell.setBottomTextColor(uiDelegate?.bottomLabelSelectedTextColor())
  }
}

