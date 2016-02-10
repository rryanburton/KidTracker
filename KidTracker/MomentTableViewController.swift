//
//  MomentTableViewController.swift
//  KidTracker
//
//  Created by 3delrb on 2/9/16.
//  Copyright © 2016 Ryan Burton. All rights reserved.
//

import UIKit

class MomentTableViewController: UITableViewController {
    // MARK: Properties
    
    var moments = [Moment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved moments, otherwise load sample data.
//        loadSampleMoments()
        if let savedMoments = loadMoments() {
            moments += savedMoments
        } else {
            // Load the sample data.
            loadSampleMoments()
        }

    }
    
    func loadSampleMoments() {
        let photo1 = UIImage(named: "moment1")!
        let moment1 = Moment(name: "1 Month Old", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "moment2")!
        let moment2 = Moment(name: "First Solid Food", photo: photo2, rating: 5)!
        
        
        let photo3 = UIImage(named: "moment3")!
        let moment3 = Moment(name: "First Haircut", photo: photo3, rating: 3)!
        
        moments += [moment1, moment2, moment3]
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moments.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MomentTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MomentTableViewCell
        
        // Fetches the appropriate moment for the data layout source.
        let moment = moments[indexPath.row]
        

        cell.nameLabel.text = moment.name
        cell.photoImageView.image = moment.photo
        cell.ratingControl.rating = moment.rating
        

        return cell
    }

  
    // Override to support conditional editing of the table view.
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // Return false if you do not want the specified item to be editable.
        return true
    }
   

    
    // Override to support editing the table view.
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            moments.removeAtIndex(indexPath.row)
            saveMoments()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            let momentDetailViewController = segue.destinationViewController as! MomentViewController
            
            // Get the cell that generated this segue.
            if let selectedMomentCell = sender as? MomentTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMomentCell)!
                let selectedMoment = moments[indexPath.row]
                momentDetailViewController.moment = selectedMoment            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new moment.")
        }
    }


    @IBAction func unwindToMomentList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MomentViewController, moment = sourceViewController.moment {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing moment.
                moments[selectedIndexPath.row] = moment
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                
            }
            else {
                // Add a new moment.
                let newIndexPath = NSIndexPath(forRow: moments.count, inSection: 0)
                moments.append(moment)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the moments
            saveMoments()
            
        }
    }

    // MARK: NSCoding
    
    func saveMoments() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(moments, toFile: Moment.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save moments...")
            
        }
    }
    func loadMoments() -> [Moment]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Moment.ArchiveURL.path!) as? [Moment]
        
    }
    
}

