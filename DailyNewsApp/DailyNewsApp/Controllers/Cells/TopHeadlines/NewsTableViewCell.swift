//
//  NewsTableViewCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 22.03.23.
//

import UIKit

class NewsTableViewCellViewModel {
     let title: String
     let subtitle: String
    let url: String?
     let imageURL: URL?
     var imageData: Data? = nil

    init(title: String, subtitle: String, imageURL: URL?, url: String?) {
         self.title = title
         self.subtitle = subtitle
         self.imageURL = imageURL
         self.url = url
     }
 }

 class NewsTableViewCell: UITableViewCell {

     static let key = "NewsTableViewCell"

     lazy var newsTitleLbl: UILabel = {
         let lbl = UILabel()
         lbl.numberOfLines = 0
         lbl.font = .systemFont(ofSize: 25, weight: .bold)
         return lbl
     }()

     private let newsSubtitleLbl: UILabel = {
         let lbl = UILabel()
         lbl.numberOfLines = 0
         lbl.font = .systemFont(ofSize: 18, weight: .regular)
         return lbl
     }()

     private let newsImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.layer.cornerRadius = 6
         imageView.layer.masksToBounds = true
         imageView.clipsToBounds = true
         imageView.backgroundColor = .secondarySystemBackground
         imageView.contentMode = .scaleAspectFill
         return imageView
     }()
     
     lazy var urlTitleLbl: UILabel = {
         let lbl = UILabel()
         lbl.numberOfLines = 0
         lbl.font = .systemFont(ofSize: 25, weight: .bold)
         return lbl
     }()

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.addSubview(newsTitleLbl)
         contentView.addSubview(newsSubtitleLbl)
         contentView.addSubview(newsImageView)
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     override func layoutSubviews() {
         super.layoutSubviews()

         newsTitleLbl.frame = CGRect(x: 10,
                                     y: 0,
                                     width: contentView.frame.size.width - 170,
                                     height: 70)

         newsSubtitleLbl.frame = CGRect(x: 10,
                                     y: 70,
                                     width: contentView.frame.size.width - 170,
                                     height: contentView.frame.size.height/2)

         newsImageView.frame = CGRect(x: contentView.frame.size.width - 150,
                                     y: 5,
                                     width: 145,
                                     height: contentView.frame.size.height - 10)
     }

     override func prepareForReuse() {
         super.prepareForReuse()
         newsTitleLbl.text = nil
         newsSubtitleLbl.text = nil
         newsImageView.image = nil
     }

     func configure(with viewModel: NewsTableViewCellViewModel) {
         newsTitleLbl.text = viewModel.title
         newsSubtitleLbl.text = viewModel.subtitle
         urlTitleLbl.text = viewModel.url
         newsImageView.image = UIImage(named: "no_image")

         if let data = viewModel.imageData {
             newsImageView.image = UIImage(data: data)
         } else if let url = viewModel.imageURL {
             URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                 guard let data = data, error == nil else { return }
                 viewModel.imageData = data
                 DispatchQueue.main.async {
                     self?.newsImageView.image = UIImage(data: data)
                 }
             }.resume()
         }
     }
 }
