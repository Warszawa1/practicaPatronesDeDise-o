//
//  HeroDTOToHeroModelMapper.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//

final class HeroDTOToHeroModelMapper {
    func map(_ dto: HeroDTO) -> HeroModel {
        HeroModel(identifier: dto.identifier,
                  name: dto.name,
                  description: dto.description,
                  photo: dto.photo,
                  favorite: dto.favorite)
    }
}
