# User IDs 1-5 belong to Hosts / 6-10 belong to bands

# Performances

Performance.create(status: "scheduled", requester_id: nil, performance_date: "2016-02-18", location: "San Francisco, CA", band_id: 6, tour_id: 1, host_id: nil, agree: false)
Performance.create(status: "confirmed", requester_id: 6, performance_date: "2016-02-15", location: "San Diego, CA", band_id: 6, tour_id: 1, host_id: 3, agree: true)
Performance.create(status: "pending", requester_id: 6, performance_date: "2016-02-17", location: "San Jose, CA", band_id: 6, tour_id: 1, host_id: nil, agree: false)
Performance.create(status: "confirmed", requester_id: 6, performance_date: "2016-02-19", location: "Sacramento, CA", band_id: 6, tour_id: 1, host_id: 4, agree: true)
Performance.create(status: "pending", requester_id: 6, performance_date: "2016-02-16", location: "Los Angeles, CA", band_id: 6, tour_id: 1, host_id: nil, agree: false)

# Shows
Show.create(venue:"Joe's Chicken Shack", show_date: "2016-02-18", location: "San Francisco, CA", slots: 3, host_id: 2, booked: false)
Show.create(venue:"Cowabungalow", show_date: "2016-02-15", location: "San Diego, CA", slots: 5, host_id: 3, booked: false)
Show.create(venue:"The Terrorarium", show_date: "2016-02-17", location: "San Jose, CA", slots: 2, host_id: 1, booked: false)
Show.create(venue:"The Cathouse", show_date: "2016-02-19", location: "Sacramento, CA", slots: 4, host_id: 4, booked: false)
Show.create(venue:"The Wvlf Shaq", show_date: "2016-02-16", location: "Los Angeles, CA", slots: 3, host_id: 5, booked: false)

# Tours
Tour.create(name:"The Growing Up Tour", band_id: 6)
Tour.create(name:"Winter Sled Tour", band_id: 7)
Tour.create(name:"Slow Down Tour", band_id: 8)
Tour.create(name:"Falling Up Tour", band_id: 8)
Tour.create(name:"Sidewalk Ends Tour", band_id: 9)

# Hosts
User.create(name: "John", email: "john@john.com", password: "123456", password_confirmation: "123456", about: "Small town venue", location: "San Jose, CA", type: "Host" )
User.create(name: "Sam", email: "sam@sam.com", password: "123456", password_confirmation: "123456", about: "Killer shows", location: "San Francisco, CA", type: "Host" )
User.create(name: "Oskar", email: "oskar@oskar.com", password: "123456", password_confirmation: "123456", about: "Super fun pizza joint", location: "San Diego, CA", type: "Host" )
User.create(name: "Jameson", email: "jameson@jameson.com", password: "123456", password_confirmation: "123456", about: "Dive bar", location: "Sacramento, CA", type: "Host" )  
User.create(name: "Anthony", email: "anthony@anthony.com", password: "123456", password_confirmation: "123456", about: "My mom's basement", location: "Los Angeles, CA", type: "Host" )
  
# Bands
User.create(name: "Slime Lab", email: "sl@sl.com", password: "123456", password_confirmation: "123456", about: "Slow Dive worship", location: "San Jose, CA", type: "Band" )
User.create(name: "Sugar Sticks", email: "ss@ss.com", password: "123456", password_confirmation: "123456", about: "Synth-Pop", location: "San Francisco, CA", type: "Band" )
User.create(name: "The Cough Meds", email: "tcm@tcm.com", password: "123456", password_confirmation: "123456", about: "Gangster Rap", location: "San Diego, CA", type: "Band" )
User.create(name: "Sly Dog", email: "sd@sd.com", password: "123456", password_confirmation: "123456", about: "Smooth Jazz", location: "Sacramento, CA", type: "Band" )  
User.create(name: "Red Tail", email: "rt@rt.com", password: "123456", password_confirmation: "123456", about: "Your mom's favorite bathtime CD", location: "Los Angeles, CA", type: "Band" )
