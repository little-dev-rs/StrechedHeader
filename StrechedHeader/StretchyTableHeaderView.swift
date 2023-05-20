//
//  StretchingHeader.swift
//  StrechedHeader
//

import UIKit

final class StretchyTableHeaderView: UIView {
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var imageViewHeightConstraint = NSLayoutConstraint()
    private var imageViewBottomConstraint = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeightConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    private func initialSetup() {
        addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeightConstraint.isActive = true
        
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottomConstraint.isActive = true
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeightConstraint.isActive = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeightConstraint.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottomConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeightConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
        
        
        scrollView.verticalScrollIndicatorInsets.top = imageView.bounds.height // ??
    }
    
}
