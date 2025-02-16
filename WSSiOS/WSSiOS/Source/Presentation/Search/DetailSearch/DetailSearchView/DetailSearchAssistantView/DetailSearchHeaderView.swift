//
//  DetailSearchHeaderView.swift
//  WSSiOS
//
//  Created by Seoyeon Choi on 7/19/24.
//

import UIKit

import SnapKit
import Then

enum DetailSearchTab {
    case info, keyword
}

final class DetailSearchHeaderView: UIView {
    
    //MARK: - UI Components
    
    let infoLabel = UILabel()
    let newInfoImageView = UIImageView()
    let keywordLabel = UILabel()
    let newKeywordImageView = UIImageView()
    let underLineView = UIView()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        infoLabel.do {
            $0.applyWSSFont(.title1, with: StringLiterals.DetailSearch.info)
            $0.textColor = .wssPrimary100
        }
        
        keywordLabel.do {
            $0.applyWSSFont(.title1, with: StringLiterals.DetailSearch.keyword)
            $0.textColor = .wssGray200
        }
        
        underLineView.do {
            $0.backgroundColor = .wssPrimary100
        }
        
        [newInfoImageView, newKeywordImageView].forEach {
            $0.image = .icSearchNew.withTintColor(.wssPrimary100)
            $0.isHidden = true
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(infoLabel,
                         newInfoImageView,
                         keywordLabel,
                         newKeywordImageView,
                         underLineView)
    }
    
    private func setLayout() {
        infoLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        newInfoImageView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.top)
            $0.leading.equalTo(infoLabel.snp.trailing).offset(3)
            $0.size.equalTo(4)
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.top)
            $0.leading.equalTo(infoLabel.snp.trailing).offset(29.5)
            $0.trailing.equalToSuperview()
        }
        
        newKeywordImageView.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.top)
            $0.leading.equalTo(keywordLabel.snp.trailing).offset(3)
            $0.size.equalTo(4)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(keywordLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(infoLabel.snp.horizontalEdges)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Custom Method
    
    func updateTab(selected tab: DetailSearchTab) {
        updateTabTextColor(selected: tab)
        updateUnderLineView(selected: tab)
    }
    
    private func updateTabTextColor(selected tab: DetailSearchTab) {
        let isInfoSelected = tab == .info
        
        self.infoLabel.textColor = isInfoSelected ? .wssPrimary100 : .wssGray200
        self.keywordLabel.textColor = isInfoSelected ? .wssGray200 : .wssPrimary100
    }
    
    private func updateUnderLineView(selected tab: DetailSearchTab) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            switch tab {
            case .info:
                self.underLineView.snp.remakeConstraints {
                    $0.top.equalTo(self.infoLabel.snp.bottom).offset(6)
                    $0.horizontalEdges.equalTo(self.infoLabel.snp.horizontalEdges)
                    $0.height.equalTo(2)
                    $0.bottom.equalToSuperview()
                }
            case .keyword:
                self.underLineView.snp.remakeConstraints {
                    $0.top.equalTo(self.keywordLabel.snp.bottom).offset(6)
                    $0.horizontalEdges.equalTo(self.keywordLabel.snp.horizontalEdges)
                    $0.height.equalTo(2)
                    $0.bottom.equalToSuperview()
                }
            }
            self.layoutIfNeeded()
        })
    }
}
