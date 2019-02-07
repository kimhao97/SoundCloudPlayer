
import UIKit

extension UITableView {

  // MARK: - Cells

  func register<T: UITableViewCell>(_ cell: T.Type) where T: NibReusable {
    self.register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
  }

  func register<T: UITableViewCell>(_ cell: T.Type) where T: Reusable {
    self.register(cell.self, forCellReuseIdentifier: cell.reuseIdentifier)
  }

  func dequeue<T: UITableViewCell>(_ indexPath: IndexPath) -> T where T: Reusable {
    return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }

  // MARK: - Headers/Footers

  func register<T: UITableViewHeaderFooterView>(headerFooter: T.Type) where T: NibReusable {
    self.register(headerFooter.nib, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
  }

  func register<T: UITableViewHeaderFooterView>(headerFooter: T.Type) where T: Reusable {
    self.register(headerFooter.self, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
  }

  func dequeue<T: UITableViewHeaderFooterView>() -> T? where T: Reusable {
    return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
  }

}
