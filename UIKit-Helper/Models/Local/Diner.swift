//
//  Diner.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 22.02.2024.
//

import Foundation

protocol DinerCellProtocol {
    
    var title: String { get }
    var subtitle: String { get }
    var image: String { get }
    var rating: Int { get }
}

struct Diner: DinerCellProtocol {
    
    let title: String
    let subtitle: String
    let image: String
    let description: String
    let rating: Int
}

extension Diner {
    
    static var mockArray: [Self] {
        [Diner(title: "Erwin",
               subtitle: "Erwin is a seafood restaurant that occupies 2 floors of the building located at the bank of the Moscow River.",
               image: "erwin",
               description: "Erwin is a seafood restaurant that occupies 2 floors of the building located at the bank of the Moscow River. That’s just steps away from the Radisson Royal Hotel. Erwin has 230 seats inside plus a large summer verandah making it possible to seat almost 400 guests during summer months. They use local seafood products to prepare most of the dishes you'll find on the restaurant's menu. That's the main reason why a meal at Erwin can fit almost any budget. You can order a portion of local whitefish fillet for 580 Rubles or you can go with the King Crab from Murmansk that costs 9000 a piece. I can tell you that it’s a pretty big crab weighting almost 3 kilos (about 6 pounds)! Same thing with the drinks. You can order a bottle of some Spanish red wine for 3600 Rubles (about $100) or 2007 Brunello di Montalcino Tenuta Nuova for 15600 Rubles (about $260). Other dishes on the menu worth mentioning are all kinds of tartars and salads, seafood pastas, Russian and Pan Asian fish soups, several kinds of caviar.",
               rating: 5),
         Diner(title: "Kamyanitsa",
               subtitle: "Restaurant in Minsk, Belarus is a unique and popular establishment that combines the charm of the Middle Ages with traditional Belarusian cuisine.",
               image: "kamyanitsa",
               description: "Restaurant in Minsk, Belarus is a unique and popular establishment that combines the charm of the Middle Ages with traditional Belarusian cuisine. This restaurant has captured the hearts of those who have a passion for history, folk culture, and authentic local dishes. With its ambiance reminiscent of ancient times - featuring stone mills, stained glass windows, and low ceilings - Kamyanitsa offers an immersive experience for guests seeking a taste of medieval life.",
               rating: 4),
         Diner(title: "Wine and Crab",
               subtitle: "Restaurant has an extensive list of dishes made from several kinds of crab shipped here directly from the Russian Far East.",
               image: "winecrab",
               description: "Wine & Crab has an extensive list of dishes made from several kinds of crab shipped here directly from the Russian Far East. The most popular kinds include Blue King Crab, Spiny and Hairy crab. Checkout their Russian Pelmeni with crab for 620Rubles (10usd). These are very delicious, so as the crab cakes that cost 750 Rubles per portion (about 12usd). One of the local sommeliers can help you pick your perfect wine from more than 600 bottles available on the wine list. The restaurant is located in the basement of Teatralny Proezd – Moscow’s high fashion shopping street with all the high end designer brand boutiques.",
               rating: 4)]
    }
}
