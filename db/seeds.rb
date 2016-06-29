User.destroy_all
Prescription.destroy_all
Pill.destroy_all
User.create(username: "mrtennis209", password: "minh8989")
@prescription = Prescription.create(name: "Ba's schedule", user_id: User.first.id, active: true)
Pill.create(name: "tylenol", instruction: "take everyday", exp_date: 2016)
Pill.create(name: "Iron", instruction: "take every other day", exp_date: 2017)
Pill.create(name: "laxitive", instruction: "take before sleep", exp_date: 2018)