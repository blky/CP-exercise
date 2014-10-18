import UIKit
protocol ChannelProtocol{
    func channelChanged (channelID:String)
}

class ChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    var channels:NSArray=NSArray()
    var filteredChannels:NSArray = NSArray()
    var delegate:ChannelProtocol?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return filteredChannels.count
        }else {
            return channels.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "channelID")
        if tableView == self.searchDisplayController!.searchResultsTableView {
            let rawData:NSDictionary = filteredChannels[indexPath.row] as NSDictionary
            let channelName:String = rawData["name"] as String
            cell.textLabel?.text = channelName
            return cell
        } else {
            let rawData:NSDictionary = channels[indexPath.row] as NSDictionary
            let channelName:String = rawData["name"] as String
            cell.textLabel?.text = channelName
            return cell
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.reloadData()
     }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var channel:NSDictionary=NSDictionary()
        if tableView == self.searchDisplayController!.searchResultsTableView {
           channel = filteredChannels[indexPath.row]as NSDictionary
        }else {
            channel = channels[indexPath.row] as NSDictionary
        }
        //use anyobject since json types are not string only, when id is 0, it is Int, other became String
        let channelI:AnyObject = channel["channel_id"]!  as AnyObject
        let channelS:String = "channel=\(channelI)" as String
         println("\(channelS)")
        delegate?.channelChanged(channelS)
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    func filterContentForSearchText(searchText:String,scope:String) {
        var resultPredicate = NSPredicate(format: "name contains[cd] %@", searchText)
        filteredChannels = channels.filteredArrayUsingPredicate(resultPredicate)
    }
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString, scope: "ALL")
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchBar.text,scope: "ALL")
        return true
    }
}
