//
//  SearchBarViewController.swift
//  Mapas&Ubicacion8-9
//
//  Created by marco alonso on 29/10/20.
//

import UIKit
import MapKit

class SearchBarViewController: UIViewController {

    @IBOutlet weak var Buscador: UISearchBar!
    @IBOutlet weak var Mapa: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Buscador.delegate = self

    }

}


extension SearchBarViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        Buscador.resignFirstResponder()  //ocultar teclado
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(Buscador.text!) { (places: [CLPlacemark]?, error: Error?) in
            
            if error == nil {
                //muestre la direccion o la anotacion
                let place = places?.first
                
                print("Places : \(places!)")
                
                
                let anotacion = MKPointAnnotation()
                anotacion.coordinate = (place?.location?.coordinate)!
                anotacion.title = self.Buscador.text
                
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)  //Vista del mapa que tan cerca o lejos se mira
                
                let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                
                self.Mapa.setRegion(region, animated: true)
                self.Mapa.addAnnotation(anotacion)
                self.Mapa.selectAnnotation(anotacion, animated: true)
                

                
            } else {
                
                print("Ubicacion no localizada")
                
            }
            
            
        }
        
    }
    
}
