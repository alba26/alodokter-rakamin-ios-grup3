//
//  ArticleViewController.swift
//  Alodokter_Rakamin_Bootcamp
//
//  Created by aurelia natasha on 07/12/21.
//

import UIKit

class ArticleViewController: UIViewController {
    

    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var categoryMenu: UIButton!
    @IBOutlet weak var categoryView: UIView!
    
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    @IBOutlet weak var profileNavItemView: UIView!
    @IBOutlet weak var profileNavImageView: UIImageView!

    
    var imageArray = ["ArticleImage","ArticleImage","ProfileImage"]
    var timer : Timer?
    var currentCellIndex: Int = 0
    
    var viewModel = ArticleViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        
        articleCollectionView.collectionViewLayout = setupCollectionViewLayout()
        sliderCollectionView.collectionViewLayout = setupImageSliderViewLayout()
        pageControl.numberOfPages = imageArray.count //viewModel. HeroArticlesData.count
        viewModel.getArticlesData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.slideToNext), userInfo: nil, repeats: true)
        }
        setUpMenu()
    }
    
    @objc func slideToNext(){
        if currentCellIndex < imageArray.count //diganti ke pagecontrol.numberofpages ato viewModel HeroArticles.count
        {
            let index = IndexPath.init(item: currentCellIndex, section: 0)
            self.sliderCollectionView.scrollToItem(at:  index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentCellIndex
            currentCellIndex += 1
        }
        else {
            currentCellIndex = 0
            let index = IndexPath.init(item: currentCellIndex, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = currentCellIndex
            currentCellIndex = 1
        }
    }
    
    func configNavigationBar(){
        
        //search bar
        let searchArticleController = UISearchController(searchResultsController: ArticleSearchViewController())
        searchArticleController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchArticleController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchArticleController.searchBar.tintColor = UIColor.white
        searchArticleController.searchBar.barTintColor = UIColor.white
        searchArticleController.searchBar.searchTextField.backgroundColor = UIColor.white
        searchArticleController.searchBar.delegate = self

        
        //right attribute
        let profileNavView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        profileImageView.image = UIImage(named: "ProfileImage")
        profileImageView.contentMode = UIView.ContentMode.scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.layer.masksToBounds = true
        profileNavView.addSubview(profileImageView)
        profileImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileMenuTapped(sender:)))
        profileImageView.addGestureRecognizer(tap)
        let rightBarButton = UIBarButtonItem(customView: profileNavView)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.rightBarButtonItem?.target = self

    

        //kasih trailing leading constraintnya right attribute
        
    }
    
    @objc func profileMenuTapped(sender: UIBarButtonItem) {
        if !UserDefaults().checkIsUserLogin(){
            let loginStoryboard : UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.navigationController?.pushViewController(loginVC, animated: true)
        }else{
            let profileStoryboard : UIStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
            let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController")
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    func setupImageSliderViewLayout() -> UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(245))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 16
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 100
        layout.configuration = config
        
        
        return layout
        
    }

    func setUpMenu() {
        categoryView.layer.borderWidth = 1
        categoryView.layer.borderColor = UIColor.black.cgColor
        categoryView.layer.cornerRadius = 10
        
        let menu = UIMenu(title: "Category", options: .displayInline, children: [
            UIAction(title: "Trending") {(_) in self.categoryMenu.titleLabel?.text = "Trending"},
            UIAction(title: "Kesehatan") {(_) in self.categoryMenu.titleLabel?.text = "Kesehatan"},
            UIAction(title: "Keluarga") {(_) in self.categoryMenu.titleLabel?.text = "Keluarga"},
        ])
        
        self.categoryMenu.menu = menu
        self.categoryMenu.showsMenuAsPrimaryAction = true
    }
    
    func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 16
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 100
        layout.configuration = config
        
        
        return layout
        
    }
}


extension ArticleViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.articleCollectionView {
//            return viewModel.listOfArticle?.count ?? 0
            return 12
        }
        else {
            //viewmodel heroArticle.count
            return imageArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.articleCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as! ArticleCollectionViewCell
//                cell.articleTitleLabel.text = viewModel.listOfArticle?[indexPath.row].title
                cell.articleTitleLabel.text = "4 Manfaat Daun Sambiloto untuk Kulit yang Sayang Dilewatkan"
                cell.articleImageView.image = UIImage(named: "ArticleImage")
//                let imgURL = URL(string: (viewModel.listOfArticle?[indexPath.row].image)!)
//                let data = try? Data(contentsOf: imgURL!)
//                cell.articleImageView.image = UIImage(data: data!)
        
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSliderCell", for: indexPath) as! ImageSliderCollectionViewCell
        //assign viewmodel
        cell.imageSliderImg.image = UIImage(named: imageArray[indexPath.row])
        cell.imageSliderTitle.text = "4 Manfaat Daun Sambiloto untuk Kulit yang Sayang Dilewatkan"
        cell.imageSliderTitle.backgroundColor = UIColor.black
        cell.imageSliderTitle.textColor = UIColor.white
        
        return cell
        
    }
}

extension ArticleViewController : UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ArticleSearchViewController().searchResultTableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! ArticleSearchTableViewCell
        cell.articleSearchImage.image = UIImage(named: "ArticleImage")
        cell.articleSearchTitleLabel.text = "4 Manfaat Daun"
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        let searchResultVC = searchController.searchResultsController as? ArticleSearchViewController
        
        
        print(searchText) // call api get data or filter api get data
    }
    
    
}



