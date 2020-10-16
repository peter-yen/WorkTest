import UIKit
import SnapKit
import PowerMode
import Toast_Swift

class AuthViewController: UIViewController {
    
    private lazy var emailTextField: PowerModeTextField = {
        let tf = PowerModeTextField()
        tf.backgroundColor = .systemGray3
        tf.pmTextFieldDelegate = self
        tf.text = "cccccc"
        tf.borderStyle = .roundedRect
        tf.placeholder = "電話號碼、用戶名稱或電子郵件"
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private lazy var passwordTextField: PowerModeTextField = {
        let tf = PowerModeTextField()
        tf.pmTextFieldDelegate = self
        tf.backgroundColor = .systemGray3
        tf.text = "123456"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.placeholder = "密碼"
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .systemBlue
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 20
        bt.setTitle("登入", for: .normal)
        bt.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return bt
    }()
    
    private lazy var registerButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("註冊", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.setupSubviews()
    }
    
    private func setupSubviews() {
        
        view.addSubview(emailTextField)
        self.emailTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(100)
        }
        
        view.addSubview(passwordTextField)
        self.passwordTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
        }
        
        view.addSubview(loginButton)
        self.loginButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
        }
        
        view.addSubview(registerButton)
        self.registerButton.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.top.equalTo(loginButton.snp.bottom).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
        }
        
    }
    
    @objc private func loginButtonDidTap() {
        guard let nametext = emailTextField.text else { return }
        guard let passwordtext = passwordTextField.text else { return }
        API.shared.postUser(user: User(name: nametext, password: passwordtext), success: {
            
            API.shared.getStockInfo(success: { codes in
                
                DispatchQueue.main.async {
                    let testTableVC = TestViewController(codes: codes)
                    self.present(testTableVC, animated: true, completion: nil)
                }
                
            }, failure: { err in
                self.view.showToast(text: err.localizedDescription)
            })
            
        }, failure: { err in
            self.view.showToast(text: err.localizedDescription)
        })
    }
}

extension AuthViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

