//
//  ListController.swift
//  MakeupFinds
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//

import UIKit

class ListController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:
          TableView.CellIdentifiers.nothingFoundCell)
        let segmentColor = UIColor(red: 220/255, green: 80/255, blue: 140/255, alpha: 1)
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: segmentColor]
        segmentedControl.selectedSegmentTintColor = segmentColor
        segmentedControl.setTitleTextAttributes(normalTextAttributes,
        for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes,
        for: .selected)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes,
        for: .highlighted)
    }
    
    var searchResults = [MakeupElement]()
    var hasSearched = false

    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var dataTask: URLSessionDataTask?
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        performSearch()
    }
    
    struct TableView {
      struct CellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
      }
    }
   
    func makeupURL(searchText: String, category: Int) -> URL {
    let productType: String
      switch category {
        case 1: productType = "lipstick"
        case 2: productType = "blush"
        case 3: productType = "mascara"
        case 4: productType = "eyeshadow"
        case 5: productType = "eyeliner"
        default: productType = ""
      }
      let encodedText = searchText.addingPercentEncoding(
          withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = "https://makeup-api.herokuapp.com/api/v1/products.json?" + "brand=\(encodedText)&product_type=\(productType)"
      let url = URL(string: urlString)
        return url!
    }
    
    func parse(data: Data) -> [MakeupElement] {
      do {
        let decoder = JSONDecoder()
        let result = try decoder.decode([MakeupElement].self, from:data)
        return result
      } catch {
        print("JSON Error: \(error)")
    return [] }
    }
    
    func showNetworkError() {
      let alert = UIAlertController(title: "Whoops...",
        message: "There was an error accessing the Makeup Store." +
        " Please try again.", preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .default,
                             handler: nil)
    present(alert, animated: true, completion: nil)
      alert.addAction(action)
    }
}

extension ListController: UISearchBarDelegate {
    func performSearch() {
      if !searchBar.text!.isEmpty {
          searchBar.resignFirstResponder()
          hasSearched = true
          searchResults = []
          // 1
        
        let url = makeupURL(searchText: searchBar.text!, category: segmentedControl.selectedSegmentIndex)
        
          let session = URLSession.shared
        
          dataTask = session.dataTask(with: url,
                completionHandler: { data, response, error in
                if let error = error as NSError?, error.code == -999 {
                  return
                } else if let httpResponse = response as? HTTPURLResponse,
                              httpResponse.statusCode == 200 {
                  if let data = data {
                     self.searchResults = self.parse(data: data)
                      self.searchResults.sort(by: <)
                      DispatchQueue.main.async {
                        self.tableView.reloadData()
                      }
                    return
                    }
                } else {
                  print("Failure! \(response!)")
                }
                DispatchQueue.main.async {
                  self.hasSearched = false
                  self.tableView.reloadData()
                  self.showNetworkError()
                }
          })

              dataTask?.resume()
            }
          }
        
     func position(for bar: UIBarPositioning) -> UIBarPosition {
      return .topAttached
    }
    
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      performSearch()
    }
    
}

extension ListController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
          return 0
        } else if searchResults.count == 0 {
          return 1
      } else {
          return searchResults.count
        }
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:
                 TableView.CellIdentifiers.searchResultCell, for: indexPath)
                 as! SearchResultCell
      if searchResults.count == 0 {
        return tableView.dequeueReusableCell(withIdentifier:
        TableView.CellIdentifiers.nothingFoundCell,
        for: indexPath)
      } else {
        let searchResult = searchResults[indexPath.row]
        cell.configure(for: searchResult)
        return cell
    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,
                             sender: Any?) {
     if segue.identifier == "ShowDetail" {
       let detailViewController = segue.destination
                                  as! DetailViewController
       let indexPath = sender as! IndexPath
       let searchResult = searchResults[indexPath.row]
       detailViewController.searchResult = searchResult
     }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      if searchResults.count == 0 {
        return nil
    } else {
        return indexPath
      }
    }
}
