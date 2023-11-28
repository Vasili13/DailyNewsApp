//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 12.03.23.
//

import Firebase
import FirebaseAuth
import FirebaseStorage
import SafariServices
import SnapKit
import UIKit

// -MARK: MainViewController
final class MainViewController: UIViewController {
    
    private let customID = "customID"
    private var ref: DatabaseReference!
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!
    private var articleList = [Article]()
    
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
        cv.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: customID)
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateNavBar()
        setUpView()
        updateViewConstraints()
    }
    
    private func setUpView() {
        view.addSubview(menuBar)
        view.addSubview(horizontalNewsCollectionView)
    }

    func scrollMenu(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        horizontalNewsCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    private func configurateNavBar() {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "1024")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .done, target: self, action: #selector(openLogFloworUserFlow))
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
    
    @objc func openLogFloworUserFlow() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
            navigationController?.pushViewController(loginVC, animated: true)
        } else {
            guard let userVC = storyboard?.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
            navigationController?.pushViewController(userVC, animated: true)
        }
    }
}

// -MARK: Extension to collectionView and to loadig safari controller

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LoadSafariProtocol {
    
    func loadNewScreen(url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customID, for: indexPath) as? CustomCollectionViewCell else { fatalError() }
        if indexPath.item == 0 {
            cell.getRequest(for: Endpoint.topHeadlines)
        } else if indexPath.item == 1 {
            cell.getRequest(for: Endpoint.entHeadlines)
        } else if indexPath.item == 2 {
            cell.getRequest(for: Endpoint.businessHeadlines)
        } else if indexPath.item == 3 {
            cell.getRequest(for: Endpoint.healthHeadlines)
        } else if indexPath.item == 4 {
            cell.getRequest(for: Endpoint.scienceHeadlines)
        } else if indexPath.item == 5 {
            cell.getRequest(for: Endpoint.sportHeadlines)
        } else if indexPath.item == 6 {
            cell.getRequest(for: Endpoint.techHeadlines)
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        menuBar.scrollMenu(menuIndex: indexPath.item)
    }
}
