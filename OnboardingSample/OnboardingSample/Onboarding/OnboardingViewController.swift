//
//  OnboardingViewController.swift
//  OnboardingSample
//
//  Created by taehy.k on 2021/07/26.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    var onboardingData: [OnboardingDataModel] = []
    var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == onboardingData.count - 1 {
                nextButton.setTitle("Start", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setCollectionView()
        setOnboardingData()
    }
    
    // MARK: - Actions
    @IBAction private func nextButtonTapped(_ sender: Any) {
        if currentPage == onboardingData.count - 1 {
            print("go to main")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - Custom Functions
extension OnboardingViewController {
    private func setUI() {
        nextButton.layer.cornerRadius = 10
        pageControl.isUserInteractionEnabled = false
    }
    
    private func setCollectionView() {
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        
        let onboardingNib = UINib(nibName: OnboardingCollectionViewCell.cellId, bundle: nil)
        onboardingCollectionView.register(onboardingNib, forCellWithReuseIdentifier: OnboardingCollectionViewCell.cellId)
    }
    
    private func setOnboardingData() {
        onboardingData.append(contentsOf: [
            OnboardingDataModel(lottieName: "onboarding1_img",
                                title: "????????? ????????????????",
                                description: "????????? ??????????????? ?????? ????????? ????????????\n????????? ????????? ???????????????"),
            OnboardingDataModel(lottieName: "onboarding2_img",
                                title: "???????????? ????????? ????????????",
                                description: "?????? ???????????? ?????? ???????????? ????????????,\n???????????? ???????????? ????????? ????????? ??? ?????????"),
            OnboardingDataModel(lottieName: "onboarding3_img",
                                title: "?????? ????????? ????????????",
                                description: "?????? ????????? ???????????? ??????????????? ????????????\n????????? ??????????????? ????????? ??? ?????????")
        ])
    }
}

// MARK: - CollectionView Delegate, DataSource
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.cellId, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.setOnboardingSlides(onboardingData[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

// MARK: - CollectionView Delegate Flow Layout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
