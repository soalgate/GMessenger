import UIKit

class ChatController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var messageField: UITextField!
    
    let stream = StreamController(jid: "yoda@soalgate.ru", password: "(8bS78QGg78*Gj^_")
    
    let repository: Repository = MockRepository()
    var messages: [Message] = []
    
    @IBAction func onSend(_ sender: Any) {
        guard
            let text = messageField.text
        else {
            print("---Text is empty")
            return
        }
        var receiverResult: User?
        
        let resultJid = repository.getUserByJID(jid: "vader@soalgate.ru")
        
        switch resultJid {
        case .success(let result):
            receiverResult = result
        case .failure(let error):
            print(error.localizedDescription)
            return
        }
        
        if receiverResult == nil {
            receiverResult = User(name: "vader@soalgate.ru", jid: "vader@soalgate.ru")
        }
        guard let receiver = receiverResult else {
            return
        }
        
        let senderResult = repository.getCurrentUser()
        
        guard case .success(let senderValue) = senderResult,
        let sender = senderValue else {
            return
        }

        let msg = Message(senderId: sender.id, receiverId: receiver.id, text: text)
        msg.isOutcome = true
        
        stream.sendMessage(message: msg)
        
        messageField.text = ""
        
        NotificationCenter.default.post(name: Notification.Name("New message"), object: nil, userInfo: ["message" : msg])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateChat(_:)), name: Notification.Name(rawValue: "New message"), object: nil)
        
        guard case .success(let value) = repository.getMessages() else {
            return
        }
        messages = value
    }
    
    @objc func updateChat(_ notification: NSNotification) {
        let message = notification.userInfo?["message"] as! Message
        _ = repository.saveMessage(message: message)        
        guard case .success(let newMessages) = repository.getMessages() else {
            return
        }
        messages = newMessages
        tableView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopObservingKeyboard()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureView() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = Style.Color.mainBlueColor
        view.addSubview(statusBarView)
        observeKeyboard()
    }
    
    func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    func keyboardHeightFrom(notification: Notification) -> CGFloat? {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            return keyboardRectangle.height
        }
        return nil
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let height = keyboardHeightFrom(notification: notification) {
            bottomConstraint?.constant = -height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomConstraint?.constant =  0
        view.layoutIfNeeded()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension ChatController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
    
        if message.isOutcome {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OutcomeMessageTableCellId") as? OutcomeMessageTableCell else {
                return UITableViewCell()
            }
            cell.configure(message: message, time: "10:39")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeMessageTableCellId") as? IncomeMessageTableCell else {
                return UITableViewCell()
            }
            cell.configure(message: message, time: "10:40")
            return cell
        }
    }
    
}
