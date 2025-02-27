//
//  ViewController.swift
//  memo-app
//
//  Created by tlswo on 2/13/25.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private var memoList:[String] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        self.mainView.updateBackgroundView(isEmpty: self.memoList.isEmpty)
        setupNavigationBar()
        setupTableView()
    }
}

private extension MainViewController {
    
    func setupNavigationBar() {
        title = "Memo App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func addItem() {
        let alert = UIAlertController(title: "", message: "새로운 메모를 추가하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self.memoList.append(text)
                self.mainView.tableView.reloadData()
                self.saveData()
                self.mainView.updateBackgroundView(isEmpty: self.memoList.isEmpty)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addTextField()
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadData() {
        if let savedMemoList = UserDefaults.standard.array(forKey: "memoList") as? [String] {
            memoList = savedMemoList
        }
    }
    
    func saveData() {
        UserDefaults.standard.set(memoList, forKey: "memoList")
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = memoList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveData()
            self.mainView.updateBackgroundView(isEmpty: self.memoList.isEmpty)
        }
    }
}
