//
//  AnnouncementListServiceMock.swift
//  FTSearchTestLBCTests
//
//  Created by Mouldi GABSI on 05/03/2023.
//

import Foundation
@testable import FTSearchTestLBC

struct AnnouncementListServiceMock: AnnouncementListServiceProtocol {
    
    func fetchAnnouncementList(completion: @escaping (Result<[Announcement], NetworkError>) -> Void) {
        let announcements: [Announcement] = getMockAnnouncements()
        completion(.success(announcements))
    }
    
    func fetchCategories(completion: @escaping (Result<[LBCCategory], NetworkError>) -> Void) {
        let categories: [LBCCategory] = getMockCategories()
        completion(.success(categories))
    }
    
    func getMockCategories() -> [LBCCategory] {
        
        return [
            LBCCategory(id: 0, name: "All"),
            LBCCategory(id: 1, name: "Véhicule"),
            LBCCategory(id: 2, name: "Mode"),
            LBCCategory(id: 3, name: "Bricolage"),
            LBCCategory(id: 4, name: "Maison"),
            LBCCategory(id: 5, name: "Loisirs"),
            LBCCategory(id: 6, name: "Immobilier"),
            LBCCategory(id: 7, name: "Livres/CD/DVD"),
            LBCCategory(id: 8, name: "Multimédia"),
            LBCCategory(id: 9, name: "Service"),
            LBCCategory(id: 10, name: "Animaux"),
            LBCCategory(id: 11, name: "Enfants")
        ]
    }
    
    func getMockAnnouncements() -> [Announcement] {
        
        return [
            Announcement(id: 1664493117,
                         categoryID: 9,
                         title: "Professeur natif d'espagnol à domicile",
                         announcementDescription: "Doctorant espagnol, ayant fait des études de linguistique comparée français - espagnol et de traduction (thème/version) 0 la Sorbonne, je vous propose des cours d'espagnol à domicile à Paris intramuros. Actuellement j'enseigne l'espagnol dans un lycée et j'ai plus de cinq ans d'expérience comme professeur particulier, à Paris et à Madrid. Tous les niveaux, tous les âges. Je m'adapte à vos besoins et vous propose une méthode personnalisée et dynamique, selon vos point forts et vos points faibles, pour mieux travailler votre :  - Expression orale - Compréhension orale - Grammaire - Vocabulaire - Production écrite - Compréhension écrite Tarif : 25 euros/heure",
                         price:25.00,
                         imagesURL: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/af9c43ff5a3b3692f9f1aa3c17d7b46d8b740311.jpg",
                                             thumb:"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/af9c43ff5a3b3692f9f1aa3c17d7b46d8b740311.jpg"),
                         creationDate: "2019-11-05T15:56:55+0000",
                         isUrgent: false,
                         siret: "123 323 002"),
            Announcement(id: 1461267313,
                         categoryID: 4,
                         title: "Statue homme noir assis en plâtre polychrome",
                         announcementDescription: "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible",
                         price:140.00,
                         imagesURL: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
                                             thumb:"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"),
                         creationDate: "2019-11-05T15:56:59+0000",
                         isUrgent: true,
                         siret: nil),
            Announcement(id: 1691247255,
                         categoryID: 8,
                         title: "Pc portable hp elitebook 820 g1 core i5 4 go ram 250 go hdd",
                         announcementDescription: "= = = = = = = = = PC PORTABLE HP ELITEBOOK 820 G1 = = = = = = = = = # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # HP ELITEBOOK 820 G1 Processeur : Intel Core i5 4300M Fréquence : 2,60 GHz Mémoire : 4 GO DDR3 Disque Dur : 320 GO SATA Vidéo : Intel HD Graphics Lecteur Optique : Lecteur/Graveur CD/DVDRW Réseau : LAN 10/100 Système : Windows 7 Pro – 64bits Etat : Reconditionné  Garantie : 6 Mois Prix TTC : 199,00 € Boostez ce PC PORTABLE : Passez à la vitesse supérieure en augmentant la RAM : Passez de 4 à 6 GO de RAM pour 19€  Passez de 4 à 8 GO de RAM pour 29€  (ajout rapide, doublez la vitesse en 5 min sur place !!!) Stockez plus en augmentant la capacité de votre disque dur : Passez en 500 GO HDD pour 29€  Passez en 1000 GO HDD pour 49€  Passez en 2000 GO HDD pour 89€  Passez en SSD pour un PC 10 Fois plus rapide : Passez en 120 GO SSD pour 49€  Passez en 240 GO SSD pour 79€  Passez en 480 GO SSD pour 119€ # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # Nous avons plus de 300 Ordinateurs PC Portables. Visible en boutique avec une garantie de 6 mois vendu avec Facture TVA, pas de surprise !!!! Les prix varient en moyenne entre 150€ à 600€, PC Portables en stock dans notre boutique sur Paris. # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # KIATOO est une société qui regroupe à la fois: - PC Portable - PC de Bureau / Fixe - Chargeur PC Portable - Batterie PC Portable - Clavier PC Portable - Ventilateur PC Portable - Nappe LCD écran - Ecran LCD PC Portable - Mémoire PC Portable - Disque dur PC Portable - Inverter PC Portable - Connecteur Jack DC PC Portable ASUS, ACER, COMPAQ, DELL, EMACHINES, HP, IBM, LENOVO, MSI, PACKARD BELL, PANASONIC, SAMSUNG, SONY, TOSHIBA...",
                         price: 190.00,
                         imagesURL: ImageURL(small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/633f278423b9aa6b04fa9cc954079befd294473f.jpg",
                                             thumb:"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/633f278423b9aa6b04fa9cc954079befd294473f.jpg"),
                         creationDate: "2019-10-16T17:10:20+0000",
                         isUrgent: true,
                         siret: nil)
        ]
    }
    
}
