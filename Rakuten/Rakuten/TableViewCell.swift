//
//  TableViewCell.swift
//  Rakuten
//


import UIKit

class TableViewCell: UITableViewCell {
    
    var jsonCell: Itemr?  {
        didSet{
            labrl1.text = jsonCell?.Item.golfCourseName
            let url = jsonCell?.Item.golfCourseImageUrl
            let data = try! Data(contentsOf: url!)
            imageView2.image = UIImage(data: data)
        }
    }
    
    @IBOutlet weak var imageView2: UIImageView!
    
    
    
    @IBOutlet weak var labrl1: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView2.layer.cornerRadius = 25
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    @IBAction func switchAc(_ sender: UISwitch) {
        if sender.isOn {
            backgroundColor = .white
        } else {
            backgroundColor = .yellow
        }
    }
    
    
}
