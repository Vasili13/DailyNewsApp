//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 12.03.23.
//

import UIKit
import SnapKit
import SafariServices
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!
    
    var article1 = [Article]()
    
    lazy var menuBar: MenuBarCollectionView = {
        let mb = MenuBarCollectionView()
        mb.viewController = self
        return mb
    }()
    
    lazy var horizontalNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: topCellId)
        cv.register(EntertainmentCell.self, forCellWithReuseIdentifier: environmentCellId)
        cv.register(BusinessCell.self, forCellWithReuseIdentifier: businessCellId)
        cv.register(HealthCell.self, forCellWithReuseIdentifier: healthCellId)
        cv.register(ScienceCell.self, forCellWithReuseIdentifier: scienceCellId)
        cv.register(SportsCell.self, forCellWithReuseIdentifier: sportsCellId)
        cv.register(TechnologyCell.self, forCellWithReuseIdentifier: technologyCellId)
        
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    private let topCellId = "topCellId"
    private let environmentCellId = "environmentCellId"
    private let businessCellId = "businessCellId"
    private let healthCellId = "healthCellId"
    private let scienceCellId = "scienceCellId"
    private let sportsCellId = "sportsCellId"
    private let technologyCellId = "technologyCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateNavBar()
        view.addSubview(menuBar)
        view.addSubview(horizontalNewsCollectionView)
        
        ref = Database.database().reference(withPath: "users")
        
        updateViewConstraints()
    }
    
    func scrollMenu(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        horizontalNewsCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    private func configurateNavBar() {
        navigationItem.title = "News"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), style: .done, target: self, action: #selector(onButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle.fill"), style: .done, target: self, action: #selector(searchInfo))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        menuBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        horizontalNewsCollectionView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.top.equalTo(menuBar.snp.bottom)
        }
    }
    
    @objc func searchInfo() {
        guard let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func onButtonTapped() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
            navigationController?.pushViewController(loginVC, animated: true)
        } else {
            guard let userVC = storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
            navigationController?.pushViewController(userVC, animated: true)
        }
    }
    
    deinit {
        print("deinit main")
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyProtocol {
    
    func loadNewScreen(url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellId, for: indexPath) as! CategoryCell
        cell.delegate = self
        
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: environmentCellId, for: indexPath) as! EntertainmentCell
        } else if indexPath.item == 2 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: businessCellId, for: indexPath) as! BusinessCell
        } else if indexPath.item == 3 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: healthCellId, for: indexPath) as! HealthCell
        } else if indexPath.item == 4 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: scienceCellId, for: indexPath) as! ScienceCell
        } else if indexPath.item == 5 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: sportsCellId, for: indexPath) as! SportsCell
        } else if indexPath.item == 6 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: technologyCellId, for: indexPath) as! TechnologyCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height )
    }
}
