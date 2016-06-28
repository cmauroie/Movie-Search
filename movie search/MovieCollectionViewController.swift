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
    
    init(nombres : [String], imagenes : [UIImage]){
        self.nombres = nombres
        self.imagenes = imagenes
    }
}


class MovieCollectionViewController: UICollectionViewController {
    
    
    let keyDev: String = "9c9463d82b0ab409790d6a47c392df5b"
    let urlMovie: String = "http://api.themoviedb.org/3/search/movie"
    let urlImage: String = "http://image.tmdb.org/t/p/w500"
    var urls_img:String = ""
    
    var movie = [Seccion]()
    
    @IBAction func search(sender: UITextField) {
     //   let seccion = Seccion(nombres: sender.text, imagenes: searchInMovie(sender.text!))
        print(searchInMovie(sender.text!))
        
        movie.append(searchInMovie(sender.text!))
        self.collectionView!.reloadData()
    }
    
    func searchInMovie(word : String)-> Seccion{
        var imgs = [UIImage]()
        var names = [String]()
        
        
        let urls = urlMovie+"?api_key="+keyDev+"&query="+word
        let url = NSURL(string: urls)
        let datos = NSData(contentsOfURL: url!)
        
        var data:Seccion = (Seccion(nombres: names, imagenes: imgs))
        
        do{
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
                        imgs.append(imagen)
                        names.append((elemento as! NSDictionary)["original_title"] as! String)
                    }
                }
            }
            
           data = (Seccion(nombres: names , imagenes: imgs))

        }catch{
            
        }
        
        return data
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
        // #warning Incomplete implementation, return the number of sections
        return movie.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movie[section].imagenes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Celda
    
        cell.imagen.image = movie[indexPath.section].imagenes[indexPath.item]
        cell.titleMovie.text = movie[indexPath.section].nombres[indexPath.item]
        
        // Configure the cell
    
        return cell
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
