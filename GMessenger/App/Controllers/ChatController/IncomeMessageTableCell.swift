import UIKit

class IncomeMessageTableCell: UITableViewCell {

    @IBOutlet private weak var messageView: UIView?
    @IBOutlet private weak var messageTextLabel: UILabel?
    @IBOutlet private weak var timeLabel: UILabel?
    
    func configure(message: Message, time: String) {
        configureMessageView()
        messageTextLabel?.text = message.text
        timeLabel?.text = time
    }
    
    private func configureMessageView() {
        messageView?.layer.cornerRadius = 17.5
        messageView?.clipsToBounds = true
        self.selectionStyle = .none
    }
    
}
