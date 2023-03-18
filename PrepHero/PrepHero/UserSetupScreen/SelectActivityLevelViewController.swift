//
//  SelectActivityLevelViewController.swift
//  PrepHero
//
//  Created by Cloy Vserv on 17/02/23.
//

import UIKit

class SelectActivityLevelViewController: UIViewController {
    let viewFactory = CustomViewFactory()
    let viewControllerPresenter = ViewControllerPresenter()
    var stackView: UIStackView?
    var heading: UILabel?
    var subHeading: UILabel?
    var previousButton: UIButton?
    var nextButton: UIButton?
    var skipButton: UIButton?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var activityViews: [ActivityView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpPageView()
    }
    @objc func actionNext(){
        if let nextVC = viewControllerPresenter.getNextViewController(current: self, nextVC: SelectLocationViewController.self) {
            self.present(nextVC, animated: true)
        }
    }
    @objc func actionPrevious(){
        self.dismiss(animated: true)
    }
}

extension SelectActivityLevelViewController {
    func setUpViews() {
        let stackAndSkip = viewFactory.getProcessAndSkip(view: view, currentStep: 7, totalSteps: 9)
        stackView = stackAndSkip.0
        skipButton = stackAndSkip.1
        heading = viewFactory.getHeading(view: view)
        heading?.text = PageHeadings.activityLevel.rawValue
        subHeading = viewFactory.getSubHeading(view: view)
        subHeading?.text = PageSubHeading.activityLevel.rawValue
        previousButton = viewFactory.getPreviousButton(view: view)
        nextButton = viewFactory.getNextButton(view: view)
        previousButton?.addTarget(self, action: #selector(actionPrevious), for: .touchUpInside)
        nextButton?.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
    }
}

extension SelectActivityLevelViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension SelectActivityLevelViewController {
    func setUpPageView() {
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        
        activityViews = createActivities()
        setUpPages(activities: activityViews)
        
        pageControl.numberOfPages = activityViews.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        //pageControl.backgroundColor = .blue
        pageControl.pageIndicatorTintColor = UIColor(hex: "#DADADA")
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "#FAA21C")
    }
    func createActivities() -> [ActivityView] {
        let activityView1: ActivityView = Bundle.main.loadNibNamed("ActivityView", owner: self, options: nil)?.first as! ActivityView
        activityView1.imageView.image = UIImage(named: "Activity1")
        activityView1.containerView.backgroundColor = AppColors.viewActivity
        activityView1.labelHeading.text = "Sedentary"
        activityView1.labelSubHeading.text = "I usually not moving around. Working at a desk"
        viewFactory.customizeActivtyHeading(label: activityView1.labelHeading)
        viewFactory.customizeSubActivtyHeading(label: activityView1.labelSubHeading)
        
        let activityView2: ActivityView = Bundle.main.loadNibNamed("ActivityView", owner: self, options: nil)?.first as! ActivityView
        activityView2.imageView.image = UIImage(named: "Activity2")
        activityView2.containerView.backgroundColor = AppColors.viewActivity
        activityView2.labelHeading.text = "Light"
        activityView2.labelSubHeading.text = "I usually do some yoga, work around house, take out the rubbish... "
        viewFactory.customizeActivtyHeading(label: activityView2.labelHeading)
        viewFactory.customizeSubActivtyHeading(label: activityView2.labelSubHeading)
        
        let activityView3: ActivityView = Bundle.main.loadNibNamed("ActivityView", owner: self, options: nil)?.first as! ActivityView
        activityView3.imageView.image = UIImage(named: "Activity3")
        activityView3.containerView.backgroundColor = AppColors.viewActivity
        activityView3.labelHeading.text = "Moderate"
        activityView3.labelSubHeading.text = "Walking, cycling and even shopping around."
        viewFactory.customizeActivtyHeading(label: activityView3.labelHeading)
        viewFactory.customizeSubActivtyHeading(label: activityView3.labelSubHeading)
        
        let activityView4: ActivityView = Bundle.main.loadNibNamed("ActivityView", owner: self, options: nil)?.first as! ActivityView
        activityView4.imageView.image = UIImage(named: "Activity4")
        activityView4.containerView.backgroundColor = AppColors.viewActivity
        activityView4.labelHeading.text = "Vigerous"
        activityView4.labelSubHeading.text = "Playing football, dancing, swimming."
        viewFactory.customizeActivtyHeading(label: activityView4.labelHeading)
        viewFactory.customizeSubActivtyHeading(label: activityView4.labelSubHeading)
        
        let activityView5: ActivityView = Bundle.main.loadNibNamed("ActivityView", owner: self, options: nil)?.first as! ActivityView
        activityView5.imageView.image = UIImage(named: "Activity5")
        activityView5.containerView.backgroundColor = AppColors.viewActivity
        activityView5.labelHeading.text = "Very Vigerous"
        activityView5.labelSubHeading.text = "Sprinting up hill, weight exercises, press ups."
        viewFactory.customizeActivtyHeading(label: activityView5.labelHeading)
        viewFactory.customizeSubActivtyHeading(label: activityView5.labelSubHeading)
        
        return [activityView1,activityView2,activityView3,activityView4,activityView5]
    }
    func setUpPages(activities: [ActivityView]) {
        //        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(activities.count) , height: scrollView.frame.height)
        //        scrollView.isPagingEnabled = true
        //        for i in 0 ..< activities.count {
        //            activities[i].frame = CGRect(x: view.frame.width * CGFloat(i) , y: 230 , width: view.frame.width, height: scrollView.frame.height)
        //            scrollView.addSubview(activities[i])
        //        }
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(activities.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< activities.count {
            activities[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(activities[i])
        }
    }
}
