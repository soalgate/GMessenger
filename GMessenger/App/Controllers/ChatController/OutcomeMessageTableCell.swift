import UIKit

class OutcomeMessageTableCell: UITableViewCell {
    
    @IBOutlet private weak var messageView: UIView?
    @IBOutlet private weak var messageTextLabel: UILabel?
    @IBOutlet private weak var timeLabel: UILabel?
    
    func configure(message: String, time: String) {
        configureMessageView()
        messageTextLabel?.text = message
        timeLabel?.text = time
    }
    
    private func configureMessageView() {
        messageView?.layer.borderWidth = 1
        messageView?.layer.borderColor = UIColor.mainBlue.cgColor
        messageView?.layer.cornerRadius = 17.5
        messageView?.clipsToBounds = true
        self.selectionStyle = .none
    }
    
}
