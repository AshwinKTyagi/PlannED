//
//  CalendarViewController.swift
//  
//
//  Created by Ashwin Tyagi on 6/23/20.
//

import UIKit
import FSCalendar
import GoogleMobileAds

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var eventsLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var transparentView: UIView!
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var eventDescriptionLabel: UILabel!
    @IBOutlet var btnEventClose: UIButton!
    @IBOutlet var adContainer: UIView!
    
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeBanner)
        adBannerView.adUnitID = "ca-app-pub-8501671653071605/1974659335"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }()
    
    var selectedDate = Date()
    var dayEvents = [Event]()
    var dayEventNames = [String]()
    
        
    var helper = Helper()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.appearance.weekdayTextColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        transparentView.alpha = 0
        transparentView.isHidden = true
        
        adBannerView.load(GADRequest())
        
        
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        calendar.reloadData()
        tableView.reloadData()
        
        calendar.adjustMonthPosition()
    }
    
    
    //code for when a date on the calendar is selected
    // MARK: calendar: didSelect
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selectedDate = date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let string = formatter.string(from: selectedDate)
        
        eventsLabel.text = "Events: " + string
        
        dayEvents = []
        dayEventNames = []
        
        
        //updates tableView to show the events on the date selected
        if helper.getEventDates().contains(string) {
            for event in helper.getEvents(){
                if event.date == string{
                    dayEvents.append(event)
                    dayEventNames.append(event.name)
                        
                    
                }
            }
        }
        
        tableView.reloadData()
    }
    
    //sets the FSCalenar's frame to be correct in terms of the storyboard
    // MARK: calendar: boundingRectWillChange
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    //displays a dot if a date has an event
    // MARK: calendar: numberOfEventsFor
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let string = formatter.string(from: date)
        
        var count = 0
        for e in helper.getEvents(){
            if e.date == string {
                count += 1
            }
        }
        return count
    }

    //sets the correct number of items in the table view
    // MARK: tableView: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let val = dayEventNames.count
        
        return val
    }
    
    // initializes data for selected date
    // MARK: tableView: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemLbl  =  dayEventNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let frame = tableView.frame
        
        cell.textLabel!.text = itemLbl
        cell.backgroundColor = UIColor.init(red: 75/255, green: 1/255, blue: 100/255, alpha: 1)
        cell.textLabel!.textColor = UIColor.white
        
        let topSeperatorLineView = UIView(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: 0.5))
        topSeperatorLineView.backgroundColor = .white
        
        if indexPath.row != 0 {
            cell.addSubview(topSeperatorLineView)
        }
        
        return cell
    }
    
    //displays information for selected cell
    // MARK: tableView: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for e in helper.getEvents(){
            if e.name == tableView.cellForRow(at: indexPath)?.textLabel!.text{
                eventNameLabel.text = e.name
                eventDateLabel.text = e.date
                
                if e.description.isEmpty {
                    eventDescriptionLabel.text = "No description"
                }
                else {
                    eventDescriptionLabel.text = e.description
                }
            }
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transparentView.isHidden = false
            self.transparentView.alpha = 1.0
        }, completion: nil)
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    //closes the transparent view
    // MARK: onClickEventCloseButton
    @IBAction func onClickEventCloseButton(_ sender: Any?){
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.transparentView.alpha = 0.0
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.transparentView.isHidden = true
        }
    }
    
}
// MARK: EXTENSION:
extension CalendarViewController: GADBannerViewDelegate{
    
    /// Tells the delegate an ad request loaded an ad.
    // MARK: adViewDidReceiveAd
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd - Calendar")
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform
        
        UIView.animate(withDuration: 0.5) {
            self.adContainer.frame = bannerView.frame
            bannerView.transform = CGAffineTransform.identity
            self.adContainer.addSubview(bannerView)
        }
    }

    /// Tells the delegate an ad request failed.
    // MARK:bannerView: didFailToReceiveAdWithError
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response to the user clicking on an ad.
    // MARK: adViewWillPresentScreen
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    // MARK: adViewWillDismissScreen
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    // MARK: adViewDidDismissScreen
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as the App Store), backgrounding the current app.
    // MARK: adViewWillLeaveApplication
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
}
