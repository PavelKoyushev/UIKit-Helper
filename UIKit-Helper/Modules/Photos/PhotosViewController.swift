//
//  PhotosViewController.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 11.07.2025.
//

import UIKit

protocol PhotosViewOutputProtocol: AnyObject {
    func displayModel(_ model: PhotosScreenModel)
}

final class PhotosViewController: UIViewController {
    
    var interactor: PhotosInteractorProtocol?
    
    private lazy var trialView = TrialView()
    private lazy var label = UILabel()
    private lazy var tagsView = TagsView()
    private lazy var picturesView = PicturesView()
    
    deinit {
        print("\(Self.self) deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        setupUI()
        
        interactor?.fetchData()
    }
}

extension PhotosViewController: PhotosViewOutputProtocol {
    
    func displayModel(_ model: PhotosScreenModel) {
        trialView.configure(with: model.trial)
        label.text = "Подходит для:"
        tagsView.configure(with: model.tags)
        picturesView.configure(with: model.pictures)
    }
}

private extension PhotosViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "bgColor")
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 1
    }
    
    func makeConstraints() {
        trialView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        tagsView.translatesAutoresizingMaskIntoConstraints = false
        picturesView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trialView)
        view.addSubview(label)
        view.addSubview(tagsView)
        view.addSubview(picturesView)
        
        NSLayoutConstraint.activate([
            trialView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            trialView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trialView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: trialView.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            tagsView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),
            tagsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tagsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tagsView.heightAnchor.constraint(equalToConstant: 16+25)
        ])
        
        NSLayoutConstraint.activate([
            picturesView.topAnchor.constraint(equalTo: tagsView.bottomAnchor, constant: 8),
            picturesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            picturesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            picturesView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
