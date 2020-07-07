//
//  ResultViewController.swift
//  DicodingDrop
//
//  Created by Fikri on 07/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    private let _data: Data
    
    lazy var imageView: UIImageView = {
       let v = UIImageView()
        
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(data: _data)
        
        return v
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    public init(data: Data) {
        _data = data
        
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var btnShare: UIButton = {
       let v = UIButton()
        
        v.setTitle("Share", for: .normal)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(shareButtonDidTap), for: .touchUpInside)
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        view.addSubview(imageView)
        view.addSubview(btnShare)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 500),
            
            btnShare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnShare.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ])
    }
    
    @objc private func shareButtonDidTap() {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        guard let path = documents?.appendingPathComponent("image.png") else {return}
        
        do {
            try _data.write(to: path, options: .atomicWrite)
        } catch {
            print(error.localizedDescription)
        }
        
        let activity = UIActivityViewController(activityItems: ["Coba File Ini", path], applicationActivities: nil)
        
        present(activity, animated: true)
    }
}
