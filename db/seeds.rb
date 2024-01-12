# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'withbeer@withbeer',
   password: 'withbeer'
)

Tag.create([
    { name: '和食' },
    { name: '洋食' },
    { name: '中華'},
    { name: 'イタリアン'},
    { name: 'フレンチ'},
    { name: 'こってり'},
    { name: 'さっぱり'},
    { name: '5分以内' },
    { name: '10分以内'},
    { name: '15分以内'},
    { name: '20分以内'},
    { name: '25分以内'}
    ])
    