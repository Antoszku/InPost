//
//  PackView.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

class PackView: UIView {
    
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet private var contentContainer: UIView!
    @IBOutlet private var numberTitleLabel: UILabel!
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var statusTitleLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var senderTitleLabel: UILabel!
    @IBOutlet private var senderLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setup(pack: Pack) {
        numberLabel.text = pack.id
        statusLabel.text = pack.status
        senderLabel.text = pack.sender
    }
    
    private func setupView() {
        loadView()
        setupContainerStyle()
        setupTexts()
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed("PackView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupContainerStyle() {
        // TODO: Look out for shadow performance?
        contentContainer.layer.shadowColor = UIColor.black.cgColor
        contentContainer.layer.shadowRadius = 5
        contentContainer.layer.shadowOffset = .init(width: 0, height: 5)
        contentContainer.layer.shadowOpacity = 0.1
    }
    
    private func setupTexts() {
        numberTitleLabel.text = "NR PRZESYŁKI"
        statusTitleLabel.text = "STATUS"
        senderTitleLabel.text = "NADAWCA"
    }
    
}
