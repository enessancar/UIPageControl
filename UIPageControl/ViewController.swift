//
//  ViewController.swift
//  UIPageControl
//
//  Created by Enes Sancar on 19.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    private let imageNames = ["fb", "foto", "kadro", "image", "k", "pether", "sun", "res"]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        return collectionView
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configurePageControl()
        preparePageControl()
    }
        
    private func preparePageControl() {
        pageControl.numberOfPages = imageNames.count
        if #available(iOS 14.0, *) {
            pageControl.addTarget(self,
                                  action: #selector(pageControlValueChanged),
                                  for: .valueChanged)
            pageControl.allowsContinuousInteraction = true
            pageControl.backgroundStyle = .prominent
        }
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
    
    private func configurePageControl() {
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension ViewController {
    @objc private func pageControlValueChanged() {
        collectionView.scrollToItem(at: .init(row: pageControl.currentPage, section: .zero),
                                    at: .centeredHorizontally, animated: true)
    }
}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell,
              let images = UIImage(named: imageNames[indexPath.row]) else {
            fatalError()
        }
        cell.setup(with: images)
        return cell
    }
}
