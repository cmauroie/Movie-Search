//
//  MovieCollectionViewController.swift
//  movie search
//
//  Created by Gestion Tecnologica on 24/06/16.
//  Copyright © 2016 Carlos Mauricio Idarraga Espitia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

struct Seccion {
    var nombres : [String]
    var imagenes : [UIImage]
    var votes : [NSNumber]
    var fechas : [String]
    var general: [String]
    var id : [NSNumber]
    
    init(nombres : [String], imagenes : [UIImage], votes : [NSNumber], fechas : [String], general: [String], id: [NSNumber]){
        self.nombres = nombres
        self.imagenes = imagenes
        self.votes = votes
        self.fechas = fechas
        self.general = general
        self.id = id
        
    }
}


class MovieCollectionViewController: UICollectionViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchOut: UITextField!
    
    let keyDev: String = "9c9463d82b0ab409790d6a47c392df5b"
    let urlMovie: String = "http://api.themoviedb.org/3/search/movie"
    let urlImage: String = "http://image.tmdb.org/t/p/w300"
    var urls_img:String = ""
    
    var language:String = "es"
    
    
    var movies = [Seccion]()
    var totalItem = 0
    var page = 1
    var work: String = ""
    
    @IBAction func search(sender: UITextField) {
     //   let seccion = Seccion(nombres: sender.text, imagenes: searchInMovie(sender.text!))
        //print(searchInMovie(sender.text!))
        
        sender.resignFirstResponder()
        
        work = sender.text!
        if work != ""{
            movies.removeAll()
            dataSearch(work)
        }
        
        
        
            }
    
    func dataSearch(data: String){
        
        dispatch_async(dispatch_get_main_queue(),{
            self.movies.append(self.searchInMovie(data))
            self.collectionView!.reloadData()
        });
    }
    
    func searchInMovie(word : String)-> Seccion{
        var imgs_s = [UIImage]()
        var names_s = [String]()
        var votes_s = [NSNumber]()
        var fechas_s = [String]()
        var general_s = [String]()
        var id_s = [NSNumber]()
        
        
        let urls = urlMovie+"?api_key="+keyDev+"&query="+word+"&language="+language+"&page=\(page)"
        let url = NSURL(string: urls)
        let datos = NSData(contentsOfURL: url!)
        
        var data:Seccion = (Seccion(nombres: names_s,
            imagenes: imgs_s,
            votes: votes_s,
            fechas: fechas_s,
            general: general_s,
            id: id_s))
        
        do{
            print("\(datos)")
            if datos != nil{
            
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
            
           
            print("response data: \(json)")
            
            let resultado = (json["results"] as! NSArray)
            
            for elemento in resultado{
                

                if let imageURL = (elemento as! NSDictionary)["poster_path"] as? String {
                    self.urls_img = imageURL
                    
                    
                    let url_img = urlImage + urls_img + "?api_key="+keyDev
                    let urlImg = NSURL(string:url_img);
                    let img_data = NSData(contentsOfURL: urlImg!)
                    
                    if let imagen = UIImage(data: img_data!){
                        imgs_s.append(imagen)
                        names_s.append((elemento as! NSDictionary)["original_title"] as! String)
                        votes_s.append((elemento as! NSDictionary)["vote_average"] as! NSNumber)
                        fechas_s.append((elemento as! NSDictionary)["release_date"] as! String)
                        general_s.append((elemento as! NSDictionary)["overview"] as! String)
                        id_s.append((elemento as! NSDictionary)["id"] as! NSNumber)
                    }
                }
            }
            
           data = (Seccion(nombres: names_s,
            imagenes: imgs_s,
            votes: votes_s,
            fechas: fechas_s,
            general: general_s,
            id: id_s))
            } else {
                
                    self.setInfo()
            }
        }catch{
            
        }
        
        return data
    }
    
    func setInfo(){
        
        print("alert")
            let alertController = UIAlertController(title: "Atención", message:
                "Por favor verifica tu conexión a internet", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        searchOut.delegate=self
        
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField){
        sender.resignFirstResponder()// Hide keyboard
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, retursn the number of sections
       
        return movies.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
         totalItem = movies[section].imagenes.count - 2
        return movies[section].imagenes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Celda
    
        cell.imagen.image = movies[indexPath.section].imagenes[indexPath.item]
        cell.titleMovie.text = movies[indexPath.section].nombres[indexPath.item]
        
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        print("number: \(indexPath.row) \(totalItem) \(movies.count)")
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (sender is UICollectionViewCell) {
            
                        let cell = sender as! UICollectionViewCell
            if let indexPaths = collectionView?.indexPathForCell(cell){
                
                print("data: " + self.movies[indexPaths.section].nombres[indexPaths.row])
            (segue.destinationViewController as! DetailsViewController).movie = self.movies[indexPaths.section]
                
                (segue.destinationViewController as! DetailsViewController).movie.nombres[0] = self.movies[indexPaths.section].nombres[indexPaths.row]
                
                (segue.destinationViewController as! DetailsViewController).movie.imagenes[0] = self.movies[indexPaths.section].imagenes[indexPaths.row]
                
                (segue.destinationViewController as! DetailsViewController).movie.votes[0] = self.movies[indexPaths.section].votes[indexPaths.row]
                
                (segue.destinationViewController as! DetailsViewController).movie.fechas[0] = self.movies[indexPaths.section].fechas[indexPaths.row]
                
                (segue.destinationViewController as! DetailsViewController).movie.general[0] = self.movies[indexPaths.section].general[indexPaths.row]
                
                (segue.destinationViewController as! DetailsViewController).movie.id[0] = self.movies[indexPaths.section].id[indexPaths.row]
                
                
                
                
            }
        }
    }
    
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        
        page += 1
        print("loadData")
        if page < 1000{
            
                self.dataSearch(self.work)
            
        }
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging");
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging");
    }
    
    
    
    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation");
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
