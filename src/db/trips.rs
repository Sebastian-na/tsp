use crate::db::connection::establish_connection;
use crate::db::models::trips::*;
use crate::db::users::{get_user_by_id};
use crate::utils::locations::Locations;
use crate::utils::path::Path;
use crate::schema;
use diesel::prelude::*;

pub fn get_trips_by_user_id(query_id: &i32) -> Result<Vec<Trip>, diesel::result::Error> {

    let user = get_user_by_id(&query_id).unwrap();
    
    let connection = &mut establish_connection();
    let results = Trip::belonging_to(&user)
        .load::<Trip>(connection)
        .expect("Error loading trips");

    Ok(results)
}

pub fn create_trip(
        user_id: &i32,
        title: &String,
        locations: &Locations,
        path: &Path,
        distance: &f64,
        completed: &bool,
        created_on: &diesel::dsl::now
    ) -> Result<Vec<Trip>, diesel::result::Error> {
        use schema::trips;
        let connection = &mut establish_connection();
        let new_trip: NewTrip = NewTrip {
            user_id,
            title,
            locations: &serde_json::to_value(locations).unwrap(),
            path: &serde_json::to_value(path).unwrap(),
            distance,
            completed,
            created_on,
        };

        diesel::insert_into(trips::table)
            .values(&new_trip)
            .get_results::<Trip>(connection)
    }