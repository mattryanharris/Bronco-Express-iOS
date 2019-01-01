import UIKit

class StopTableController: UITableViewController {
    var route: Route! {
        didSet {
            navigationItem.title = route.routeName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return route.stop.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let stop = self.route.stop[indexPath.row].stopName

        cell.textLabel?.text = stop
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FinalSegue" {
            guard let cell = sender as? UITableViewCell else { return }
            
            var i = 0
            
            currentStop = (cell.textLabel?.text)!
            while currentStop != route.stop[i].stopName {
                i += 1
            }
            currentStopID = route.stop[i].stopID
        }
    }
}
