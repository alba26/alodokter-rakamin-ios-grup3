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
    
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    @IBOutlet weak var profileNavItemView: UIView!
    @IBOutlet weak var profileNavImageView: UIImageView!
    
    
    var imageArray = ["ArticleImage","ArticleImage","ProfileImage"]
    var timer : Timer?
    var currentCellIndex: Int = 0
    
    var viewModel = ArticleViewModel()
    var articleResult : ArticlesModel?
    var filterResult : [Article]?
    var articleHeroResults : [Article]?
    var searchResult : [Article]?
    var totalArticleLoaded : Int = 6
    let searchArticleController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        sliderCollectionView.collectionViewLayout = setupImageSliderViewLayout()
        pageControl.numberOfPages = articleHeroResults?.count ?? 0 //viewModel. HeroArticlesData.count
        getArticlesData()
        articleTableView.delegate = self
        articleTableView.dataSource = self
        contentScrollView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadArticleResult), name: NSNotification.Name(rawValue: "searchArticle"), object: nil)
        
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
        if currentCellIndex < articleHeroResults?.count ?? 0//diganti ke pagecontrol.numberofpages ato viewModel HeroArticles.count
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
    
    
    
    func getArticlesData() {
        let articleService = ArticleService(param: "per_page",value: totalArticleLoaded)
        APIService.APIRequest(model: ArticlesModel.self, req: articleService) { (results) in
            switch(results) {
            case .success(let results):
                DispatchQueue.main.async { [self] in
                    articleResult = results as? ArticlesModel
                    filterResult = articleResult?.data
                    articleHeroResults = articleResult?.data
                    articleTableView.reloadData()
                    getArticlesHeroData()
                    
                    
                }
            case .failure(let error):
                //            failToLoadArticle(title: "Load Artikel Gagal", message: "Terdapat kendala load artikel")
                print(error,"error")
            }
            
        }
    }
    
    @objc func loadList(notification: NSNotification){
        
        sliderCollectionView.reloadData()
        pageControl.numberOfPages = articleHeroResults?.count ?? 0
        
    }
    
    func getArticlesHeroData() {
        articleHeroResults = articleResult?.data.filter {
            $0.headline == false
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
}


extension ArticleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return articleHeroResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSliderCell", for: indexPath) as! ImageSliderCollectionViewCell
        
        if articleHeroResults?[indexPath.row].image.contains("https") == true {
            let imgURL = URL(string: (articleHeroResults?[indexPath.row].image)!)
            let data = try? Data(contentsOf: imgURL!)
            cell.imageSliderImg.image = UIImage(data: data!)
        }
        cell.imageSliderTitle.text = articleHeroResults?[indexPath.row].title
        cell.imageSliderTitle.backgroundColor = UIColor.black
        cell.imageSliderTitle.textColor = UIColor.white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Article", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ArticleDetail") as? ArticleDetailViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ArticleViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        cell.articleTitleLabel.text = filterResult?[indexPath.row].title
        if articleResult?.data[indexPath.row].image.contains("https") == true {
            let imgURL = URL(string: (filterResult?[indexPath.row].image)!)
            let data = try? Data(contentsOf: imgURL!)
            cell.articleImageView.image = UIImage(data: data!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Article", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ArticleDetail") as? ArticleDetailViewController else { return }
        vc.idArticle = String(filterResult?[indexPath.row].id ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == contentScrollView {
            articleTableView.isScrollEnabled = (contentScrollView.contentOffset.y > 0)
        }
        
        if scrollView == articleTableView {
            articleTableView.isScrollEnabled = (articleTableView.contentOffset.y <= 500 || articleTableView.contentOffset.y > 200)
        }
    }
    
    
}

extension ArticleViewController : UISearchResultsUpdating, UISearchBarDelegate{
    @objc func loadArticleResult(notifiaction: NSNotification){
//        print("search", searchArticleResult?.count)
//        let search = searchArticleController.searchResultsController as! ArticleSearchViewController
        
        if searchResult != nil {
//            search.searchResultTableView.reloadData()
            print("disini")
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        filterResult = articleResult?.data.filter({ (data) in
            let searchArticle = data.title
            if searchArticle.lowercased().contains(searchText.lowercased()) {
                return true
            }
            else {
                return false
            }
        })
        self.articleTableView.reloadData()
//        let searchResultVC = searchController.searchResultsController as? ArticleSearchViewController
//        searchResultVC?.view.backgroundColor = UIColor.systemBlue
//        searchResultVC?.searchArticleResult = searchResult
        //load tableview
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchArticle"), object: nil)

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
            UIAction(title: "Trending") { [self](_) in self.categoryMenu.titleLabel?.text = Category.trending.rawValue
                filterResult = articleResult?.data.filter({ (data) in
                    let category = data.category
                    if category.rawValue.contains(Category.trending.rawValue) {
                        return true
                    }
                    else {
                        return false
                    }
                })
                self.articleTableView.reloadData()
            },
            UIAction(title: "Kesehatan") { [self](_) in self.categoryMenu.titleLabel?.text = Category.kesehatan.rawValue
                filterResult = articleResult?.data.filter({ (data) in
                    let category = data.category
                    if category.rawValue.contains(Category.kesehatan.rawValue) {
                        return true
                    }
                    else {
                        return false
                    }
                })
                self.articleTableView.reloadData()
            },
            UIAction(title: "Keluarga") { [self](_) in self.categoryMenu.titleLabel?.text = Category.keluarga.rawValue
                filterResult = articleResult?.data.filter({ (data) in
                    let category = data.category
                    if category.rawValue.contains(Category.keluarga.rawValue) {
                        return true
                    }
                    else {
                        return false
                    }
                })
                self.articleTableView.reloadData()
            },
            UIAction(title: "Hidup Sehat") { [self](_) in self.categoryMenu.titleLabel?.text = Category.hidupSehat.rawValue
                filterResult = articleResult?.data.filter({ (data) in
                    let category = data.category
                    if category.rawValue.contains(Category.hidupSehat.rawValue) {
                        return true
                    }
                    else {
                        return false
                    }
                })
                self.articleTableView.reloadData()
            },
        ])
        
        self.categoryMenu.menu = menu
        self.categoryMenu.showsMenuAsPrimaryAction = true
    }
    
    func configNavigationBar(){
        
        //search bar
        
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
        profileImageView.circleView()
        profileNavView.addSubview(profileImageView)
        profileImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileMenuTapped(sender:)))
        profileImageView.addGestureRecognizer(tap)
        let rightBarButton = UIBarButtonItem(customView: profileNavView)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.rightBarButtonItem?.target = self
        
        
        
        //kasih trailing leading constraintnya right attribute
        
    }
    
}



