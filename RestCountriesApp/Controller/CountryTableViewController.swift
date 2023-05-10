

import UIKit

class CountryTableViewController: UITableViewController {
    
    private let cellID = "cell"
    private let url = "https://restcountries.com/v3.1/all"
    private var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NetworkManager.fetchData(url: url) { countries in
            self.countries = countries
            dump(self.countries)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        let barButtonItem = UIBarButtonItem(title: "?", style: .plain, target: self, action: #selector(myCustomData))
        navigationItem.rightBarButtonItem = barButtonItem
      
    }
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        
#warning("nav bar item")
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender: )))
        view.addGestureRecognizer(longPressRecognizer)
    }
    
    
    @objc private func longPressed(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint){
                basicActionSheet(title: countries[indexPath.row].region, message: countries[indexPath.row].subregion)
            }
        }
    }
    
    private func setupNavigationBar() {
        title = "Country List"
        let titleImage = UIImage(systemName: "mappin.and.ellipse")
        let imageView = UIImageView(image: titleImage)
        self.navigationItem.titleView = imageView
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        
    }
    @objc private func myCustomData() {
        navigationItem.rightBarButtonItem?.title = "My Travel List"
    }
   
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name.common
        cell.detailTextLabel?.text = country.name.official
        
        return cell
    }
}

extension CountryTableViewController {
    
    private func basicActionSheet(title: String?, message: String?) {
        DispatchQueue.main.async {
            let actionSheet: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.overrideUserInterfaceStyle = .dark
            actionSheet.view.backgroundColor = UIColor.cyan
            
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true)
        }
    }
    
#warning("basicAlertSheet")
    
}
