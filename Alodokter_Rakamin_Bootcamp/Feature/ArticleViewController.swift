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
    
    override func viewWillAppear(_ animated: Bool) {
        articleCollectionView.collectionViewLayout = setupCollectionViewLayout()
        sliderCollectionView.collectionViewLayout = setupImageSliderViewLayout()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        setUpMenu()
    }
    
    @objc func slideToNext(){
        if currentCellIndex < imageArray.count-1
        {
            currentCellIndex += 1
        }
        else {
            currentCellIndex = 0
        }
        sliderCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }
    
    func configNavigationBar(){
        
        //search bar
        let searchArticleController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchArticleController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchArticleController.searchBar.tintColor = UIColor.white
        searchArticleController.searchBar.barTintColor = UIColor.white
        searchArticleController.searchBar.searchTextField.backgroundColor = UIColor.white
        
        
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
//        self.navigationItem.rightBarButtonItem?.action = #selector(profileMenuTapped(sender:))
        self.navigationItem.rightBarButtonItem?.action = #selector(test)
        
    
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: profileImageView.image, style: .plain, target: self, action: #selector(profileMenuTapped(sender:)))
    

        //kasih trailing leading constraintnya right attribute
        
    }
    
    @objc func test(){
        print("Clicked")
    }
    
    @objc func profileMenuTapped(sender: UIBarButtonItem) {
        let profileStoryboard : UIStoryboard = UIStoryboard(name: "UserProfile", bundle: nil)
        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController")

        self.navigationController?.pushViewController(profileVC, animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ArticleViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.articleCollectionView {
            return 30
        }
        else {
            return imageArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.articleCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as! ArticleCollectionViewCell
        
//          cell.articleTitleLabel.text = "Artikel ke \(String(indexPath.item+1))"
        
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSliderCell", for: indexPath) as! ImageSliderCollectionViewCell
        cell.imageSliderImg.image = UIImage(named: imageArray[indexPath.row])
        cell.imageSliderTitle.text = "4 Manfaat Daun Sambiloto untuk Kulit yang Sayang Dilewatkan"
        cell.imageSliderTitle.backgroundColor = UIColor.black
        cell.imageSliderTitle.textColor = UIColor.white
        return cell
        
    }
}



