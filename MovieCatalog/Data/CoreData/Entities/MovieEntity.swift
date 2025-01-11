//
//  MovieEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import CoreData

@objc(MovieEntity)
final class MovieEntity: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String?
    @NSManaged var poster: String?
    @NSManaged var year: Int32
    @NSManaged var country: String?
    @NSManaged var time: Int32
    @NSManaged var tagline: String?
    @NSManaged var movieDescription: String?
    @NSManaged var director: String?
    @NSManaged var budget: Int32
    @NSManaged var fees: Int32
    @NSManaged var ageLimit: Int32
    @NSManaged var isFavorite: Bool
    @NSManaged var genres: NSSet?
    @NSManaged var reviews: NSSet?

    convenience init(from movie: Movie, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        
        id = movie.id
        name = movie.name
        poster = movie.poster
        year = Int32(movie.year)
        country = movie.country
        time = Int32(movie.time)
        tagline = movie.tagline
        movieDescription = movie.description
        director = movie.director
        budget = Int32(movie.budget ?? 0)
        fees = Int32(movie.fees ?? 0)
        ageLimit = Int32(movie.ageLimit)
        isFavorite = movie.isFavorite
        
        if let genres = movie.genres {
            self.genres = NSSet(array: genres.map { $0.toEntity(context: context) })
        }
        
        if let reviews = movie.reviews {
            self.reviews = NSSet(array: reviews.map { $0.toEntity(context: context) })
        }
    }
}

extension MovieEntity {
    func toDomain() -> Movie {
        Movie(
            id: id,
            name: name,
            poster: poster,
            year: Int(year),
            country: country,
            genres: (genres?.allObjects as? [GenreEntity])?.map { $0.toDomain() },
            reviews: (reviews?.allObjects as? [ReviewEntity])?.map { $0.toDomain() },
            time: Int(time),
            tagline: tagline,
            description: movieDescription,
            director: director,
            budget: Int(budget),
            fees: Int(fees),
            ageLimit: Int(ageLimit),
            isFavorite: isFavorite
        )
    }

    func update(from movieEntity: MovieEntity, context: NSManagedObjectContext) {
        id = movieEntity.id
        name = movieEntity.name
        poster = movieEntity.poster
        year = movieEntity.year
        country = movieEntity.country
        time = movieEntity.time
        tagline = movieEntity.tagline
        movieDescription = movieEntity.movieDescription
        director = movieEntity.director
        budget = movieEntity.budget
        fees = movieEntity.fees
        ageLimit = movieEntity.ageLimit
        isFavorite = movieEntity.isFavorite

        if let genres = movieEntity.genres as? Set<GenreEntity> {
            self.genres = NSSet(set: genres)
        }

        if let reviews = movieEntity.reviews as? Set<ReviewEntity> {
            self.reviews = NSSet(set: reviews)
        }
    }
}

extension MovieEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }
}
