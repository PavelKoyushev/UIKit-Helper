//
//  HomeViewModel.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 16.10.2023.
//

import RxSwift
import RxCocoa
import RxFlow
import RxDataSources

final class HomeViewModel: Stepper {
    
    let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    
    private let tours: [PromoTourModel] = [PromoTourModel(city: "Moscow",
                                                          country: "Russia",
                                                          imageName: "moscow",
                                                          description: "Great City"),
                                           PromoTourModel(city: "Minsk",
                                                          country: "Belarus",
                                                          imageName: "minsk",
                                                          description: "Great City 2"),
                                           PromoTourModel(city: "Kazan",
                                                          country: "Russia",
                                                          imageName: "kazan",
                                                          description: "Great City 2"),
                                           PromoTourModel(city: "Saint Petersburg",
                                                          country: "Russia",
                                                          imageName: "piter",
                                                          description: "Great City 2"),
                                           PromoTourModel(city: "Astana",
                                                          country: "Kazakhstan",
                                                          imageName: "astana",
                                                          description: "Great City 2")]
    
    private let diners: [Diner] = [Diner(title: "Erwin",
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
    
    private let guides: [BestGuide] = [BestGuide(name: "Mary J.", photo: "mary", info: ""),
                                       BestGuide(name: "Dan S.", photo: "dan", info: ""),
                                       BestGuide(name: "Ian R.", photo: "ian", info: ""),
                                       BestGuide(name: "Sabina A.", photo: "sabina", info: "1"),
                                       BestGuide(name: "Emily C.", photo: "emily", info: "2"),
                                       BestGuide(name: "Antony M.", photo: "antony", info: "3")]
    
    struct Input {
        let onDidLoad: Observable<Void>
    }
    
    struct Output {
        let sections: Driver<[HomeScreenDataSource.SectionType]>
        let dataSource = HomeScreenDataSource().dataSource
    }
    
}
extension HomeViewModel {
    
    typealias SectionType = SectionModel<String, HomeScreenItem>
    
    func transform(input: Input) -> Output {
        
        let sections = BehaviorRelay<[SectionType]>(value: [])
        
        let popularCities = BehaviorRelay<[PromoTourModel]>(value: [])
        let diners = BehaviorRelay<[Diner]>(value: [])
        let bestGuides = BehaviorRelay<[BestGuide]>(value: [])
        
        let dinerTap = PublishRelay<Diner>()
        
        input.onDidLoad
            .map { [weak self] in
                self?.tours ?? []
            }
            .bind(to: popularCities)
            .disposed(by: disposeBag)
        
        input.onDidLoad
            .map { [weak self] in
                self?.guides ?? []
            }
            .bind(to: bestGuides)
            .disposed(by: disposeBag)
        
        input.onDidLoad
            .map { [weak self] in
                self?.diners ?? []
            }
            .bind(to: diners)
            .disposed(by: disposeBag)
        
        let screen = Observable.combineLatest(popularCities, diners, bestGuides)
        
        screen
            .map {
                HomeScreenBuilder.build(promoTour: $0.0,
                                        diner: $0.1,
                                        bestGuides: $0.2,
                                        selectedDiner: dinerTap)
            }
            .bind(to: sections)
            .disposed(by: disposeBag)
        
        dinerTap
            .map { AppStep.diner(model: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
                                              
        let output = Output(sections: sections.asDriver(onErrorJustReturn: []))
        
        return output
    }
}
