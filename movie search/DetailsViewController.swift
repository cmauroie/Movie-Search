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
