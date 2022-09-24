10.times do |n|
  Student.create!(
    email: "test#{n + 1}@test.com",
    name: "テスト太郎#{n + 1}",
    self_introduction: "初めましてコンヴァンんは",
    password: "foobar"
  )
end
