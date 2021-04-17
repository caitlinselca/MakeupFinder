//
//  FavoriteItemsController.swift
//  MakeupFinds
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//

import UIKit

class FavoriteItemsController: UITableViewController {
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = Item()
        item1.product = "Lipstick:"
        item1.name = "Colourpop Lippie Stix: Parker"
        items.append(item1)
        let item2 = Item()
        item2.product = "Blush:"
        item2.name = "Too Faced Peach Blush"
        items.append(item2)
        let item3 = Item()
        item3.product = "Mascara:"
        item3.name = "Maybelline Spider Mascara"
        items.append(item3)
        let item4 = Item()
        item4.product = "Eyeshadow:"
        item4.name = "Modern Renaissance Palette"
        items.append(item4)
        let item5 = Item()
        item5.product = "Eyeliner:"
        item5.name = "NYX Epic Ink Liner"
        items.append(item5)
        let item6 = Item()
        item6.product = "Foundation:"
        item6.name = "Fenty Beauty"
        items.append(item6)
        let item7 = Item()
        item7.product = "Highlighter:"
        item7.name = "Nicole Guerriero Palette"
        items.append(item7)
    }
    
    // MARK:- Table View Data Source
    override func tableView(_ tableView: UITableView,
          numberOfRowsInSection section: Int) -> Int {
      return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
                 -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
      let item = items[indexPath.row]
      let productLabel = cell.viewWithTag(1000) as! UILabel
      let nameLabel = cell.viewWithTag(2000) as! UILabel
      productLabel.text = item.product
      nameLabel.text = item.name
      return cell
    }
    
    override func tableView(_ tableView: UITableView,
               didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(
                    _ tableView: UITableView,
            commit editingStyle: UITableViewCell.EditingStyle,
             forRowAt indexPath: IndexPath) {
    // 1
      items.remove(at: indexPath.row)
    // 2
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }

}
