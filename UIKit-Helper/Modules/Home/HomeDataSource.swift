//
//  HomeDataSource.swift
//  UIKit-Helper
//
//  Created by Pavel Koyushev on 20.10.2023.
//

import UIKit
import RxDataSources
import RxCocoa

protocol TitleButtonCellProtocol {
    
    var title: String { get }
    var step: AppStep { get }
}

struct TitleButtonCellModel: TitleButtonCellProtocol {
    
    let title: String
    let step: AppStep
}

protocol BestGuideProtocol {
    
    var name: String { get }
    var photo: String { get }
}

struct BestGuide: BestGuideProtocol {
    
    let name: String
    let photo: String
    let info: String
}

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

protocol PromoCityCellProtocol {
    
    var city: String { get }
    var country: String { get }
    var imageName: String { get }
}

struct PromoTourModel: PromoCityCellProtocol {
    
    let city: String
    let country: String
    let imageName: String
    
    let description: String
}

enum HomeScreenItem {
    
    case promoCity(model: [PromoTourModel])
    case diner(model: [Diner], selected: PublishRelay<Diner>)
    case bestGuide(model: [BestGuide])
    case titleButton(model: TitleButtonCellProtocol)
}

final class HomeScreenDataSource {
    
    typealias SectionType = SectionModel<String, HomeScreenItem>
    typealias DataSource = RxTableViewSectionedReloadDataSource<SectionType>
    
    let dataSource = DataSource { (dataSource, tableView, indexPath, _) -> UITableViewCell in
        switch dataSource[indexPath] {
            
        case .promoCity(model: let model):
            return CodeCellBuilder<PromoCityTableViewCell>.build(tableView: tableView,
                                                                 indexPath: indexPath,
                                                                 model: model)
        case let .diner(model: model, selected: selected):
            return CodeSelectedCellBuilder<DinerTableViewCell>.build(tableView: tableView,
                                                                     indexPath: indexPath,
                                                                     model: model,
                                                                     selected: selected)
        case .bestGuide(model: let model):
            return CodeCellBuilder<BestGuideTableViewCell>.build(tableView: tableView,
                                                                 indexPath: indexPath,
                                                                 model: model)
        case .titleButton(model: let model):
            return CodeCellBuilder<TitleButtonTableViewCell>.build(tableView: tableView,
                                                                   indexPath: indexPath,
                                                                   model: model)
        }
        
    }
}

struct HomeScreenBuilder {
    
    typealias SectionType = SectionModel<String, HomeScreenItem>
    
    static func build(promoTour: [PromoTourModel],
                      diner: [Diner],
                      bestGuides: [BestGuide],
                      selectedDiner: PublishRelay<Diner>) -> [SectionType] {
        
        var items = [HomeScreenItem]()
        
        let titlePromoTours = TitleButtonCellModel(title: "Promo Tours",
                                                   step: .other)
        let promoToursTitle = HomeScreenItem.titleButton(model: titlePromoTours)
        
        let promoTours = HomeScreenItem.promoCity(model: promoTour)
        items.append(promoToursTitle)
        items.append(promoTours)
        
        let titleDiners = TitleButtonCellModel(title: "Diners",
                                               step: .dinersList)
        let dinersTitle = HomeScreenItem.titleButton(model: titleDiners)
        
        let diners = HomeScreenItem.diner(model: diner, selected: selectedDiner)
        items.append(dinersTitle)
        items.append(diners)
        
        let titleGuides = TitleButtonCellModel(title: "Guides",
                                               step: .other)
        let bestGuidesTitle = HomeScreenItem.titleButton(model: titleGuides)
        
        let bestGuides = HomeScreenItem.bestGuide(model: bestGuides)
        items.append(bestGuidesTitle)
        items.append(bestGuides)
        
        let sections = [SectionType(model: "HomeList",
                                    items: items)]
        
        return sections
    }
    
}
