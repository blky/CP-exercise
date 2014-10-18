import UIKit
protocol HttpProtocol{
    func didReceiveResults(result:NSDictionary)
    
}
class HttpController: NSObject {
   
    var delegate:HttpProtocol?
    
    func onSearch (url:String) {
        var nsURL :NSURL = NSURL(string: url)
        var request :NSURLRequest = NSURLRequest(URL: nsURL)
        NSURLConnection.sendAsynchronousRequest(request, queue:
            NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data:NSData!, err:NSError!) -> Void in
                if err == nil {
                    var jsonResult:NSDictionary = NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    self.delegate?.didReceiveResults(jsonResult)

                }
        }
    }
}
