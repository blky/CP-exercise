import UIKit
import MediaPlayer

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, HttpProtocol ,ChannelProtocol {

    @IBOutlet weak var ivAlbume: UIImageView!
    @IBOutlet weak var labelTimeLeft: UILabel!
    @IBOutlet weak var buttonIcon: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var viewDisplay: UIView!
    @IBOutlet weak var iv_Play: UIImageView!
    @IBOutlet var onTap: UITapGestureRecognizer! = nil
    @IBOutlet weak var progressBar: UIProgressView!
    
    var eHttp:HttpController = HttpController()
    var tableData:NSArray = NSArray()
    var channelData:NSArray = NSArray()
    var imageCache = Dictionary<String,UIImage>()
    var audioPlayer:MPMoviePlayerController = MPMoviePlayerController()
    var timer:NSTimer?
    var currentPlayID:Int=0
    
    @IBAction func onTapGesture(sender: UITapGestureRecognizer) {
        if sender.view == ivAlbume {
            iv_Play.hidden = false
            self.audioPlayer.pause()
            ivAlbume.removeGestureRecognizer(onTap)
            iv_Play.addGestureRecognizer(onTap)
        } else if sender.view == iv_Play {
            iv_Play.hidden = true
            self.audioPlayer.play()
            iv_Play.removeGestureRecognizer(onTap)
            ivAlbume.addGestureRecognizer(onTap)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        eHttp.delegate = self
        eHttp.onSearch("http://www.douban.com/j/app/radio/channels")
        eHttp.onSearch("http://douban.fm/j/mine/playlist?channel=1")
        
        ivAlbume.addGestureRecognizer(onTap)
        self.audioPlayer.shouldAutoplay = true
     }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tableData.count
    } 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "toChannel")
        let rowData = tableData[indexPath.row] as NSDictionary
        cell.textLabel?.text = rowData["title"] as? String
        cell.detailTextLabel?.text=rowData["artist"] as? String
        cell.imageView?.image = UIImage(named: "detail.jpg")
        let url = rowData["picture"] as String
        if let image = imageCache[url]  {
            cell.imageView?.image = image
        } else {
            let imageURL:NSURL = NSURL(string: url)
            let request = NSURLRequest(URL: imageURL)
            NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse!, data: NSData!, err:NSError! ) -> Void in
            let img = UIImage(data: data)
            self.imageCache[url] = img
            cell.imageView?.image = img
            })
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imageURL = tableData[indexPath.row] ["picture"] as String
        let url = tableData[indexPath.row]["url"] as String
        onSetAudio(url)
        onSetImage(imageURL)
        currentPlayID=indexPath.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let channelVC:ChannelViewController = segue.destinationViewController as ChannelViewController
        //println (channelData)
        channelVC.channels = channelData
        channelVC.delegate = self
    }
    func channelChanged (channelID:String){
        let newChannel:String = channelID
        let urlString:String = "http://douban.fm/j/mine/playlist?\(channelID)"
        eHttp.onSearch(urlString)
    }
    func didReceiveResults(result:NSDictionary){
        //println("\(result)")
        if result["song"] != nil {
            tableData = result["song"] as NSArray
            myTableView.reloadData()
            //after tableview reload, play the first one on the list
            let firstItem :NSDictionary = tableData [0] as NSDictionary
            let firstMP3 :String = firstItem["url"] as String
            let pictureURL:String = firstItem ["picture"] as String
            onSetAudio(firstMP3)
            onSetImage(pictureURL)
        }else if result["channels"] != nil {
            channelData = result["channels"] as NSArray
        } else {
            println ("network error")
        }
        myTableView.reloadData()
    }
    func onSetAudio (url:String) {
        self.audioPlayer.stop()
        self.labelTimeLeft.text="00:00"
        iv_Play.hidden = true
        iv_Play.removeGestureRecognizer(onTap)
        ivAlbume.addGestureRecognizer(onTap)
        audioPlayer.contentURL = NSURL(string: url)
        audioPlayer.play()
        timer=NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "onUpdate", userInfo: nil, repeats: true)
     }
    func onSetImage (url:String) {
        if let image = imageCache [url] {
            self.ivAlbume.image = image
        }else {
            let imageURL:NSURL = NSURL(string: url)
            let request = NSURLRequest(URL: imageURL)
            NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse!, data: NSData!, err:NSError! ) -> Void in
            let img = UIImage(data: data)
            self.imageCache[url] = img
            self.ivAlbume.image = img
            })
        }
    }
    func onUpdate(){
        let c=audioPlayer.currentPlaybackTime
        if c>0.0 {
            let t=audioPlayer.duration
            let p:CFloat=CFloat(c/t)
            progressBar.setProgress(p, animated: true)
            let all:Int=Int(c)
            let m:Int=all % 60
            let f:Int=Int(all/60)
            var time:String=""
            if f<10{
                time="0\(f):"
            }else {
                time="\(f)"
            }
            if m<10{
                time+="0\(m)"
            }else {
                time+="\(m)"
            }
            self.labelTimeLeft.text=time
        }
    
    }
}
