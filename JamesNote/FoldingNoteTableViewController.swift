//
//  FoldingNoteTableViewController.swift
//  JamesNote
//
//  Created by James on 2/13/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class FoldingNoteTableViewController: UITableViewController {

  // @IBInspectable open var itemCount: NSInteger = 3
   
    let noteStore = NoteStore.shared()
    
    // folding cell --  https://github.com/Ramotion/folding-cell
    let closeCellHeight: CGFloat = 200
    let openCellHeight: CGFloat = 400
    var cellHeights = [CGFloat]()
    
    // var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //      var theNoteStore = NoteStore.shared()
        
        //        var n1 = Note()
        //        n1.image = UIImage(named: "back.png")!
        //        n1.title  = "dwdqwdd"
        //        n1.text = "wdwww"
        //
        //        noteStore.createNote(n1)
        //        noteStore.save()
        
        createCellHeightsArray()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // createCellHeightsArray()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noteStore.count()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingNoteCell", for: indexPath) as! NoteTableViewCell
        
        // Configure the cell...
        let rowNumber = indexPath.row
        let note =  noteStore.getNote(rowNumber)
        
        cell.setupCell(note)
        
        return cell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let noteDetail = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            noteDetail.note = noteStore.getNote(indexPath.row)
            
        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            // Delete the row from the data source
            // notes.removeAtIndex(indexPath.row)
            noteStore.delete(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    // unwind segue
    @IBAction func saveNote(_ segue: UIStoryboardSegue)
    {
        if let indexPath = tableView.indexPathForSelectedRow  {
            
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            
        } else
        {
            let noteDetail = segue.source as! DetailViewController
            //  notes.append(noteDetail.note)
            noteStore.createNote(noteDetail.note)
            
            let lastRow = IndexPath(item: noteStore.count() - 1, section: 0)
            
            tableView.insertRows(at: [lastRow], with: UITableViewRowAnimation.automatic)
        }
    }

    
    // MARK: configure
    func createCellHeightsArray() {
        
        cellHeights.removeAll()
        
        // stop loop below from crashing
        if noteStore.count() == 0 { return }
        
        // 0...0 -> 0...N-1
        let count = noteStore.count()-1
        for _ in 0...count {
            cellHeights.append(closeCellHeight)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if cellHeights.count == 0
        {
            return closeCellHeight
        }
        return cellHeights[indexPath.row]
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
        print("indexPath.row = \(indexPath.row)")
        
        if cellHeights.count == 0 { return }
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == closeCellHeight { // open cell
            cellHeights[indexPath.row] = openCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else { // close cell
            cellHeights[indexPath.row] = closeCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as NoteTableViewCell = cell else {
            return
        }
        //resetCellColors(cell)
        
        // force unwrap later
        if noteStore.count() == 0
        {
            print("Error reading data")
            return
        }
        
        if cellHeights.count > 0
        {
            if cellHeights[indexPath.row] == closeCellHeight {
                cell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                cell.selectedAnimation(true, animated: false, completion: nil)
            }
        }

    }
 
    /***
 
     override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
     
     guard case let cell as WeatherCell = cell else {
     return
     }
     resetCellColors(cell)
     
     cell.sunriseLabel.hidden = true
     cell.sunsetlabel.hidden = true
     cell.sunriseImage.hidden = true
     cell.sunsetImage.hidden = true
     cell.windDirectionImage.hidden = true
     
     // force unwrap later
     if forecast.count == 0
     {
     print("Error reading data")
     return
     }
     
     var weather = Weather()
     weather = forecast[indexPath.row]
     
     // clear the icon first
     cell.iconImage.image = nil
     
     if let iconString = weather.icon
     {
     let image = WeatherHelper.imageFromIconString(iconString)
     
     if image != nil
     {
     cell.iconImage.image = image
     }
     }
     
     if weather.date != 0
     {
     cell.dateLabel.text = dayStringFromTime(weather.date)
     cell.timeLabel.text = timeStringFromUnixTime(weather.date)
     }
     
     if weather.sunrise != 0
     {
     cell.sunriseImage.hidden = false
     cell.sunriseLabel.hidden = false
     cell.sunriseLabel.text = timeStringFromUnixTime(weather.sunrise)
     }
     
     if weather.sunset != 0
     {
     cell.sunsetImage.hidden = false
     cell.sunsetlabel.hidden = false
     cell.sunsetlabel.text = timeStringFromUnixTime(weather.sunset)
     }
     
     var isBeyondThreshold = false
     // compare wind speed, temp, precip, visibility, cloud cover and set color
     
     if let maxSpeed = settings.getMaxWindSpeed() // else nil stays grey
     {
     if let windSpeed = weather.windSpeed
     {
     if windSpeed > maxSpeed { cell.cellSquareView.backgroundColor = UIColor.redColor();isBeyondThreshold = true  }
     else { cell.cellSquareView.backgroundColor = UIColor.greenColor() }
     }
     }
     
     if let minTemp = settings.getMinTemperature() // else nil stays grey
     {
     if let temperature = weather.temperature
     {
     if temperature < minTemp { cell.tempSquareView.backgroundColor = UIColor.redColor(); isBeyondThreshold = true  }
     else { cell.tempSquareView.backgroundColor = UIColor.greenColor() }
     }
     }
     
     if let maxPrecip = settings.getMaxPrecip()
     {
     if let precipProbability = weather.precipProbability
     {
     if precipProbability * 100 > maxPrecip { cell.precipProbSquareView.backgroundColor = UIColor.redColor(); isBeyondThreshold = true }
     else { cell.precipProbSquareView.backgroundColor = UIColor.greenColor() }
     }
     }
     
     if let maxCloud = settings.getMaxCloudCover()
     {
     if let cloudCover = weather.cloudCover
     {
     if cloudCover * 100 > maxCloud { cell.cloudCoverSquareView.backgroundColor = UIColor.redColor(); isBeyondThreshold = true}
     else { cell.cloudCoverSquareView.backgroundColor = UIColor.greenColor() }
     }
     }
     
     if let minVisibility = settings.getMinVisibility()
     {
     if let visibility = weather.visibility
     {
     if visibility < minVisibility { cell.visibilitySquareView.backgroundColor = UIColor.redColor(); isBeyondThreshold = true }
     else { cell.visibilitySquareView.backgroundColor = UIColor.greenColor() }
     }
     }
     
     // OK show fly or no go here -- if anything set isBeyondThreshold true do not fly
     // if nothing being compared let the user know that too
     if settings.isNoThresholdsSet() == true
     {
     displayNoThresholdsSet(cell)
     }
     else if isBeyondThreshold == true
     {
     displayNoFly(cell)
     }
     else
     {
     displayFly(cell)
     }
     
     let selectedUnits = settings.getUnit()
     var selectedTempUnits = unitsUS.temperature.rawValue
     var selectedVisibilityUnits = unitsUS.visibility.rawValue
     var selectedWindSpeedUnits = unitsUS.windSpeed.rawValue
     
     if selectedUnits == units.si.rawValue
     {
     selectedTempUnits = unitsSI.temperature.rawValue
     selectedVisibilityUnits = unitsSI.visibility.rawValue
     selectedWindSpeedUnits = unitsSI.windSpeed.rawValue
     }
     
     // setup text for labels
     if let temperature = weather.temperature
     {
     cell.temperatureLabel.text = "\(temperature.roundToPlaces(2))" + " \(selectedTempUnits)"
     }
     else { cell.temperatureLabel.text = "" }
     
     if let windSpeed = weather.windSpeed
     {
     cell.windSpeedLabel.text = "\(windSpeed.roundToPlaces(2))" + " \(selectedWindSpeedUnits)"
     }
     else { cell.windSpeedLabel.text = "" }
     
     if let visibility = weather.visibility
     {
     cell.visibilityLabel.text = "\(visibility.roundToPlaces(2))" + " \(selectedVisibilityUnits)"
     }
     else { cell.visibilityLabel.text = "" }
     
     if let precipProb = weather.precipProbability
     {
     cell.precipProbabilityLabel.text = "\(Int(precipProb * 100))" + " %"
     }
     else { cell.precipProbabilityLabel.text = "" }
     
     if let cloudCover = weather.cloudCover
     {
     cell.cloudCoverLabel.text = "\(Int(cloudCover * 100))" + " %"
     }
     else { cell.cloudCoverLabel.text = "" }
     
     if let windDirection = weather.windBearing
     {
     if let theImage = WeatherHelper.getImageForWindDirection(windDirection)
     {
     cell.windDirectionImage.image = theImage
     cell.windDirectionImage.hidden = false
     }
     cell.windDirectionLabel.text = WeatherHelper.cardinalDirectionFromDegrees(windDirection)
     }
     else { cell.windDirectionLabel.text = "" }
     
     if cellHeights.count > 0
     {
     if cellHeights[indexPath.row] == closeCellHeight {
     cell.selectedAnimation(false, animated: false, completion:nil)
     } else {
     cell.selectedAnimation(true, animated: false, completion: nil)
     }
     }
     
     // what does this do it's causing a crash ?????????
     // cell.number = indexPath.row
     }
 
 ***/
    
    
}
