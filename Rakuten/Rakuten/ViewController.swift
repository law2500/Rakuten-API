//
//  ViewController.swift
//  Rakuten
//



struct Rakutenn: Codable {
    let carrier: Int
    let count: Int
    let first: Int
    let hits: Int
    let last: Int
    let page: Int
    let pageCount: Int
    let Items: [Itemr]
}

struct Itemr: Codable {
    let Item: Itemss
}

struct Itemss: Codable {
    let golfCourseId: Int
    let golfCourseName: String
    let golfCourseAbbr: String
    let golfCourseNameKana: String
    let golfCourseCaption: String
    let address: String
    let highway: String
    let latitude: Double
    let longitude: Double
    let golfCourseDetailUrl: URL
    let reserveCalUrl: URL
    let ratingUrl: URL
    let golfCourseImageUrl: URL
    
}

import UIKit

class ViewController: UIViewController {
    
    var jsonView1: Itemr?
    
    private let cellId = "cellId"
   
    var gg = [Itemr]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        urlRakutenn()
        
    }
    
    
    private func urlRakutenn() {
        
        //  API IDをまず習得する！
        
        guard let url = URL(string: "https://app.rakuten.co.jp/services/api/Gora/GoraGolfCourseSearch/20170623?format=json&keyword=%E5%AE%AE%E5%9F%8E&page=1&hits=30&applicationId=(ここにID入れてください)") else { return  }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed)
                
                print(json)
                
                let jsons = try! JSONDecoder().decode(Rakutenn.self, from: data)
                
                print(jsons)
                
                DispatchQueue.main.async {
                    self.gg = jsons.Items
                    
                    
                    self.tableView.reloadData()
                }
                
            }
        }
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as? ViewController2
        nextView?.jsonView = jsonView1
    }

    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        cell.jsonCell = gg[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        jsonView1 = gg[indexPath.row]
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
}
