    import UIKit
    
    class AirlineItemCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        var airline: Airline? {
            didSet {
                airlineNameLabel.text = airline?.defaultName
                airlinePhoneLabel.text = airline?.phone
                setupThumnailImage()
            }
        }
        
        func setupThumnailImage() {
            if let thumnailUrl = airline?.logoURL {
                airlineThumnailView.loadImageUsingUrlString(urlString: thumnailUrl)
            }
        }
        
        let airlineThumnailView: CustomImageView = {
            let view = CustomImageView()
            view.image = view.image?.withRenderingMode(.alwaysTemplate)
            view.contentMode = .scaleAspectFill
            view.clipsToBounds = true
            view.layer.cornerRadius = 30
            view.layer.masksToBounds = true
            return view
        }()
        
        let airlineNameLabel: UILabel = {
            let label = UILabel()
            label.text = "Avianca Argentina"
            label.font=UIFont.systemFont(ofSize: 20)
            return label
        }()
        
        let airlinePhoneLabel: UILabel = {
            let label = UILabel()
            label.text = "0810-333-8222"
            label.textColor = UIColor.lightGray
            return label
        }()
        
        let likeButton: UIButton = {
            let button = UIButton()
            button.setBackgroundImage(UIImage(named:"heart-full.pdf"), for: .normal)
            button.isUserInteractionEnabled = true
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            return button
        }()
        
        @objc func buttonClick() {
            print("Button Clicked")
        }
        
        
        func setupViews() {

            addSubview(airlineThumnailView)
            addSubview(airlineNameLabel)
            addSubview(airlinePhoneLabel)
            
            AutolayoutProxy.layout(airlineThumnailView)
                .centerVerticallyInParentView()
                .leadingSpaceToSuperview(20)
                .width(60)
                .height(60)
            AutolayoutProxy.layout(airlineNameLabel)
                .leadingSpaceToSuperview(100)
                .trailingSpaceToSuperview(100)
                .topSpaceToSuperview(20)
                .height(30)
            AutolayoutProxy.layout(airlinePhoneLabel)
                .bottomSpaceToSuperview(-20)
                .leadingSpaceToSuperview(100)
                .trailingSpaceToSuperview(100)
                .height(30)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
