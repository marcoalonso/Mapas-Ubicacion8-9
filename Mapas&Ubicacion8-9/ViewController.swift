//
//  ViewController.swift
//  Mapas&Ubicacion8-9
//
//  Created by marco alonso on 28/10/20.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var manager = CLLocationManager()
    var latitud : CLLocationDegrees!
    var longitud : CLLocationDegrees!
    

    @IBOutlet weak var Mapa: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //aqui se implementan los delegados
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        
        manager.desiredAccuracy = kCLLocationAccuracyBest     //obtenga la mejor precision de ubicacion
        manager.startUpdatingLocation()   //Empieza a actualizar la ubicacion del GPS
    }

    @IBAction func GetLocation(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title: "Ubicacion", message: "Las coordenadas de tu ubicacion son: ", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            print("Coordenadas")
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let actionVerMas = UIAlertAction(title: "Ver mas...", style: .default) { (_) in
            let localizacion = CLLocationCoordinate2DMake(self.latitud, self.longitud)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: localizacion, span: span)
            self.Mapa.setRegion(region, animated: true)
            self.Mapa.showsUserLocation = true
        }
        
        alerta.addAction(actionAceptar)
        alerta.addAction(actionVerMas)
        
        present(alerta, animated: true, completion: nil)
        
    }
    
}


//Utiliza los Delegados de ClLocation
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            //print(locations.first!)
            self.latitud = location.coordinate.latitude
            self.longitud = location.coordinate.longitude
        }
    }
    
    
    
}
