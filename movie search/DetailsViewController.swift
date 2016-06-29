//
//  DetailsViewController.swift
//  movie search
//
//  Created by Gestion Tecnologica on 27/06/16.
//  Copyright © 2016 Carlos Mauricio Idarraga Espitia. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var movie:Seccion!

    @IBOutlet weak var titleMovie: UITextView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var voteMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var generalMovie: UITextView!
    
    
    @IBAction func share_movie(sender: AnyObject) {
        
        let activityViewController = UIActivityViewController(activityItems: ["Hola" as NSString], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
            titleMovie.text = self.movie.nombres[0]
            imageMovie.image = self.movie.imagenes[0]
        
            let x = self.movie.votes[0].doubleValue
            let y = Double(round(10*x)/10)
            print(y)  // 1.236
        
            voteMovie.text = "\(y)"
            dateMovie.text = self.movie.fechas[0]
            generalMovie.text = self.movie.general[0]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
